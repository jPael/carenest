import 'package:flutter/material.dart';

class FeedViewTitleSection extends StatelessWidget {
  const FeedViewTitleSection({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Text(
          title,
          softWrap: true,
          style: const TextStyle(fontSize: 8 * 4, fontWeight: FontWeight.w500),
        ))
      ],
    );
  }
}
