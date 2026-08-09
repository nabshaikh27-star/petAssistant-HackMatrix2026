import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:isar/isar.dart';
import '../core/storage.dart';
import '../core/hotkey_setup.dart';
import '../core/startup_setup.dart';
import '../models/pet_config.dart';
import '../models/shortcut.dart';
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
    setState(() => launchOnStartup = value);
    await SystemStartupManager.setLaunchOnStartup(value);
  }

  Future<void> _updateHotkeyMode(String? mode) async {
    if (mode == null) return;
    setState(() => hotkeyMode = mode);
    final config = await Storage.getConfig();
    config.hotkeyMode = mode;
    await Storage.isar.writeTxn(() async {
      await Storage.isar.petConfigs.put(config);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Pet Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // ── Quick-Access Shortcuts (inline) ──────────────────────────────
          const _SectionHeader(title: '⚡ Quick-Access Shortcuts', subtitle: 'Double-tap or triple-tap buttons in the radial menu'),
          const _ShortcutsSection(),
          const Divider(height: 32),

          // ── Reminders ────────────────────────────────────────────────────
          const _SectionHeader(title: '⏰ Reminders & Alarms', subtitle: ''),
          ListTile(
            title: const Text('Manage Reminders'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 14),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RemindersPage())),
          ),
          const Divider(height: 32),



          // ── General ──────────────────────────────────────────────────────
          const _SectionHeader(title: '⚙️ General', subtitle: ''),
          SwitchListTile(
            title: const Text('Launch on Windows Startup'),
            subtitle: const Text('Automatically open the AI pet when you log in.'),
            value: launchOnStartup,
            onChanged: _updateStartup,
          ),
          const Divider(),
          ListTile(
            title: const Text('Global Shortcut Action'),
            trailing: DropdownButton<String>(
              value: ['toggle_visibility', 'open_chat'].contains(hotkeyMode) ? hotkeyMode : 'toggle_visibility',
              onChanged: _updateHotkeyMode,
              items: const [
                DropdownMenuItem(value: 'toggle_visibility', child: Text('Hide / Show Pet')),
                DropdownMenuItem(value: 'open_chat', child: Text('Open AI Chat')),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Global Shortcut Key'),
            subtitle: Text(currentHotKey != null ? currentHotKey!.toString() : 'Not set'),
            trailing: ElevatedButton(
              onPressed: () => _showHotKeyRecorder(context),
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
      builder: (context) => AlertDialog(
        title: const Text('Record New Shortcut'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Press any combination of keys (e.g., Ctrl + Shift + P)'),
            const SizedBox(height: 16),
            HotKeyRecorder(onHotKeyRecorded: (hotKey) => newHotKey = hotKey),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (newHotKey != null) {
                final globalHotKey = HotKey(
                  newHotKey!.keyCode,
                  modifiers: newHotKey!.modifiers,
                  identifier: newHotKey!.identifier,
                  scope: HotKeyScope.system,
                );
                await SystemHotkeyManager().updateHotKey(globalHotKey);
                setState(() => currentHotKey = globalHotKey);
              }
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Section header widget
// ─────────────────────────────────────────────────────────────────────────────
class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87)),
          if (subtitle.isNotEmpty)
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Inline Shortcuts Manager — no popups, everything inline in Settings
// ─────────────────────────────────────────────────────────────────────────────
class _ShortcutsSection extends StatefulWidget {
  const _ShortcutsSection();

  @override
  State<_ShortcutsSection> createState() => _ShortcutsSectionState();
}

class _ShortcutsSectionState extends State<_ShortcutsSection> {
  List<QuickAccessShortcut> _shortcuts = [];
  // When not null, we're showing the inline add/edit form
  QuickAccessShortcut? _editing;
  bool _isAdding = false;

  // Form controllers
  final _labelCtrl = TextEditingController();
  final _iconCtrl = TextEditingController();
  String? _doublePath;
  String? _triplePath;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _labelCtrl.dispose();
    _iconCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final s = await Storage.isar.quickAccessShortcuts.filter().labelIsNotEmpty().findAll();
    setState(() => _shortcuts = s);
  }

  void _startAdd() {
    setState(() {
      _editing = null;
      _isAdding = true;
      _labelCtrl.clear();
      _iconCtrl.text = 'star';
      _doublePath = null;
      _triplePath = null;
    });
  }

  void _startEdit(QuickAccessShortcut sc) {
    setState(() {
      _editing = sc;
      _isAdding = true;
      _labelCtrl.text = sc.label;
      _iconCtrl.text = sc.iconName;
      _doublePath = sc.doubleTapTargetPath;
      _triplePath = sc.tripleTapTargetPath;
    });
  }

  void _cancelForm() {
    setState(() { _isAdding = false; _editing = null; });
  }

  Future<void> _pickPath(bool isDouble) async {
    final choice = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Open what?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, 'folder'), child: const Text('📁 Folder')),
          TextButton(onPressed: () => Navigator.pop(ctx, 'file'), child: const Text('📄 File / App')),
        ],
      ),
    );
    if (choice == null) return;
    String? path;
    if (choice == 'file') {
      final r = await FilePicker.platform.pickFiles();
      path = r?.files.single.path;
    } else {
      path = await FilePicker.platform.getDirectoryPath();
    }
    if (path != null) setState(() { if (isDouble) _doublePath = path; else _triplePath = path; });
  }

  Future<void> _save() async {
    if (_labelCtrl.text.trim().isEmpty) return;
    final sc = _editing ?? QuickAccessShortcut();
    sc.id = sc.id.isEmpty ? DateTime.now().millisecondsSinceEpoch.toString() : sc.id;
    sc.label = _labelCtrl.text.trim();
    sc.iconName = _iconCtrl.text.trim().isEmpty ? 'star' : _iconCtrl.text.trim();
    sc.doubleTapTargetPath = _doublePath;
    sc.tripleTapTargetPath = _triplePath;
    await Storage.isar.writeTxn(() async { await Storage.isar.quickAccessShortcuts.put(sc); });
    _cancelForm();
    _load();
  }

  Future<void> _delete(QuickAccessShortcut sc) async {
    await Storage.isar.writeTxn(() async {
      await Storage.isar.quickAccessShortcuts.delete(sc.isarId);
    });
    _load();
  }

  String _basename(String path) => path.split(RegExp(r'[\\/]')).last;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // List of existing shortcuts
        ..._shortcuts.map((sc) => ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 4),
          leading: const Icon(Icons.star, color: Colors.blue, size: 20),
          title: Text(sc.label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          subtitle: Text(
            "2×: ${sc.doubleTapTargetPath != null ? _basename(sc.doubleTapTargetPath!) : '—'}   3×: ${sc.tripleTapTargetPath != null ? _basename(sc.tripleTapTargetPath!) : '—'}",
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(icon: const Icon(Icons.edit, size: 18, color: Colors.blue), onPressed: () => _startEdit(sc)),
              IconButton(icon: const Icon(Icons.delete, size: 18, color: Colors.red), onPressed: () => _delete(sc)),
            ],
          ),
        )),

        // ── Inline Add/Edit form (no popup!) ──────────────────────────────
        if (_isAdding) ...[
          const Divider(),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _editing == null ? "New Shortcut" : "Edit Shortcut",
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _labelCtrl,
                  decoration: const InputDecoration(labelText: 'Label', hintText: 'e.g. Calculator', isDense: true),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _iconCtrl,
                  decoration: const InputDecoration(labelText: 'Icon name', hintText: 'star, folder, calculate, web…', isDense: true),
                ),
                const SizedBox(height: 12),
                // Double tap row
                Row(
                  children: [
                    const Text("2× tap:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(_doublePath != null ? _basename(_doublePath!) : 'Not set', style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
                    TextButton(onPressed: () => _pickPath(true), child: const Text("Pick")),
                  ],
                ),
                // Triple tap row
                Row(
                  children: [
                    const Text("3× tap:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                    const SizedBox(width: 8),
                    Expanded(child: Text(_triplePath != null ? _basename(_triplePath!) : 'Not set', style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
                    TextButton(onPressed: () => _pickPath(false), child: const Text("Pick")),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: _cancelForm, child: const Text("Cancel")),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: _save, child: const Text("Save")),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Add button (hidden while form is open)
        if (!_isAdding)
          TextButton.icon(
            icon: const Icon(Icons.add, size: 18),
            label: const Text("Add Shortcut"),
            onPressed: _shortcuts.length >= 6 ? null : _startAdd,
          ),
        if (_shortcuts.length >= 6 && !_isAdding)
          const Text("Maximum 6 shortcuts reached.", style: TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}

