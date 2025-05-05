import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/models/reminder.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/add_reminders/add_reminder_form.dart';
import 'package:smartguide_app/pages/midwife/add_reminders/view_reminders_page.dart';

class RemindersItem extends StatefulWidget {
  const RemindersItem(
      {super.key, required this.reminder, required this.handleDelete, required this.handleRepaint});

  final Reminder reminder;
  final Function(int) handleDelete;
  final Function(Reminder) handleRepaint;

  @override
  State<RemindersItem> createState() => _RemindersItemState();
}

class _RemindersItemState extends State<RemindersItem> {
  late bool isFresh;
  late bool isSyncing;
  bool isDeleting = false;

  Future<void> syncFresh() async {
    final User user = context.read<User>();

    // log(isFresh.toString());

    if (isFresh) {
      setState(() {
        isSyncing = true;
      });

      try {
        final res = await widget.reminder.storeReminder(user.token!);
        if (res) {
          setState(() {
            isFresh = false;
            widget.reminder.isFresh = false;
          });
        } else {
          if (!mounted) return;
          Alert.showErrorMessage(message: "There was an error storing the reminder");
          setState(() {
            isFresh = true;
          });
        }
      } catch (e, stackTrace) {
        if (!mounted) return;
        Alert.showErrorMessage(message: "There was an error storing the reminder");
        log("There was an error storing the reminder: $e", stackTrace: stackTrace);
        setState(() {
          isFresh = true;
        });
      } finally {
        setState(() {
          isSyncing = false;
        });
      }
    } else {
      isSyncing = false;
    }
  }

  Future<void> handleRemove() async {
    final User user = context.read<User>();

    setState(() {
      isDeleting = true;
    });

    try {
      final int res = await widget.reminder.removeReminder(user.token!);

      widget.handleDelete(res);
      if (!mounted) return;
      Alert.showSuccessMessage(
          message: "Reminder titled ${widget.reminder.title} removed successfully");
    } catch (e, stackTrace) {
      log("Error: $e", stackTrace: stackTrace);
      if (!mounted) return;
      Alert.showErrorMessage(message: "Error: $e");
    } finally {
      isDeleting = false;
    }
  }

  void _showAddReminderDialog(BuildContext context, Function(Reminder) repaint) {
    final User user = context.read<User>();
    final formKey = GlobalKey<FormState>();
    ReminderTypeEnum? reminderType = widget.reminder.reminderType;
    int? motherId = widget.reminder.motherId;
    final TextEditingController titleController =
        TextEditingController(text: widget.reminder.title);
    final TextEditingController purposeController =
        TextEditingController(text: widget.reminder.purpose);

    DateTime date = widget.reminder.date!;

    bool isUpdating = false;

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

            void onMotherChange(int? i) {
              setDialogState(() {
                motherId = i;
              });
            }

            void onReminderDateChange(DateTime d) {
              setState(() {
                date = d;
              });
            }

            Future<void> handleUpdate() async {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();

                setDialogState(() {
                  isUpdating = true;
                });

                try {
                  final res = await widget.reminder.updateReminder(
                      midwifeId: user.laravelId!,
                      title: titleController.text,
                      type: reminderType!,
                      motherId: motherId!,
                      date: date,
                      token: user.token!);

                  repaint(res);
                  // ignore: use_build_context_synchronously
                  Alert.showSuccessMessage(message: "Reminder updated successfully");
                } catch (e, stackTrace) {
                  log("$e", stackTrace: stackTrace);

                  Alert.showErrorMessage(
                      // ignore: use_build_context_synchronously

                      message: "Unable to update your reminder. Please try again later");
                } finally {
                  setDialogState(() {
                    isUpdating = false;
                  });

                  // if (!mounted) return;
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              }
            }

            return AlertDialog(
              title: const Text('Update reminder'),
              content: AddReminderForm(
                motherId: widget.reminder.motherId,
                date: date,
                onMotherChange: onMotherChange,
                formKey: formKey,
                onChangeReminderType: onChangeReminderType,
                onReminderDateChange: onReminderDateChange,
                // onReminderTimeChange: onReminderTimeChange,
                purposeController: purposeController,
                reminderType: reminderType,
                // time: time,
                titleController: titleController,
              ),
              actions: [
                if (!isUpdating)
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                isUpdating
                    ? const SizedBox(
                        height: 4 * 5,
                        width: 4 * 5,
                        child: CircularProgressIndicator(),
                      )
                    : TextButton(
                        onPressed: handleUpdate,
                        child: const Text('Add'),
                      ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    isFresh = widget.reminder.isFresh;
    syncFresh();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ViewRemindersPage(reminder: widget.reminder))),
      child: Row(
        spacing: 4 * 2,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Image.asset(
              widget.reminder.reminderType.image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AutoSizeText(
                        widget.reminder.title,
                        softWrap: false,
                        maxLines: 2,
                        style: const TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Flexible(
                        child: isSyncing
                            ? SizedBox.square(
                                dimension: 4 * 4,
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).colorScheme.primary,
                                  strokeWidth: 2,
                                ),
                              )
                            : Container())
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton.link(
                  context: context,
                  label: "Edit",
                  onPressed: () => _showAddReminderDialog(context, widget.handleRepaint)),
              isDeleting
                  ? Container(
                      height: 4 * 4,
                      width: 4 * 4,
                      margin: const EdgeInsets.all(4 * 4),
                      child: const CircularProgressIndicator(),
                    )
                  : IconButton(onPressed: handleRemove, icon: const Icon(Ionicons.trash))
            ],
          )
        ],
      ),
    );
  }
}
