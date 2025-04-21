
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
      this.isLoading = false,
      this.action,
      this.isLoadingWidget});

  final String? title;
  final Widget? description;
  final TextStyle? titleStyle;
  final CrossAxisAlignment? alignment;
  final List<Widget?> children;
  final Widget? action;
  final Widget? emptyChildrenContent;
  final int headerSpacing;
  final int childrenSpacing;
  final bool? isLoading;
  final Widget? isLoadingWidget;

  @override
  Widget build(BuildContext context) {
    final List<Widget> defaultLoadingWidget = List.generate(
        3,
        (int i) =>
            isLoadingWidget ??
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Header"),
                Text("Description"),
              ],
            ));

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isLoading != null && isLoading == true
          ? CrossAxisAlignment.start
          : alignment ?? CrossAxisAlignment.center,
      children: [
        if (title != null)
          Row(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title!,
                  style:
                      titleStyle ?? const TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.bold),
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
        Skeletonizer(
          enabled: isLoading ?? false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 8.0 * childrenSpacing,
            children: isLoading != null && isLoading == true
                ? defaultLoadingWidget
                : children.isEmpty
                    ? [
                        Padding(
                          padding: const EdgeInsets.all(8.0 * 4),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [emptyChildrenContent ?? const Text("Empty")],
                            ),
                          ),
                        )
                      ]
                    : children.where((child) => child != null).toList().cast<Widget>(),
          ),
        ),
      ],
    );
  }
}
