import 'package:flutter/material.dart';
import 'package:smartguide_app/pages/mother/childcare_tips/childcare_tips_feed_view_page.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ChildcareTipsFeedViewPage(title: title))),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8 * 2),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    title,
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
