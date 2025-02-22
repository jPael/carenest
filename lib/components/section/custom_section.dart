import 'package:flutter/material.dart';

class CustomSection extends StatelessWidget {
  const CustomSection({super.key, this.title, required this.children});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8 * 2,
      children: [
        if (title != null)
          Row(
            children: [
              Text(
                title!,
                style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        Column(spacing: 8 * 2, children: children)
      ],
    );
  }
}
