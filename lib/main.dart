import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'core/storage.dart';
import 'core/tray_setup.dart';
import 'core/hotkey_setup.dart';
import 'core/startup_setup.dart';
import 'core/notification_setup.dart';
import 'pet/pet_window.dart';

import 'package:hotkey_manager/hotkey_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Init local storage (Isar)
  await Storage.init();
  
  // 2. Load saved pet config
  final config = await Storage.getConfig();

  // 3. Init Window Manager
  await windowManager.ensureInitialized();

  // 4. Init Startup and Hotkeys
  await SystemStartupManager.init();
  await SystemHotkeyManager().init();

  // 5. Init Notifications
  await SystemNotificationManager().init();

  WindowOptions windowOptions = WindowOptions(
    size: Size(config.size, config.size),
    center: false,
    backgroundColor: Colors.transparent,
    skipTaskbar: true, // Hide from taskbar, we will use tray
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setHasShadow(false);
    
    // Move to saved position
    await windowManager.setPosition(Offset(config.positionX, config.positionY));
    
    await windowManager.show();
    await windowManager.focus();
    
    // 4. Init Tray (after window is ready)
    await SystemTrayManager().init();
  });

  runApp(const ProviderScope(child: DesktopPetApp()));
}

class DesktopPetApp extends StatelessWidget {
  const DesktopPetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desktop Pet AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PetWindow(),
    );
  }
}
