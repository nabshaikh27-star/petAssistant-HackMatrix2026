import 'dart:async';
import 'dart:isolate';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../models/pet_config.dart';
import '../models/reminder.dart';
import '../models/shortcut.dart';

// Since we use flutter_local_notifications in the background isolate, 
// we might run into issues if the plugin requires UI thread.
// On desktop, we can often just send a message to the main isolate to show the notification!
// Let's have the background isolate just send 'show_notification' and 'play_animation' messages.

class SchedulerMessage {
  final String action;
  final String? payload;

  SchedulerMessage(this.action, this.payload);
}

class SchedulerIsolate {
  static Future<void> startScheduler(SendPort mainSendPort) async {
    // We need the application documents directory to open Isar in the isolate.
    // However, path_provider uses platform channels which cannot be used in a plain isolate easily unless we use BackgroundIsolateBinaryMessenger.
    // Instead of dealing with platform channels in the isolate, we can pass the directory path from the main isolate!
  }

  static void _isolateEntry(List<dynamic> args) async {
    SendPort sendPort = args[0];
    String dbPath = args[1];

    // Open Isar in this isolate
    Isar isar;
    if (Isar.instanceNames.isNotEmpty) {
      isar = Isar.getInstance()!;
    } else {
      isar = await Isar.open(
        [PetConfigSchema, ReminderSchema, QuickAccessShortcutSchema],
        directory: dbPath,
      );
    }

    // 10 second polling loop
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      print("ISOLATE: Checking for due reminders...");
      final now = DateTime.now();

      final dueReminders = await isar.reminders
          .filter()
          .isPausedEqualTo(false)
          .timeLessThan(now)
          .findAll();

      for (var reminder in dueReminders) {
        bool shouldTrigger = false;

        if (reminder.lastTriggeredAt == null) {
          shouldTrigger = true;
        } else {
          // Check recurrence
          switch (reminder.recurrence) {
            case RecurrenceType.once:
              shouldTrigger = false;
              break;
            case RecurrenceType.everyNHours:
              if (reminder.intervalHours != null) {
                final nextTime = reminder.lastTriggeredAt!.add(Duration(hours: reminder.intervalHours!));
                shouldTrigger = now.isAfter(nextTime);
              }
              break;
            case RecurrenceType.daily:
              final nextTime = reminder.lastTriggeredAt!.add(const Duration(days: 1));
              shouldTrigger = now.isAfter(nextTime);
              break;
            case RecurrenceType.weekly:
              final nextTime = reminder.lastTriggeredAt!.add(const Duration(days: 7));
              shouldTrigger = now.isAfter(nextTime);
              break;
            case RecurrenceType.yearlyBirthday:
              // Check if it's been a year
              final nextTime = DateTime(
                reminder.lastTriggeredAt!.year + 1,
                reminder.lastTriggeredAt!.month,
                reminder.lastTriggeredAt!.day,
              );
              shouldTrigger = now.isAfter(nextTime);
              break;
          }
        }

        if (shouldTrigger) {
          // 1. Tell UI to show notification
          sendPort.send(SchedulerMessage('show_notification', "\${reminder.title}||\${reminder.isBirthday}"));
          
          // 2. Tell UI to play animation
          sendPort.send(SchedulerMessage(reminder.isBirthday ? 'play_celebrate' : 'play_alert', null));

          // 3. Update lastTriggeredAt
          reminder.lastTriggeredAt = now;
          if (reminder.recurrence == RecurrenceType.once) {
            reminder.isPaused = true; // Auto-pause one-time reminders
          }

          await isar.writeTxn(() async {
            await isar.reminders.put(reminder);
          });
        }
      }
    });
  }

  static Future<void> spawn(SendPort sendPort, String dbPath) async {
    final receivePort = ReceivePort();
    receivePort.listen((message) {
      print("ISOLATE ERROR: \$message");
    });
    
    await Isolate.spawn(_isolateEntry, [sendPort, dbPath], onError: receivePort.sendPort);
    print("Scheduler Isolate successfully spawned!");
  }
}
