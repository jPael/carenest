import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({
    super.key,
    this.label,
    required this.children,
    required this.actions,
  });

  final String? label;
  final List<Widget> children;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label ?? "",
              style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
            )
          ],
        ),
        const SizedBox(
          height: 8 * 3,
        ),
        ...children,
        const SizedBox(
          height: 8 * 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [...actions],
        )
      ],
    );
  }
}
