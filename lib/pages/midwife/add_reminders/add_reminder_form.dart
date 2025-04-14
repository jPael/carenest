import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/fields/reminder_fields.dart';
import 'package:smartguide_app/models/reminder.dart';

class AddReminderForm extends StatefulWidget {
  const AddReminderForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.purposeController,
    required this.date,
    required this.reminderType,
    required this.onChangeReminderType,
    required this.onReminderDateChange,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController purposeController;
  final DateTime date;
  final ReminderTypeEnum? reminderType;
  final Function(ReminderTypeEnum?) onChangeReminderType;
  final Function(DateTime) onReminderDateChange;

  @override
  AddReminderFormState createState() => AddReminderFormState();
}

class AddReminderFormState extends State<AddReminderForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton(
              alignment: Alignment.centerLeft,
              value: widget.reminderType,
              hint: const Text("Set icon"),
              items: imagePaths
                  .map((Map<String, dynamic> i) => DropdownMenuItem(
                      alignment: Alignment.center,
                      value: i[ReminderFields.type] as ReminderTypeEnum,
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 20,
                        child: Image.asset(i[ReminderFields.image], fit: BoxFit.cover),
                      )))
                  .toList(),
              onChanged: widget.onChangeReminderType,
            ),
            TextFormField(
              controller: widget.titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 8 * 2,
            ),
            CustomInput.datepicker(
                context: context,
                onChange: widget.onReminderDateChange,
                selectedDate: widget.date,
                label: "Date"),
            const SizedBox(
              height: 8 * 2,
            ),
            // CustomInput.timepicker(
            //     context: context,
            //     onChange: widget.onReminderTimeChange,
            //     selectedTime: widget.time,
            //     label: "Time"),
            const SizedBox(
              height: 8 * 2,
            ),
            // TextFormField(
            //   controller: widget.purposeController,
            //   minLines: 5,
            //   maxLines: 6,
            //   decoration: InputDecoration(labelText: 'Purpose', border: OutlineInputBorder()),
            //   validator: (value) {
            //     if (value == null || value.isEmpty) {
            //       return 'Please enter a purpose';
            //     }
            //     return null;
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
