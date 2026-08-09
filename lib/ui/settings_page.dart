import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import '../core/storage.dart';
import '../core/hotkey_setup.dart';
import '../core/startup_setup.dart';
import '../models/pet_config.dart';
import 'reminders_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool launchOnStartup = false;
  String hotkeyMode = 'toggle_visibility';
  HotKey? currentHotKey;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final config = await Storage.getConfig();
    setState(() {
      launchOnStartup = config.launchOnStartup;
      hotkeyMode = config.hotkeyMode;
      currentHotKey = SystemHotkeyManager().currentHotKey;
    });
  }

  Future<void> _updateStartup(bool value) async {
    setState(() {
      launchOnStartup = value;
    });
    await SystemStartupManager.setLaunchOnStartup(value);
  }

  Future<void> _updateHotkeyMode(String? mode) async {
    if (mode == null) return;
    setState(() {
      hotkeyMode = mode;
    });
    
    final config = await Storage.getConfig();
    config.hotkeyMode = mode;
    await Storage.isar.writeTxn(() async {
      await Storage.isar.petConfigs.put(config);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Solid background so it's readable over the transparent window
      appBar: AppBar(
        title: const Text('Pet Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: const Text('Reminders & Alarms'),
            subtitle: const Text('Manage your pet schedule and birthdays'),
            trailing: const Icon(Icons.alarm),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RemindersPage()),
              );
            },
          ),
          const Divider(),
          SwitchListTile(
            title: const Text('Launch on Windows Startup'),
            subtitle: const Text('Automatically open the AI pet when you log in to Windows.'),
            value: launchOnStartup,
            onChanged: _updateStartup,
          ),
          const Divider(),
          ListTile(
            title: const Text('Global Shortcut Action'),
            subtitle: const Text('What happens when you press the global shortcut.'),
            trailing: DropdownButton<String>(
              value: ['toggle_visibility', 'open_chat'].contains(hotkeyMode) ? hotkeyMode : 'toggle_visibility',
              onChanged: _updateHotkeyMode,
              items: const [
                DropdownMenuItem(
                  value: 'toggle_visibility',
                  child: Text('Hide / Show Pet'),
                ),
                DropdownMenuItem(
                  value: 'open_chat',
                  child: Text('Open AI Chat'),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Global Shortcut Key'),
            subtitle: Text(
              currentHotKey != null ? currentHotKey!.toString() : 'Not set',
            ),
            trailing: ElevatedButton(
              onPressed: () {
                _showHotKeyRecorder(context);
              },
              child: const Text('Change Key'),
            ),
          ),
        ],
      ),
    );
  }

  void _showHotKeyRecorder(BuildContext context) {
    HotKey? newHotKey;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Record New Shortcut'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Press any combination of keys (e.g., Ctrl + Shift + P)'),
              const SizedBox(height: 16),
              HotKeyRecorder(
                onHotKeyRecorded: (hotKey) {
                  newHotKey = hotKey;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
              ElevatedButton(
              onPressed: () async {
                if (newHotKey != null) {
                  // Force system scope so it works globally
                  final globalHotKey = HotKey(
                    newHotKey!.keyCode,
                    modifiers: newHotKey!.modifiers,
                    identifier: newHotKey!.identifier,
                    scope: HotKeyScope.system,
                  );
                  
                  await SystemHotkeyManager().updateHotKey(globalHotKey);
                  setState(() {
                    currentHotKey = globalHotKey;
                  });
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
