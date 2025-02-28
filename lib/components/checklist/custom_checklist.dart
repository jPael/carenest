import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class CustomChecklist extends StatelessWidget {
  const CustomChecklist({super.key, this.checked = false, required this.label});

  final String label;

  final bool checked;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 8 * 3),
        ),
        checked
            ? Icon(
                Ionicons.checkmark_circle,
                color: Colors.green,
              )
            : Icon(
                Ionicons.close_circle,
                color: Colors.red,
              )
      ],
    );
  }
}
