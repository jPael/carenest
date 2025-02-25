import 'package:flutter/material.dart';
import 'package:smartguide_app/components/midwife/home/forum/forum_message_bubble.dart';

class ForumReplyPage extends StatelessWidget {
  const ForumReplyPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        forceMaterialTransparency: true,
        title: Text("Reply to $title"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8 * 2, horizontal: 8 * 3),
          child: Column(
            children: [
              ForumMessageBubble(
                replies: [
                  ForumMessageBubble(),
                  ForumMessageBubble(
                    replies: [
                      ForumMessageBubble(),
                      ForumMessageBubble(),
                    ],
                  ),
                  ForumMessageBubble(),
                  ForumMessageBubble(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
