import 'package:flutter_test/flutter_test.dart';

enum RecurrenceType { once, everyNHours, daily, weekly, yearlyBirthday }

// We extract the recurrence logic from SchedulerIsolate for testability
bool shouldTrigger(DateTime now, DateTime? lastTriggeredAt, RecurrenceType recurrence, int? intervalHours) {
  if (lastTriggeredAt == null) {
    return true;
  }
  
  switch (recurrence) {
    case RecurrenceType.once:
      return false;
    case RecurrenceType.everyNHours:
      if (intervalHours != null) {
        final nextTime = lastTriggeredAt.add(Duration(hours: intervalHours));
        return now.isAfter(nextTime);
      }
      return false;
    case RecurrenceType.daily:
      final nextTime = lastTriggeredAt.add(const Duration(days: 1));
      return now.isAfter(nextTime);
    case RecurrenceType.weekly:
      final nextTime = lastTriggeredAt.add(const Duration(days: 7));
      return now.isAfter(nextTime);
    case RecurrenceType.yearlyBirthday:
      final nextTime = DateTime(
        lastTriggeredAt.year + 1,
        lastTriggeredAt.month,
        lastTriggeredAt.day,
      );
      return now.isAfter(nextTime);
  }
}

void main() {
  group('Scheduler Recurrence Logic Tests', () {
    final now = DateTime(2026, 8, 10, 12, 0); // Mock current time

    test('Triggers immediately if never triggered before', () {
      expect(shouldTrigger(now, null, RecurrenceType.daily, null), isTrue);
    });

    test('RecurrenceType.once never triggers again', () {
      final lastTriggered = now.subtract(const Duration(days: 5));
      expect(shouldTrigger(now, lastTriggered, RecurrenceType.once, null), isFalse);
    });

    test('RecurrenceType.everyNHours triggers correctly', () {
      // Triggered 5 hours ago, interval is 4 hours -> should trigger!
      final lastTriggered1 = now.subtract(const Duration(hours: 5));
      expect(shouldTrigger(now, lastTriggered1, RecurrenceType.everyNHours, 4), isTrue);

      // Triggered 3 hours ago, interval is 4 hours -> should NOT trigger!
      final lastTriggered2 = now.subtract(const Duration(hours: 3));
      expect(shouldTrigger(now, lastTriggered2, RecurrenceType.everyNHours, 4), isFalse);
    });

    test('RecurrenceType.daily triggers correctly', () {
      // Triggered 25 hours ago -> should trigger
      final lastTriggered1 = now.subtract(const Duration(hours: 25));
      expect(shouldTrigger(now, lastTriggered1, RecurrenceType.daily, null), isTrue);

      // Triggered 23 hours ago -> should NOT trigger
      final lastTriggered2 = now.subtract(const Duration(hours: 23));
      expect(shouldTrigger(now, lastTriggered2, RecurrenceType.daily, null), isFalse);
    });

    test('RecurrenceType.weekly triggers correctly', () {
      // Triggered 8 days ago -> should trigger
      final lastTriggered1 = now.subtract(const Duration(days: 8));
      expect(shouldTrigger(now, lastTriggered1, RecurrenceType.weekly, null), isTrue);

      // Triggered 6 days ago -> should NOT trigger
      final lastTriggered2 = now.subtract(const Duration(days: 6));
      expect(shouldTrigger(now, lastTriggered2, RecurrenceType.weekly, null), isFalse);
    });

    test('RecurrenceType.yearlyBirthday triggers correctly', () {
      // Triggered exactly 1 year and 1 day ago
      final lastTriggered1 = DateTime(now.year - 1, now.month, now.day - 1);
      expect(shouldTrigger(now, lastTriggered1, RecurrenceType.yearlyBirthday, null), isTrue);

      // Triggered 11 months ago
      final lastTriggered2 = DateTime(now.year - 1, now.month + 1, now.day);
      expect(shouldTrigger(now, lastTriggered2, RecurrenceType.yearlyBirthday, null), isFalse);
    });
  });
}
