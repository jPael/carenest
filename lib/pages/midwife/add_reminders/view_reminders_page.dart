import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/reminder.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/add_reminders/add_reminder_form.dart';
import 'package:smartguide_app/utils/date_utils.dart';

class ViewRemindersPage extends StatefulWidget {
  const ViewRemindersPage({super.key, required this.reminder, required this.handleRepaint});

  final Reminder reminder;
  final Function(Reminder) handleRepaint;

  @override
  State<ViewRemindersPage> createState() => _ViewRemindersPageState();
}

class _ViewRemindersPageState extends State<ViewRemindersPage> {
  bool isSettingAsDone = false;
  late Reminder currReminder;

  void handleMarkAsDone(String token, Function(Reminder) repaint) async {
    setState(() {
      isSettingAsDone = true;
    });

    await Future.delayed(const Duration(seconds: 3));

    try {
      Reminder newReminder = await widget.reminder.markAsDone(token);

      repaint(newReminder);
      setState(() {
        currReminder = newReminder;
      });
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
    } finally {
      setState(() {
        isSettingAsDone = false;
      });
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
                  final newReminder = await widget.reminder.updateReminder(
                      midwifeId: user.laravelId!,
                      title: titleController.text,
                      type: reminderType!,
                      motherId: motherId!,
                      createdAt: widget.reminder.createdAt!,
                      date: date,
                      token: user.token!);

                  repaint(newReminder);

                  setState(() {
                    currReminder = newReminder;
                  });

                  Alert.showSuccessMessage(message: "Reminder updated successfully");
                } catch (e, stackTrace) {
                  log("$e", stackTrace: stackTrace);

                  Alert.showErrorMessage(
                      message: "Unable to update your reminder. Please try again later");
                } finally {
                  setDialogState(() {
                    isUpdating = false;
                  });

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
    currReminder = widget.reminder;
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.read<User>();

    // final int isNow = currReminder.date!.toLocal().difference(DateTime.now()).inDays;

    // final DateTime now = DateTime.now();
    // log("cur reminder: ${currReminder.date!.toString()} | ${DateTime(now.year, now.month, now.day).toString()}");

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(2 * 8.0),
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(2 * 8.0),
              child: Column(
                spacing: 8 * 2,
                children: [
                  CustomSection(
                    sectionIcon: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      child: Image.asset(ReminderTypeEnum.nutritionSeminar.image),
                    ),
                    title: currReminder.title,
                    children: [
                      Row(
                        children: [
                          const AutoSizeText(
                            "Mother name: ",
                            style: TextStyle(fontSize: 4 * 4),
                          ),
                          AutoSizeText(
                            currReminder.mother!.name!,
                            style: const TextStyle(fontSize: 4 * 4),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const AutoSizeText(
                            "Date: ",
                            style: TextStyle(fontSize: 4 * 4),
                          ),
                          AutoSizeText(
                            currReminder.date != null
                                ? DateFormat("MMMM dd, yyyy").format(currReminder.date!)
                                : "Date is not set",
                            style: const TextStyle(fontSize: 4 * 4),
                          )
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),

                  if (isNow(currReminder.date!)) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 4 * 2,
                          children: [
                            if (currReminder.isDone!) ...[
                              Expanded(
                                child: Card(
                                  color: HSLColor.fromColor(Colors.greenAccent)
                                      .withLightness(0.8)
                                      .withSaturation(0.5)
                                      .toColor(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      spacing: 8,
                                      children: [
                                        const Icon(Icons.check_rounded),
                                        Text(
                                          "Done",
                                          style: TextStyle(
                                              fontSize: 8 * 3,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green[900]),
                                        ),
                                      ],
                                    )),
                                  ),
                                ),
                              )
                            ] else ...[
                              CustomButton(
                                  isLoading: isSettingAsDone,
                                  icon: const Icon(
                                    Icons.check_rounded,
                                    size: 4 * 4,
                                  ),
                                  horizontalPadding: 3,
                                  type: CustomButtonType.success,
                                  onPress: () =>
                                      handleMarkAsDone(user.token!, widget.handleRepaint),
                                  label: "Mark as done"),
                              CustomButton(
                                  icon: const Icon(
                                    Icons.calendar_month_rounded,
                                    size: 4 * 6,
                                    color: Colors.black,
                                  ),
                                  horizontalPadding: 3,
                                  type: CustomButtonType.ghost,
                                  onPress: () =>
                                      _showAddReminderDialog(context, widget.handleRepaint),
                                  label: "Reschedule"),
                            ]
                          ],
                        )

                        // Text(
                        //   "Time: ",
                        //   softWrap: true,
                        //   style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                        // ),
                        // Row(
                        //   children: [
                        //     Flexible(
                        //       child: Text(
                        //         DateFormat.jm().format(
                        //             DateTime(2021, 1, 1, reminder.time.hour, reminder.time.minute)),
                        //         softWrap: true,
                        //         style: TextStyle(
                        //           fontSize: 8 * 3,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),
                  ] else if (hasPassed(currReminder.date!)) ...[
                    Row(
                      children: [
                        Expanded(
                          child: Card(
                            color: HSLColor.fromColor(Colors.redAccent)
                                .withLightness(0.8)
                                .withSaturation(0.5)
                                .toColor(),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 8,
                                children: [
                                  const Icon(
                                    Icons.close_rounded,
                                    color: Colors.redAccent,
                                  ),
                                  Text(
                                    "Missed",
                                    style: TextStyle(
                                        fontSize: 8 * 3,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.red[900]),
                                  ),
                                ],
                              )),
                            ),
                          ),
                        )
                      ],
                    )
                  ]
                  // if(currReminder.date!.isBefore(DateTime.now()))
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Purpose: ",
                  //       softWrap: true,
                  //       style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                  //     ),
                  //     Row(
                  //       children: [
                  //         Flexible(
                  //           child: Text(
                  //             reminder.purpose ?? "",
                  //             softWrap: true,
                  //             style: TextStyle(
                  //               fontSize: 8 * 3,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
