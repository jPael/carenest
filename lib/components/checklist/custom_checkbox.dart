import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    super.key,
    required this.label,
    required this.value,
    this.onChange,
    this.customOnChange,
    this.id,
  }) : assert(
          (onChange == null && customOnChange != null) ||
              (onChange != null && customOnChange == null),
          'Either onChange or customOnChange must be provided, but not both',
        );

  final String? id;
  final String label;
  final bool value;
  final Function(bool?)? onChange;
  final Function(String, bool)? customOnChange;

  void checkListChange(bool? value) {
    if (onChange != null) {
      onChange!(value);
    } else if (customOnChange != null) {
      customOnChange!(id!, value!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile.adaptive(
      tileColor: Theme.of(context).primaryColor.withValues(alpha: value ? 0.2 : 0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4 * 4)),
      controlAffinity: ListTileControlAffinity.leading,
      value: value,
      onChanged: checkListChange,
      title: Text(label),
    );
  }
}
