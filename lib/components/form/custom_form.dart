import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm(
      {super.key,
      this.label,
      required this.actions,
      required this.children,
      this.socials = const [],
      this.actionMainAxisAlignment,
      this.alignment,
      this.childrenSpacing = 0,
      this.headerSpacing = 3.0});

  final String? label;
  final List<Widget> children;
  final List<Widget> actions;
  final List<Widget> socials;
  final MainAxisAlignment? actionMainAxisAlignment;
  final CrossAxisAlignment? alignment;
  final double? childrenSpacing;
  final double headerSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: childrenSpacing ?? 8,
      crossAxisAlignment: alignment ?? CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Text(
                label!,
                style: const TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
              )
            ],
          ),
          SizedBox(
            height: 8 * headerSpacing,
          )
        ],
        ...children,
        const SizedBox(
          height: 8 * 3,
        ),
        Row(
          mainAxisAlignment: actionMainAxisAlignment ?? MainAxisAlignment.end,
          children: [...actions],
        ),
        const SizedBox(
          height: 8 * 2,
        ),
        if (socials.isNotEmpty) ...[
          const Divider(),
          const SizedBox(
            height: 8,
          ),
          ...socials
        ]
      ],
    );
  }
}
