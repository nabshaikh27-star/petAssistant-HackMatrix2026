import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../models/shortcut.dart';
import '../core/storage.dart';
import '../core/tap_detector.dart';
import '../core/path_launcher.dart';
import 'settings_page.dart';

class RadialMenuOverlay extends StatefulWidget {
  final VoidCallback onClose;

  const RadialMenuOverlay({super.key, required this.onClose});

  @override
  State<RadialMenuOverlay> createState() => _RadialMenuOverlayState();
}

class _RadialMenuOverlayState extends State<RadialMenuOverlay> {
  List<QuickAccessShortcut> _shortcuts = [];

  @override
  void initState() {
    super.initState();
    _loadShortcuts();
  }

  Future<void> _loadShortcuts() async {
    final shortcuts = await Storage.isar.quickAccessShortcuts
        .filter()
        .labelIsNotEmpty()
        .findAll();
    setState(() => _shortcuts = shortcuts);
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'calculate': return Icons.calculate;
      case 'folder': return Icons.folder;
      case 'chat': return Icons.chat;
      case 'games': return Icons.games;
      case 'music_note': return Icons.music_note;
      case 'web': return Icons.web;
      case 'code': return Icons.code;
      case 'terminal': return Icons.terminal;
      default: return Icons.star;
    }
  }

  Future<void> _openSettings() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsPage()),
    );
    _loadShortcuts(); // Refresh after returning
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Center(
        child: Container(
          width: 320,
          constraints: const BoxConstraints(maxHeight: 480),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 20)],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Quick Access",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: widget.onClose,
                  ),
                ],
              ),
              const Divider(),

              // Empty state
              if (_shortcuts.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Column(
                    children: [
                      const Text(
                        "Add shortcuts in Settings!",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text("Manage Shortcuts"),
                        onPressed: _openSettings,
                      ),
                    ],
                  ),
                )
              else
                // Shortcut grid
                Flexible(
                  child: GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _shortcuts.length,
                    itemBuilder: (context, index) {
                      final sc = _shortcuts[index];
                      return DebouncedTapDetector(
                        onSingleTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Double or triple-tap to launch: ${sc.label}"),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                        onDoubleTap: () {
                          if (sc.doubleTapTargetPath != null) {
                            PathLauncher.launch(sc.doubleTapTargetPath!);
                            widget.onClose();
                          }
                        },
                        onTripleTap: () {
                          if (sc.tripleTapTargetPath != null) {
                            PathLauncher.launch(sc.tripleTapTargetPath!);
                            widget.onClose();
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.blue.shade100),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(_getIcon(sc.iconName), size: 36, color: Colors.blue),
                              const SizedBox(height: 6),
                              Text(
                                sc.label,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

              const Divider(),
              // Bottom row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.settings),
                    label: const Text("Manage"),
                    onPressed: _openSettings,
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.close),
                    label: const Text("Close"),
                    onPressed: widget.onClose,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
