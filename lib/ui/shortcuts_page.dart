import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../core/storage.dart';
import '../models/shortcut.dart';
import 'shortcut_editor.dart';

class ShortcutsPage extends StatefulWidget {
  const ShortcutsPage({super.key});

  @override
  State<ShortcutsPage> createState() => _ShortcutsPageState();
}

class _ShortcutsPageState extends State<ShortcutsPage> {
  List<QuickAccessShortcut> _shortcuts = [];

  @override
  void initState() {
    super.initState();
    _loadShortcuts();
  }

  Future<void> _loadShortcuts() async {
    final shortcuts = await Storage.isar.quickAccessShortcuts.filter().labelIsNotEmpty().findAll();
    setState(() {
      _shortcuts = shortcuts;
    });
  }

  Future<void> _deleteShortcut(Id id) async {
    await Storage.isar.writeTxn(() async {
      await Storage.isar.quickAccessShortcuts.delete(id);
    });
    _loadShortcuts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Quick-Access Shortcuts')),
      body: _shortcuts.isEmpty
          ? const Center(child: Text("No shortcuts added yet. Maximum 6 recommended."))
          : ListView.builder(
              itemCount: _shortcuts.length,
              itemBuilder: (context, index) {
                final sc = _shortcuts[index];
                return ListTile(
                  leading: const Icon(Icons.star), // Can map iconName dynamically later
                  title: Text(sc.label),
                  subtitle: Text("Double: \${sc.doubleTapTargetPath != null ? 'Set' : 'Unset'} | Triple: \${sc.tripleTapTargetPath != null ? 'Set' : 'Unset'}"),
                  onTap: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (_) => ShortcutEditor(shortcut: sc)));
                    _loadShortcuts();
                  },
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteShortcut(sc.isarId),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const ShortcutEditor()));
          _loadShortcuts();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
