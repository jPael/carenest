import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/midwife/reminders/reminders_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/reminder.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/add_reminders/add_reminder_form.dart';

class AddRemindersPage extends StatefulWidget {
  const AddRemindersPage({super.key});

  @override
  State<AddRemindersPage> createState() => _AddRemindersPageState();
}

class _AddRemindersPageState extends State<AddRemindersPage> {
  List<Reminder> reminders = [];

  void handleAddReminders(
      {required String title,
      required String purpose,
      required ReminderTypeEnum reminderType,
      required DateTime date,
      required TimeOfDay time}) {
    final User user = context.read<User>();
    setState(() {
      reminders.add(Reminder(
        userId: user.laravelId!,
        date: date,
        purpose: purpose,
        reminderType: reminderType,
        time: time,
        title: title,
      ));
    });
  }

  void handleDelete(int code) {}

  void _showAddReminderDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    ReminderTypeEnum? reminderType;

    final TextEditingController titleController = TextEditingController();
    final TextEditingController purposeController = TextEditingController();

    DateTime date = DateTime.now();
    TimeOfDay time = TimeOfDay.now();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            void onChangeReminderType(ReminderTypeEnum? type) {
              titleController.text = type!.name;
              setDialogState(() {
                reminderType = type;
              });
            }

            void onReminderDateChange(DateTime d) {
              setState(() {
                date = d;
              });
            }

            void onReminderTimeChange(TimeOfDay t) {
              setState(() {
                time = t;
              });
            }

            return AlertDialog(
              title: Text('Add Reminder'),
              content: AddReminderForm(
                date: date,
                formKey: formKey,
                onChangeReminderType: onChangeReminderType,
                onReminderDateChange: onReminderDateChange,
                onReminderTimeChange: onReminderTimeChange,
                purposeController: purposeController,
                reminderType: reminderType,
                time: time,
                titleController: titleController,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      handleAddReminders(
                          date: date,
                          purpose: purposeController.text,
                          reminderType: reminderType!,
                          time: time,
                          title: titleController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminders'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddReminderDialog(context),
        label: Text("Add Reminder"),
        icon: Icon(Ionicons.pencil_outline),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              CustomSection(
                headerSpacing: 1,
                childrenSpacing: 1,
                children: [
                  ...reminders.map((reminder) {
                    return RemindersItem(
                        reminder: reminder, handleDelete: (code) => handleDelete(code));
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
