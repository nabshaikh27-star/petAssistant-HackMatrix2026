import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import '../core/storage.dart';
import '../models/reminder.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  List<Reminder> _reminders = [];

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  Future<void> _loadReminders() async {
    final reminders = await Storage.isar.reminders.where().findAll();
    setState(() {
      _reminders = reminders;
    });
  }

  Future<void> _deleteReminder(Id id) async {
    await Storage.isar.writeTxn(() async {
      await Storage.isar.reminders.delete(id);
    });
    _loadReminders();
  }

  Future<void> _togglePause(Reminder reminder) async {
    reminder.isPaused = !reminder.isPaused;
    await Storage.isar.writeTxn(() async {
      await Storage.isar.reminders.put(reminder);
    });
    _loadReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Reminders & Alarms'),
      ),
      body: _reminders.isEmpty
          ? const Center(child: Text("No reminders yet."))
          : ListView.builder(
              itemCount: _reminders.length,
              itemBuilder: (context, index) {
                final rem = _reminders[index];
                return ListTile(
                  title: Text(rem.title),
                  subtitle: Text(
                      "${rem.time.toLocal()} - ${rem.recurrence.name} ${rem.isBirthday ? '(🎂 Birthday)' : ''}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Switch(
                        value: !rem.isPaused,
                        onChanged: (_) => _togglePause(rem),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteReminder(rem.id),
                      )
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final titleCtrl = TextEditingController();
    RecurrenceType rec = RecurrenceType.once;
    bool isBirthday = false;
    DateTime selectedTime = DateTime.now().add(const Duration(minutes: 1));

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            return AlertDialog(
              title: const Text("New Reminder"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: const InputDecoration(labelText: "Title"),
                  ),
                  DropdownButton<RecurrenceType>(
                    value: rec,
                    onChanged: (val) => setStateSB(() => rec = val!),
                    items: RecurrenceType.values.map((r) {
                      return DropdownMenuItem(
                        value: r,
                        child: Text(r.name),
                      );
                    }).toList(),
                  ),
                  CheckboxListTile(
                    title: const Text("Is this a Birthday?"),
                    value: isBirthday,
                    onChanged: (val) => setStateSB(() => isBirthday = val!),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final t = await showTimePicker(
                        context: context, 
                        initialTime: TimeOfDay.fromDateTime(selectedTime),
                        initialEntryMode: TimePickerEntryMode.input, // Simplified text input instead of the big dial
                      );
                      if (t != null) {
                        final now = DateTime.now();
                        setStateSB(() {
                          selectedTime = DateTime(now.year, now.month, now.day, t.hour, t.minute);
                          if (selectedTime.isBefore(now)) {
                            selectedTime = selectedTime.add(const Duration(days: 1));
                          }
                        });
                      }
                    },
                    child: Text("Time: ${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}"),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (titleCtrl.text.isEmpty) return;
                    final newRem = Reminder()
                      ..title = titleCtrl.text
                      ..time = selectedTime
                      ..recurrence = rec
                      ..isBirthday = isBirthday;
                    await Storage.isar.writeTxn(() async {
                      await Storage.isar.reminders.put(newRem);
                    });
                    Navigator.pop(context);
                    _loadReminders();
                  },
                  child: const Text("Save"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
