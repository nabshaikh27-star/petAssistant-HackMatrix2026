import 'dart:isolate';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:rive/rive.dart' hide Image;
import 'package:isar/isar.dart';
import '../core/storage.dart';
import '../models/pet_config.dart';
import '../core/scheduler_isolate.dart';
import '../core/notification_setup.dart';
import '../ui/radial_menu.dart';
import '../ui/settings_page.dart';
import '../ui/chat_page.dart';
import '../core/animation_state.dart';

class PetWindow extends StatefulWidget {
  const PetWindow({super.key});

  @override
  State<PetWindow> createState() => _PetWindowState();
}

class _PetWindowState extends State<PetWindow> with WindowListener, TickerProviderStateMixin {
  late ReceivePort _receivePort;
  String? _avatarPath;
  
  late AnimationController _bobController;
  late Animation<double> _bobAnimation;
  
  late AnimationController _shakeController;
  late Animation<double> _shakeAnimation;
  
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    windowManager.setPreventClose(true);

    _initScheduler();
    _loadConfig();
    _setupBobbingAnimation();
    
    // Listen to changes in PetConfig (specifically when the user updates the avatar)
    Storage.isar.petConfigs.watchLazy().listen((_) {
      if (mounted) {
        _loadConfig();
      }
    });

    PetAnimationController().state.addListener(_onAnimationStateChanged);
  }

  void _onAnimationStateChanged() {
    if (mounted) setState(() {});
  }

  Future<void> _loadConfig() async {
    final config = await Storage.getConfig();
    if (mounted) {
      setState(() {
        _avatarPath = config.petImagePath;
      });
    }
  }

  void _setupBobbingAnimation() {
    // Idle: slow bobbing
    _bobController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))..repeat(reverse: true);
    _bobAnimation = Tween<double>(begin: -8.0, end: 8.0).animate(CurvedAnimation(parent: _bobController, curve: Curves.easeInOutSine));

    // Alert: fast shake
    _shakeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 100))..repeat(reverse: true);
    _shakeAnimation = Tween<double>(begin: -10.0, end: 10.0).animate(CurvedAnimation(parent: _shakeController, curve: Curves.linear));

    // Talking: pulse scale
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800))..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
  }

  Future<void> _initScheduler() async {
    _receivePort = ReceivePort();
    _receivePort.listen((message) {
      if (message is SchedulerMessage) {
        if (message.action == 'show_notification') {
          print("RIVE MOCK: Received show_notification from isolate!");
          final parts = message.payload!.split('||');
          final title = parts[1] == 'true' ? '🎂 Birthday!' : '⏰ Reminder';
          SystemNotificationManager().showNotification(
            id: DateTime.now().millisecond,
            title: title,
            body: parts[0],
          );
        } else if (message.action == 'play_alert') {
          print("RIVE MOCK: Playing ALERT animation state!");
          PetAnimationController().setAlert();
          Future.delayed(const Duration(seconds: 5), () {
            if (PetAnimationController().state.value == PetAnimationState.alert) {
              PetAnimationController().setIdle();
            }
          });
        } else if (message.action == 'play_celebrate') {
          print("RIVE MOCK: Playing CELEBRATE animation state!");
          PetAnimationController().setAlert();
          Future.delayed(const Duration(seconds: 5), () => PetAnimationController().setIdle());
        }
      }
    });

    final dir = await getApplicationDocumentsDirectory();
    await SchedulerIsolate.spawn(_receivePort.sendPort, dir.path);
  }

  @override
  void dispose() {
    PetAnimationController().state.removeListener(_onAnimationStateChanged);
    _bobController.dispose();
    _shakeController.dispose();
    _pulseController.dispose();
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void onWindowMoved() async {
    // Save new position when dragging finishes or moves
    final position = await windowManager.getPosition();
    await Storage.savePosition(position.dx, position.dy);
  }

  @override
  void onWindowClose() async {
    // Minimize to tray instead of closing
    bool isPreventClose = await windowManager.isPreventClose();
    if (isPreventClose) {
      windowManager.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onPanStart: (details) {
          windowManager.startDragging();
        },
        onTap: () async {
          // Single tap → open AI Chat
          await windowManager.setSize(const Size(420, 600));
          if (!mounted) return;
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ChatPage()),
          );
          final config = await Storage.getConfig();
          await windowManager.setSize(Size(config.size, config.size));
        },
        onSecondaryTap: () async {
          // Expand window so we can see the quick access menu clearly
          await windowManager.setSize(const Size(400, 500));
          
          if (!mounted) return;
          await showDialog(
            context: context,
            builder: (context) {
              // import radial menu lazily to avoid circular imports if needed
              return RadialMenuOverlay(
                onClose: () => Navigator.pop(context),
              );
            },
          );

          // Shrink back to normal pet size when closed
          final config = await Storage.getConfig();
          await windowManager.setSize(Size(config.size, config.size));
        },
        child: Center(
          child: _avatarPath != null && File(_avatarPath!).existsSync()
              ? AnimatedBuilder(
                  animation: Listenable.merge([_bobController, _shakeController, _pulseController]),
                  builder: (context, child) {
                    final state = PetAnimationController().state.value;
                    
                    Widget transformed = child!;
                    
                    if (state == PetAnimationState.idle) {
                      transformed = Transform.translate(offset: Offset(0, _bobAnimation.value), child: transformed);
                    } else if (state == PetAnimationState.alert) {
                      transformed = Transform.translate(offset: Offset(_shakeAnimation.value, 0), child: transformed);
                    } else if (state == PetAnimationState.talking) {
                      transformed = Transform.scale(scale: _pulseAnimation.value, child: transformed);
                    }
                    
                    return transformed;
                  },
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: Image.file(
                      File(_avatarPath!),
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const RiveAnimation.network(
                        'https://cdn.rive.app/animations/vehicles.riv', 
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                )
              : const SizedBox(
                  width: 150,
                  height: 150,
                  child: RiveAnimation.network(
                    'https://cdn.rive.app/animations/vehicles.riv', 
                    fit: BoxFit.contain,
                  ),
                ),
        ),
      ),
    );
  }
}
