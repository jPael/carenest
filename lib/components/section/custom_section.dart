import 'package:flutter/material.dart';

class CustomSection extends StatelessWidget {
  const CustomSection(
      {super.key,
      this.title,
      this.children = const [],
      this.emptyChildrenContent,
      this.childrenSpacing = 2,
      this.titleStyle,
      this.alignment,
      this.description,
      this.headerSpacing = 2,
      this.action});

  final String? title;
  final Widget? description;
  final TextStyle? titleStyle;
  final CrossAxisAlignment? alignment;
  final List<Widget> children;
  final Widget? action;
  final Widget? emptyChildrenContent;
  final int headerSpacing;
  final int childrenSpacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: alignment ?? CrossAxisAlignment.center,
      children: [
        if (title != null)
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  title!,
                  style: titleStyle ?? TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                  softWrap: true,
                ),
              ),
              action ?? Container()
            ],
          ),
        if (description != null) description!,
        SizedBox(
          height: 8.0 * headerSpacing,
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0 * childrenSpacing,
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
              : children,
        ),
      ],
    );
  }
}
