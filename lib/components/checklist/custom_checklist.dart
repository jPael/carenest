import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomChecklist extends StatelessWidget {
  const CustomChecklist(
      {super.key, this.checked = false, required this.label, this.labelStyle, this.iconSize});

  final String label;
  final bool checked;
  final TextStyle? labelStyle;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Flexible(
          child: Text(
            label,
            softWrap: true,
            style: labelStyle ?? const TextStyle(fontSize: 8 * 3),
          ),
        ),
        checked
            ? Icon(
                Ionicons.checkmark_circle,
                color: Colors.green,
                size: iconSize,
              )
            : Icon(
                Ionicons.close_circle,
                color: Colors.red,
                size: iconSize,
              )
      ],
    );
  }
}
