import 'package:flutter/material.dart';
import 'package:smartguide_app/components/home/childcare_tips/feed_item.dart';

class FeedSection extends StatelessWidget {
  const FeedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FeedItem(
          title: "How to Help Your Baby Sleep Through the Night.",
        ),
        FeedItem(
          title: "5 Foods to Boost Baby’s Nutrition.",
        ),
        FeedItem(title: "How to Help Your Baby Sleep Safely."),
      ],
    );
  }
}
