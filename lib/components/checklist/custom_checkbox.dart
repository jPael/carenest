import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({super.key, required this.label, required this.value, this.onChange});

  final String label;
  final bool value;
  final Function(bool?)? onChange;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
      tileColor: Theme.of(context).primaryColor.withValues(alpha: value ? 0.2 : 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4 * 4)),
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: onChange,
      title: Text(label),
    );
  }
}
