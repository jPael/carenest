import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/forum/forum_message_bubble.dart';
import 'package:smartguide_app/components/mother/home/forum/forum_message_input_section.dart';
import 'package:smartguide_app/components/mother/home/forum/forum_post_poster_section.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/forum/forum.dart';

class ForumPostPage extends StatefulWidget {
  const ForumPostPage({super.key, this.liked, required this.forum});

  final Forum forum;
  final bool? liked;

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8 * 2),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8 * 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8 * 2,
                  children: [
                    Text(
                      widget.forum.title,
                      style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                    ),
                    Text(widget.forum.content),
                    const SizedBox(
                      height: 4 * 2,
                    ),
                    ForumPostPosterSection(
                      user: "${widget.forum.author!.firstname} ${widget.forum.author!.lastname}",
                      date: (widget.forum.createdAt as Timestamp).toDate(),
                      liked: liked,
                    ),
                    CustomSection(
                        children: widget.forum.replies!
                            .map((reply) => ForumMessageBubble(reply: reply))
                            .toList()),
                  ],
                ),
              ),
            ),
            ForumMessageInputSection(
              forum: widget.forum,
            )
          ],
        ),
      ),
    );
  }
}
