import 'package:flutter/material.dart';

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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8 * 2, horizontal: 8 * 3),
          child: Column(
            children: [
              // ForumMessageBubble(
              //   reply: [

              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}
