import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/midwife/reminders/reminders_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class AddRemindersPage extends StatefulWidget {
  const AddRemindersPage({super.key});

  @override
  State<AddRemindersPage> createState() => _AddRemindersPageState();
}

class _AddRemindersPageState extends State<AddRemindersPage> {
  final List<Map<String, dynamic>> reminders = [];

  void handleAddReminders(Map<String, dynamic> data) {
    setState(() {
      reminders.add(data);
    });
  }

  void handleDelete(int code) {
    setState(() {
      reminders.removeWhere((element) => element['code'] == code);
    });
  }

  void _showAddReminderDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    String title = '';
    String purpose = '';
    String? selectedPath;
    DateTime date = DateTime.now();
    TimeOfDay time = TimeOfDay.now();

    final List<String> imagePaths = [
      "lib/assets/images/reminders_card_prenatal_checkup_icon.png",
      "lib/assets/images/reminders_card_nutrition_seminar_icon.png",
      "lib/assets/images/reminders_card_vaccination_drive_icon.png"
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Add Reminder'),
              content: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton(
                        alignment: Alignment.centerLeft,
                        value: selectedPath,
                        hint: Text("Set icon"),
                        items: imagePaths
                            .map((String i) => DropdownMenuItem(
                                alignment: Alignment.center,
                                value: i,
                                child: Row(
                                  children: [
                                    Image.asset(i, width: 50, height: 50, fit: BoxFit.cover),
                                  ],
                                )))
                            .toList(),
                        onChanged: (e) {
                          setState(() {
                            selectedPath = e;
                          });
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Title'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          title = value!;
                        },
                      ),
                      const SizedBox(
                        height: 8 * 2,
                      ),
                      CustomInput.datepicker(
                          context: context,
                          onChange: (d) {
                            setState(() {
                              date = d;
                            });
                          },
                          selectedDate: date,
                          label: "Date"),
                      const SizedBox(
                        height: 8 * 2,
                      ),
                      CustomInput.timepicker(
                          context: context,
                          onChange: (t) {
                            setState(() {
                              time = t;
                            });
                          },
                          selectedTime: time,
                          label: "Time"),
                      const SizedBox(
                        height: 8 * 2,
                      ),
                      TextFormField(
                        minLines: 5,
                        maxLines: 6,
                        decoration:
                            InputDecoration(labelText: 'Purpose', border: OutlineInputBorder()),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a purpose';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          purpose = value!;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save(); // Save the form data

                      int? code;

                      while (true) {
                        code = int.parse(DateFormat('HHmm').format(DateTime.now()));

                        if (!reminders.any((element) => element['code'] == code)) {
                          break;
                        }
                      }
                      handleAddReminders({
                        'code': code,
                        'title': title,
                        'purpose': purpose,
                        'icon': selectedPath,
                        'date': date,
                        'time': time
                      });
                      Navigator.of(context).pop(); // Close the dialog
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
                children: [
                  ...reminders.map((reminder) {
                    return RemindersItem(
                        data: reminder, handleDelete: (code) => handleDelete(code));
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
