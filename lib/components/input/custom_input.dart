import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/datepicker.dart';
import 'package:smartguide_app/components/input/password.dart';

class CustomInput {
  static Widget text(
      {required BuildContext context,
      String label = "",
      String hint = "",
      Widget? startIcon,
      required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(label),
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8 * 2)),
          prefixIcon: startIcon),
    );
  }

  static Widget password(
      {required BuildContext context,
      required TextEditingController controller,
      String label = "",
      String hint = "",
      Icon? startIcon}) {
    return Password(controller: controller, label: label, hint: hint, startIcon: startIcon);
  }

  static Widget timepicker(
      {required BuildContext context,
      TimeOfDay? selectedTime,
      String label = "",
      String hint = "",
      required void Function(TimeOfDay) onChange}) {
    selectedTime ??= TimeOfDay.now();

    return GestureDetector(
      onTap: () async {
        final TimeOfDay? picked =
            await showTimePicker(context: context, initialTime: selectedTime ?? TimeOfDay.now());

        if (picked != null && picked != selectedTime) {
          onChange(picked);
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8 * 2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(selectedTime.format(context)),
            Icon(Icons.access_time),
          ],
        ),
      ),
    );
  }

  static Widget datepicker(
      {required BuildContext context,
      DateTime? selectedDate,
      DateTime? firstDate,
      DateTime? lastDate,
      String label = "",
      String hint = "",
      required void Function(DateTime) onChange}) {
    selectedDate ??= DateTime.now();
    firstDate ??= DateTime(1900);
    lastDate ??= DateTime(3000);

    return DatePicker(
      selectedDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
      onChange: onChange,
      label: label,
      hint: hint,
    );
  }
}
