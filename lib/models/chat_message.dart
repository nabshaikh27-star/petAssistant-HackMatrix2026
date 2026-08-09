import 'package:isar/isar.dart';

part 'chat_message.g.dart';

@collection
class ChatMessage {
  Id isarId = Isar.autoIncrement;

  @Index(unique: true)
  String id = '';

  String sender = 'user'; // 'user' | 'pet'
  String text = '';
  DateTime timestamp = DateTime.now();
  String? attachedImagePath;
}
