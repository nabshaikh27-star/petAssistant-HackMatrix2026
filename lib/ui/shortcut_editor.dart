import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:isar/isar.dart';
import '../core/storage.dart';
import '../models/shortcut.dart';

class ShortcutEditor extends StatefulWidget {
  final QuickAccessShortcut? shortcut;

  const ShortcutEditor({super.key, this.shortcut});

  @override
  State<ShortcutEditor> createState() => _ShortcutEditorState();
}

class _ShortcutEditorState extends State<ShortcutEditor> {
  final _labelCtrl = TextEditingController();
  final _iconCtrl = TextEditingController();
  String? _doubleTapPath;
  String? _tripleTapPath;

  @override
  void initState() {
    super.initState();
    if (widget.shortcut != null) {
      _labelCtrl.text = widget.shortcut!.label;
      _iconCtrl.text = widget.shortcut!.iconName;
      _doubleTapPath = widget.shortcut!.doubleTapTargetPath;
      _tripleTapPath = widget.shortcut!.tripleTapTargetPath;
    } else {
      _iconCtrl.text = 'star'; // Default icon
    }
  }

  Future<void> _pickPath(bool isDoubleTap) async {
    // Let user pick a file or a directory
    String? resultPath;
    
    // We can't pick files AND directories at the exact same time with file_picker in a single dialog easily.
    // So let's ask them what they want to pick first.
    final choice = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick Target Type'),
        content: const Text('Do you want to launch a File/App or open a Folder?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, 'folder'), child: const Text('Folder')),
          TextButton(onPressed: () => Navigator.pop(context, 'file'), child: const Text('File / App')),
        ],
      ),
    );

    if (choice == 'file') {
      final result = await FilePicker.platform.pickFiles();
      if (result != null) resultPath = result.files.single.path;
    } else if (choice == 'folder') {
      resultPath = await FilePicker.platform.getDirectoryPath();
    }

    if (resultPath != null) {
      setState(() {
        if (isDoubleTap) {
          _doubleTapPath = resultPath;
        } else {
          _tripleTapPath = resultPath;
        }
      });
    }
  }

  Future<void> _save() async {
    if (_labelCtrl.text.isEmpty) return;

    final sc = widget.shortcut ?? QuickAccessShortcut();
    sc.id = sc.id.isEmpty ? DateTime.now().millisecondsSinceEpoch.toString() : sc.id;
    sc.label = _labelCtrl.text;
    sc.iconName = _iconCtrl.text.isEmpty ? 'star' : _iconCtrl.text;
    sc.doubleTapTargetPath = _doubleTapPath;
    sc.tripleTapTargetPath = _tripleTapPath;

    await Storage.isar.writeTxn(() async {
      await Storage.isar.quickAccessShortcuts.put(sc);
    });

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Edit Shortcut')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _labelCtrl,
              decoration: const InputDecoration(labelText: 'Label (e.g. "Calculator")'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _iconCtrl,
              decoration: const InputDecoration(labelText: 'Icon Name (e.g. "star", "calculate", "folder")'),
            ),
            const SizedBox(height: 24),
            ListTile(
              title: const Text('Double-Tap Target'),
              subtitle: Text(_doubleTapPath ?? 'None selected'),
              trailing: ElevatedButton(
                onPressed: () => _pickPath(true),
                child: const Text('Pick'),
              ),
            ),
            const Divider(),
            ListTile(
              title: const Text('Triple-Tap Target'),
              subtitle: Text(_tripleTapPath ?? 'None selected'),
              trailing: ElevatedButton(
                onPressed: () => _pickPath(false),
                child: const Text('Pick'),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _save,
              child: const Text('Save Shortcut'),
            )
          ],
        ),
      ),
    );
  }
}
