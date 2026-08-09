import 'dart:convert';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:window_manager/window_manager.dart';
import '../models/pet_config.dart';
import 'storage.dart';

class SystemHotkeyManager {
  static final SystemHotkeyManager _instance = SystemHotkeyManager._internal();
  factory SystemHotkeyManager() => _instance;
  SystemHotkeyManager._internal();

  HotKey? currentHotKey;

  Future<void> init() async {
    await hotKeyManager.unregisterAll();
    
    final config = await Storage.getConfig();
    
    if (config.hotkeyJson != null) {
      try {
        final Map<String, dynamic> json = jsonDecode(config.hotkeyJson!);
        currentHotKey = HotKey.fromJson(json);
      } catch (e) {
        // Fallback if parsing fails
        currentHotKey = _getDefaultHotKey();
      }
    } else {
      currentHotKey = _getDefaultHotKey();
    }

    if (currentHotKey != null) {
      try {
        await hotKeyManager.register(
          currentHotKey!,
          keyDownHandler: (hotKey) async {
            final cfg = await Storage.getConfig();
            if (cfg.hotkeyMode == 'toggle_visibility') {
              bool isVisible = await windowManager.isVisible();
              if (isVisible) {
                windowManager.hide();
              } else {
                windowManager.show();
              }
            } else {
              // "open_chat" mode
              windowManager.show();
              // TODO: Open chat box UI (to be implemented in future phase)
              print("Action: Open Chat Box");
            }
          },
        );
      } catch (e) {
        print("Failed to register hotkey: \$e");
      }
    }
  }

  HotKey _getDefaultHotKey() {
    return HotKey(
      KeyCode.keyP,
      modifiers: [KeyModifier.control, KeyModifier.alt],
      scope: HotKeyScope.system, // Global system-wide hotkey
    );
  }

  Future<void> updateHotKey(HotKey newHotKey) async {
    await hotKeyManager.unregisterAll();
    currentHotKey = newHotKey;
    
    // Save to storage
    final config = await Storage.getConfig();
    config.hotkeyJson = jsonEncode(currentHotKey!.toJson());
    await Storage.isar.writeTxn(() async {
      await Storage.isar.petConfigs.put(config);
    });

    // Re-register
    await init();
  }
}
