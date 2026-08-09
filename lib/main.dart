import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_manager/window_manager.dart';

import 'core/storage.dart';
import 'core/tray_setup.dart';
import 'core/hotkey_setup.dart';
import 'core/startup_setup.dart';
import 'core/notification_setup.dart';
import 'pet/pet_window.dart';
import 'ui/onboarding_screen.dart';
import 'ui/theme.dart';
import 'ai_assistant/key_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

final themeProvider = StateProvider<ThemeMode>((ref) => ThemeMode.dark);

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

  bool hasOnboarded = await SecureKeyStorage.hasCompletedOnboarding();
  bool isDark = await SecureKeyStorage.isDarkMode();

  WindowOptions windowOptions = WindowOptions(
    size: hasOnboarded ? Size(config.size, config.size) : const Size(600, 500),
    center: !hasOnboarded,
    backgroundColor: Colors.transparent,
    skipTaskbar: true, // Hide from taskbar, we will use tray
    titleBarStyle: TitleBarStyle.hidden,
    alwaysOnTop: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setAsFrameless();
    await windowManager.setHasShadow(false);
    
    if (hasOnboarded) {
      await windowManager.setPosition(Offset(config.positionX, config.positionY));
    }
    
    await windowManager.show();
    await windowManager.focus();
    
    // 4. Init Tray (after window is ready)
    await SystemTrayManager().init();
  });

  runApp(ProviderScope(
    overrides: [
      themeProvider.overrideWith((ref) => isDark ? ThemeMode.dark : ThemeMode.light),
    ],
    child: DesktopPetApp(hasOnboarded: hasOnboarded),
  ));
}

class DesktopPetApp extends ConsumerWidget {
  final bool hasOnboarded;
  const DesktopPetApp({super.key, required this.hasOnboarded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Desktop Pet AI',
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: hasOnboarded ? const PetWindow() : const OnboardingScreen(),
    );
  }
}
