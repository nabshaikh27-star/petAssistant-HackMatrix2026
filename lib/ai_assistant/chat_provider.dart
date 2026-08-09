import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import '../models/chat_message.dart';
import '../core/storage.dart';
import 'api_service.dart';
import 'offline_service.dart';

// ── Provider exposing the chat message list ───────────────────────────────────
final chatProvider =
    AsyncNotifierProvider<ChatNotifier, List<ChatMessage>>(ChatNotifier.new);

// ── Tracks whether the pet is currently typing a streaming response ───────────
final petIsTypingProvider = StateProvider<bool>((ref) => false);

// ── Tracks screen capture status (for persistent banner) ─────────────────────
final isCapturingProvider = StateProvider<bool>((ref) => false);

// ─────────────────────────────────────────────────────────────────────────────
class ChatNotifier extends AsyncNotifier<List<ChatMessage>> {
  @override
  Future<List<ChatMessage>> build() async {
    return _loadFromDb();
  }

  Future<List<ChatMessage>> _loadFromDb() async {
    return Storage.isar.chatMessages
        .where()
        .sortByTimestamp()
        .findAll();
  }

  Future<void> sendMessage({
    required String text,
    String? imagePath,
  }) async {
    // Check online before attempting API call
    final isOnline = await checkIsOnline();
    if (!isOnline) return; // UI already shows the offline banner

    final messages = state.valueOrNull ?? [];

    // 1. Persist user message
    final userMsg = ChatMessage()
      ..id = '${DateTime.now().millisecondsSinceEpoch}_user'
      ..sender = 'user'
      ..text = text
      ..timestamp = DateTime.now()
      ..attachedImagePath = imagePath;

    await Storage.isar.writeTxn(() async {
      await Storage.isar.chatMessages.put(userMsg);
    });

    // 2. Create a placeholder for the streaming pet response
    final petMsg = ChatMessage()
      ..id = '${DateTime.now().millisecondsSinceEpoch}_pet'
      ..sender = 'pet'
      ..text = ''
      ..timestamp = DateTime.now();

    await Storage.isar.writeTxn(() async {
      await Storage.isar.chatMessages.put(petMsg);
    });

    state = AsyncData([...messages, userMsg, petMsg]);
    ref.read(petIsTypingProvider.notifier).state = true;

    // 3. Build history for API (last 20 turns to stay within token limits)
    final history = [...messages, userMsg].take(20).map((m) => {
      'role': m.sender == 'user' ? 'user' : 'assistant',
      'content': m.text,
    }).toList();

    // 4. Stream Gemini response
    String accumulated = '';
    try {
      await for (final delta in AiApiService.streamChat(
        messages: history,
        imagePath: imagePath,
      )) {
        accumulated += delta;

        // Update in-memory state for live streaming feel
        final updated = List<ChatMessage>.from(state.valueOrNull ?? []);
        final idx = updated.indexWhere((m) => m.id == petMsg.id);
        if (idx != -1) {
          updated[idx] = ChatMessage()
            ..isarId = petMsg.isarId
            ..id = petMsg.id
            ..sender = 'pet'
            ..text = accumulated
            ..timestamp = petMsg.timestamp;
          state = AsyncData(updated);
        }
      }
    } finally {
      ref.read(petIsTypingProvider.notifier).state = false;
    }

    // 5. Persist final pet response
    petMsg.text = accumulated;
    await Storage.isar.writeTxn(() async {
      await Storage.isar.chatMessages.put(petMsg);
    });

    state = AsyncData(await _loadFromDb());
  }

  Future<void> clearHistory() async {
    await Storage.isar.writeTxn(() async {
      await Storage.isar.chatMessages.clear();
    });
    state = const AsyncData([]);
  }
}
