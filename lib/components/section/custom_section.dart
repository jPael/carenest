import 'package:flutter/material.dart';

class CustomSection extends StatelessWidget {
  const CustomSection(
      {super.key,
      this.title,
      this.children = const [],
      this.emptyChildrenContent,
      this.spacing = 2});

  final String? title;
  final List<Widget> children;
  final Widget? emptyChildrenContent;
  final int spacing;

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
        Column(
            spacing: 8.0 * spacing,
            children: children.isEmpty
                ? [
                    Padding(
                      padding: const EdgeInsets.all(8.0 * 4),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [emptyChildrenContent ?? Text("Empty")],
                        ),
                      ),
                    )
                  ]
                : children)
      ],
    );
  }
}
