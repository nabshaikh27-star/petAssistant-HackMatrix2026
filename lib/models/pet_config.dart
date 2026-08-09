import 'package:isar/isar.dart';

part 'pet_config.g.dart';

@collection
class PetConfig {
  Id id = Isar.autoIncrement;

  String? petImagePath;
  String? activeAnimationSet;
  
  double positionX = 100;
  double positionY = 100;
  double size = 150;

  // New fields for Phase 3
  String? hotkeyJson; // We store it as a json string
  String hotkeyMode = 'toggle_visibility'; // 'toggle_visibility' or 'open_chat'
  bool launchOnStartup = false;
}
