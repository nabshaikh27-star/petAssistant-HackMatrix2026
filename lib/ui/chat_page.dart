import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screen_capturer/screen_capturer.dart';
import '../ai_assistant/chat_provider.dart';
import '../ai_assistant/offline_service.dart';
import '../models/chat_message.dart';
import 'capture_permission_dialog.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  String? _pendingImagePath;

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _captureScreen(CaptureType type) async {
    // Step 1: Show explicit permission dialog — REQUIRED
    final allowed = await showCapturePermissionDialog(context, type);
    if (!allowed) return;

    // Step 2: Show persistent banner during capture
    ref.read(isCapturingProvider.notifier).state = true;

    try {
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/capture_${DateTime.now().millisecondsSinceEpoch}.png';

      final mode = type == CaptureType.fullScreen
          ? CaptureMode.screen
          : CaptureMode.region;

      await screenCapturer.capture(
        mode: mode,
        imagePath: path,
        silent: false,
      );

      if (File(path).existsSync()) {
        setState(() => _pendingImagePath = path);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Screen capture failed. Please try again.')),
        );
      }
    } finally {
      // Step 3: Remove banner as soon as capture completes
      ref.read(isCapturingProvider.notifier).state = false;
    }
  }

  Future<void> _send() async {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty && _pendingImagePath == null) return;

    final imagePath = _pendingImagePath;
    _inputCtrl.clear();
    setState(() => _pendingImagePath = null);

    await ref.read(chatProvider.notifier).sendMessage(
      text: text.isEmpty ? '(Image attached — please analyze it)' : text,
      imagePath: imagePath,
    );
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final chatAsync = ref.watch(chatProvider);
    final isOnlineAsync = ref.watch(isOnlineProvider);
    final isOnline = isOnlineAsync.valueOrNull ?? true;
    final isCapturing = ref.watch(isCapturingProvider);
    final petIsTyping = ref.watch(petIsTypingProvider);

    chatAsync.whenData((_) => _scrollToBottom());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chat with Pet 🐾'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Clear chat history',
            onPressed: () async {
              final ok = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Clear History?'),
                  content: const Text('This will delete all chat messages.'),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                    ElevatedButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Clear')),
                  ],
                ),
              );
              if (ok == true) ref.read(chatProvider.notifier).clearHistory();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Offline banner ─────────────────────────────────────────────
          if (!isOnline)
            Container(
              width: double.infinity,
              color: Colors.orange.shade100,
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Icon(Icons.wifi_off, size: 16, color: Colors.orange),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'No internet connection — AI chat requires connection. History still available.',
                      style: TextStyle(fontSize: 12, color: Colors.brown),
                    ),
                  ),
                ],
              ),
            ),

          // ── Capture banner (hard requirement) ──────────────────────────
          if (isCapturing) const CapturingBanner(),

          // ── Message list ───────────────────────────────────────────────
          Expanded(
            child: chatAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error loading chat: $e')),
              data: (messages) => messages.isEmpty
                  ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('👋', style: TextStyle(fontSize: 48)),
                          SizedBox(height: 12),
                          Text('Say something to your pet!',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  : ListView.builder(
                      controller: _scrollCtrl,
                      padding: const EdgeInsets.all(12),
                      itemCount: messages.length + (petIsTyping ? 0 : 0),
                      itemBuilder: (_, i) => _MessageBubble(messages[i]),
                    ),
            ),
          ),

          // ── Typing indicator ───────────────────────────────────────────
          if (petIsTyping)
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 4),
              child: Row(
                children: [
                  Text('🐾 Pet is typing', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  SizedBox(width: 4),
                  _TypingDots(),
                ],
              ),
            ),

          // ── Image preview ──────────────────────────────────────────────
          if (_pendingImagePath != null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.file(
                      File(_pendingImagePath!),
                      height: 60,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(child: Text('Screenshot attached', style: TextStyle(fontSize: 12))),
                  IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () => setState(() => _pendingImagePath = null),
                  ),
                ],
              ),
            ),

          // ── Input row ──────────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: Row(
              children: [
                // Screen capture button
                PopupMenuButton<CaptureType>(
                  icon: const Icon(Icons.attach_file),
                  tooltip: 'Attach screenshot',
                  enabled: isOnline,
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: CaptureType.fullScreen,
                      child: ListTile(
                        leading: Icon(Icons.monitor),
                        title: Text('Full Screen'),
                        dense: true,
                      ),
                    ),
                    const PopupMenuItem(
                      value: CaptureType.region,
                      child: ListTile(
                        leading: Icon(Icons.crop),
                        title: Text('Select Region'),
                        dense: true,
                      ),
                    ),
                  ],
                  onSelected: (type) => _captureScreen(type),
                ),

                // Text field
                Expanded(
                  child: TextField(
                    controller: _inputCtrl,
                    enabled: isOnline,
                    decoration: InputDecoration(
                      hintText: isOnline
                          ? 'Ask your pet anything…'
                          : 'Offline — connect to use AI chat',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => isOnline ? _send() : null,
                    maxLines: 3,
                    minLines: 1,
                  ),
                ),
                const SizedBox(width: 8),

                // Send button
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: isOnline && !petIsTyping ? _send : null,
                  color: isOnline ? Colors.blue : Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Message bubble widget
// ─────────────────────────────────────────────────────────────────────────────
class _MessageBubble extends StatelessWidget {
  final ChatMessage message;
  const _MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    final isUser = message.sender == 'user';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser)
            const Padding(
              padding: EdgeInsets.only(right: 6, bottom: 4),
              child: CircleAvatar(
                radius: 14,
                child: Text('🐾', style: TextStyle(fontSize: 14)),
              ),
            ),
          Flexible(
            child: Column(
              crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                // Image attachment
                if (message.attachedImagePath != null &&
                    File(message.attachedImagePath!).existsSync())
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        File(message.attachedImagePath!),
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                // Text bubble
                if (message.text.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey.shade100,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isUser ? 16 : 4),
                        bottomRight: Radius.circular(isUser ? 4 : 16),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (isUser)
            const Padding(
              padding: EdgeInsets.only(left: 6, bottom: 4),
              child: CircleAvatar(
                radius: 14,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 16, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Animated typing indicator
// ─────────────────────────────────────────────────────────────────────────────
class _TypingDots extends StatefulWidget {
  const _TypingDots();

  @override
  State<_TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<_TypingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final t = _ctrl.value;
        return Row(
          children: List.generate(3, (i) {
            final opacity = (((t * 3) - i) % 1.0).clamp(0.2, 1.0);
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Opacity(
                opacity: opacity,
                child: const Text('●', style: TextStyle(fontSize: 8, color: Colors.grey)),
              ),
            );
          }),
        );
      },
    );
  }
}
