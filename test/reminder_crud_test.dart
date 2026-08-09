import 'package:flutter_test/flutter_test.dart';
import 'package:desktop_pet/models/reminder.dart';

void main() {
  group('Reminder CRUD Logic Tests', () {
    test('Create a reminder with valid fields', () {
      final reminder = Reminder()
        ..title = 'Drink Water'
        ..targetTime = DateTime(2025, 1, 1, 10, 0)
        ..recurrenceType = 'daily'
        ..isActive = true;

      expect(reminder.title, 'Drink Water');
      expect(reminder.recurrenceType, 'daily');
      expect(reminder.isActive, isTrue);
    });

    test('Edit/Update reminder properties', () {
      final reminder = Reminder()
        ..title = 'Take Medication'
        ..targetTime = DateTime(2025, 2, 1, 8, 0)
        ..recurrenceType = 'once'
        ..isActive = true;

      // Update
      reminder.title = 'Take Medication (Updated)';
      reminder.recurrenceType = 'daily';

      expect(reminder.title, 'Take Medication (Updated)');
      expect(reminder.recurrenceType, 'daily');
    });

    test('Pause a reminder updates isActive', () {
      final reminder = Reminder()
        ..title = 'Meeting'
        ..targetTime = DateTime.now().add(const Duration(hours: 1))
        ..recurrenceType = 'once'
        ..isActive = true;

      expect(reminder.isActive, isTrue);

      // Pause
      reminder.isActive = false;

      expect(reminder.isActive, isFalse);
    });
  });
}
