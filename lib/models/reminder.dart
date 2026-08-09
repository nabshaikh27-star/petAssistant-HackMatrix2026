import 'package:isar/isar.dart';

part 'reminder.g.dart';

enum RecurrenceType { once, everyNHours, daily, weekly, yearlyBirthday }

@collection
class Reminder {
  Id id = Isar.autoIncrement;
  String title = '';
  DateTime time = DateTime.now();

  @enumerated
  RecurrenceType recurrence = RecurrenceType.once;

  int? intervalHours;
  bool isPaused = false;
  bool isBirthday = false;

  DateTime? lastTriggeredAt;
}
