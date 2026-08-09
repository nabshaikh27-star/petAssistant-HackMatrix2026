import 'dart:io';

class PathLauncher {
  static Future<void> launch(String path) async {
    if (path.isEmpty) return;

    try {
      final isExe = path.toLowerCase().endsWith('.exe');
      
      if (isExe) {
        // Launch executable directly
        await Process.start(path, []);
      } else {
        // Use explorer to open folders or generic files with their default handler
        await Process.start('explorer', [path]);
      }
    } catch (e) {
      print('Error launching path \$path: \$e');
    }
  }
}
