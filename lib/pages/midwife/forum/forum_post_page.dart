import 'package:flutter/material.dart';
import 'package:smartguide_app/components/home/forum/forum_message_bubble.dart';
import 'package:smartguide_app/components/home/forum/forum_message_input_section.dart';
import 'package:smartguide_app/components/home/forum/forum_post_poster_section.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/section/custom_section_item.dart';

class ForumPostPage extends StatefulWidget {
  const ForumPostPage({super.key, required this.user, this.liked, required this.date});

  final String user;
  final bool? liked;
  final DateTime date;

  @override
  State<ForumPostPage> createState() => _ForumPostPageState();
}

class _ForumPostPageState extends State<ForumPostPage> {
  final double profileImageSize = 50.0;

  bool liked = false;

  @override
  void initState() {
    super.initState();
    liked = widget.liked ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        centerTitle: true,
        title: Text(widget.user),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8 * 2),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8 * 3),
                child: Column(
                  spacing: 8 * 3,
                  children: [
                    Text(
                      "What foods help with morning sickness?",
                      style: TextStyle(fontSize: 8 * 4, fontWeight: FontWeight.w500),
                    ),
                    ForumPostPosterSection(
                      user: widget.user,
                      date: widget.date,
                      liked: liked,
                    ),
                    CustomSection(children: [ForumMessageBubble()]),
                  ],
                ),
              ),
            ),
            ForumMessageInputSection()
          ],
        ),
      ),
    );
  }
}
