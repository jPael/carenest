import 'package:flutter/material.dart';
import 'package:smartguide_app/models/revamp/child_care_tips.dart';
import 'package:smartguide_app/pages/mother/childcare_tips/childcare_tips_feed_view_page.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({super.key, required this.data});

  final ChildCareTips data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ChildcareTipsFeedViewPage(data: data))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8 * 2),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    data.title,
                    softWrap: true,
                    style: const TextStyle(fontSize: 8 * 3),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
