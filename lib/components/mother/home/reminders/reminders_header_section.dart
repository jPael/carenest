import 'package:flutter/material.dart';

class RemindersHeaderSection extends StatelessWidget {
  const RemindersHeaderSection({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(spacing: 8, children: [
      Hero(
        tag: label,
        child: Container(
          height: 40,
          width: 40,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: OverflowBox(
            minHeight: 30,
            minWidth: 30,
            maxHeight: 40,
            maxWidth: 40,
            child: Image.asset("lib/assets/images/mother_home_reminders_icon.png",
                fit: BoxFit.contain),
          ),
        ),
      ),
      Text(
        label,
        style: TextStyle(fontSize: 8 * 4, fontWeight: FontWeight.w500),
      )
    ]);
  }
}
