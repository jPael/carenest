import 'package:flutter/material.dart';

class BirthPlanItem extends StatelessWidget {
  const BirthPlanItem({super.key, required this.description, required this.value});

  final String description;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Text(
          "$description: ",
          style: const TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.w500),
        ),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 4 * 4),
          ),
        )
      ],
    );
  }
}
