import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/midwife/reminders/reminders_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/reminder.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/add_reminders/add_reminder_form.dart';
import 'package:smartguide_app/services/laravel/reminder_services.dart';

class AddRemindersPage extends StatefulWidget {
  const AddRemindersPage({super.key});

  @override
  State<AddRemindersPage> createState() => _AddRemindersPageState();
}

class _AddRemindersPageState extends State<AddRemindersPage> {
  bool fetchingReminders = true;
  List<Reminder> reminders = [];

  void handleAddReminders({
    required String title,
    required String purpose,
    required ReminderTypeEnum reminderType,
    required DateTime date,
    required int userId,
  }) {
    final User user = context.read<User>();
    setState(() {
      reminders.add(Reminder(
        userId: userId,
        date: date,
        purpose: purpose,
        reminderType: reminderType,
        title: title,
      ));
    });
  }

  void handleDelete(int id) {
    final List<Reminder> r = reminders.where((e) => e.id! != id).toList();

    setState(() {
      reminders = r;
    });
  }

  void _showAddReminderDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    ReminderTypeEnum? reminderType;

    final TextEditingController titleController = TextEditingController();
    final TextEditingController purposeController = TextEditingController();

    int? userId;

    DateTime date = DateTime.now();
    // TimeOfDay time = TimeOfDay.now();

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

            void onMotherChange(int? i) {
              setDialogState(() {
                userId = i;
              });
            }

            // void onReminderTimeChange(TimeOfDay t) {
            //   setState(() {
            //     time = t;
            //   });
            // }

            return AlertDialog(
              title: const Text('Add Reminder'),
              content: AddReminderForm(
                date: date,
                formKey: formKey,
                onMotherChange: onMotherChange,
                onChangeReminderType: onChangeReminderType,
                onReminderDateChange: onReminderDateChange,
                // onReminderTimeChange: onReminderTimeChange,
                purposeController: purposeController,
                reminderType: reminderType,
                // time: time,
                titleController: titleController,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate() && userId != null) {
                      formKey.currentState!.save();

                      handleAddReminders(
                          userId: userId!,
                          date: date,
                          purpose: purposeController.text,
                          reminderType: reminderType!,
                          title: titleController.text);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void fetchReminders() async {
    final ReminderServices reminderServices = ReminderServices();
    final User user = context.read<User>();

    try {
      final List<Reminder> r = await reminderServices.fetchAllReminderByUserId(
              user.laravelId!.toString(), user.token!) ??
          [];

      setState(() {
        reminders = r;
      });
    } catch (e, stackTrace) {
      log("There was an error fetching you reminders: $e", stackTrace: stackTrace);
    } finally {
      setState(() {
        fetchingReminders = false;
      });
    }
  }

  void updateReminder(Reminder newReminder) {
    setState(() {
      final index = reminders.indexWhere((r) => r.id == newReminder.id);
      if (index != -1) {
        // Create a new list and replace the item
        reminders = List.from(reminders)
          ..removeAt(index)
          ..insert(index, newReminder);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddReminderDialog(context),
        label: const Text("Add Reminder"),
        icon: const Icon(Ionicons.pencil_outline),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomSection(
            isLoading: fetchingReminders,
            headerSpacing: 1,
            childrenSpacing: 1,
            children: fetchingReminders
                ? [const Center(child: SizedBox(child: CircularProgressIndicator()))]
                : reminders.map((reminder) {
                    return RemindersItem(
                        key: UniqueKey(),
                        handleRepaint: updateReminder,
                        reminder: reminder,
                        handleDelete: (code) => handleDelete(code));
                  }).toList(),
          ),
        ),
      ),
    );
  }
}
