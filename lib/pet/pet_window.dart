import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:window_manager/window_manager.dart';
import 'package:rive/rive.dart';
import '../core/storage.dart';
import '../core/scheduler_isolate.dart';
import '../core/notification_setup.dart';
import '../core/storage.dart';
import '../ui/radial_menu.dart';
import '../ui/settings_page.dart';
import '../ui/chat_page.dart';

class PetWindow extends StatefulWidget {
  const PetWindow({super.key});

  @override
  State<PetWindow> createState() => _PetWindowState();
}

class _PetWindowState extends State<PetWindow> with WindowListener {
  late ReceivePort _receivePort;

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    windowManager.setPreventClose(true);

    _initScheduler();
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
          // When you add a real .riv, trigger the state machine input here
        } else if (message.action == 'play_celebrate') {
          print("RIVE MOCK: Playing CELEBRATE animation state!");
          // When you add a real .riv, trigger the state machine input here
        }
      }
    });

    final dir = await getApplicationDocumentsDirectory();
    await SchedulerIsolate.spawn(_receivePort.sendPort, dir.path);
  }

  @override
  void dispose() {
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
              return RadialMenuOverlay(
                onClose: () => Navigator.pop(context),
              );
            },
          );

          // Shrink back to normal pet size when closed
          final config = await Storage.getConfig();
          await windowManager.setSize(Size(config.size, config.size));
        },
        child: const Center(
          // For testing without a local asset, we use a network Rive animation.
          // Once you download one, replace this with RiveAnimation.asset('assets/idle.riv')
          child: SizedBox(
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
