import 'package:flutter/material.dart';

class CareAndTestsAdviceItem extends StatelessWidget {
  const CareAndTestsAdviceItem({super.key, required this.content});

  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 4 * 2,
      children: [
        const Icon(
          Icons.circle,
          size: 4 * 3,
        ),
        Text(
          content,
          style: const TextStyle(fontSize: 4 * 4),
        ),
      ],
    );
  }
}
