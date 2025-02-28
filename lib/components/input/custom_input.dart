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
