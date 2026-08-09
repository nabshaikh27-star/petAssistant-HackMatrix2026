import 'package:isar/isar.dart';

part 'shortcut.g.dart';

@collection
class QuickAccessShortcut {
  Id isarId = Isar.autoIncrement;
  
  @Index(unique: true)
  String id = ''; // The user requested string id
  
  String label = '';
  String iconName = 'star'; // Material icon name identifier
  
  String? doubleTapTargetPath; 
  String? tripleTapTargetPath; 
}
