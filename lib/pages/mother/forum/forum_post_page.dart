import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/forum/forum_message_bubble.dart';
import 'package:smartguide_app/components/mother/home/forum/forum_message_input_section.dart';
import 'package:smartguide_app/components/mother/home/forum/forum_post_poster_section.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/forum/forum.dart';
import 'package:smartguide_app/models/forum/reply.dart';
import 'package:smartguide_app/services/forum/forum_services.dart';

class ForumPostPage extends StatefulWidget {
  const ForumPostPage({super.key, this.liked, required this.forum});

  final Forum forum;
  final bool? liked;

  @override
  State<ForumPostPage> createState() => _ForumPostPageState();
}

class _ForumPostPageState extends State<ForumPostPage> {
  final ForumServices forumServices = ForumServices();

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
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8 * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 8 * 2,
                    children: [
                      Card(
                        margin: const EdgeInsets.all(0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2 * 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.forum.title,
                                style: TextStyle(fontSize: 8 * 4, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.forum.content,
                                style: TextStyle(fontSize: 4 * 4),
                              ),
                              const SizedBox(
                                height: 4 * 2,
                              ),
                              ForumPostPosterSection(
                                forum: widget.forum,
                                user:
                                    "${widget.forum.author!.firstname} ${widget.forum.author!.lastname}",
                                date: (widget.forum.createdAt as Timestamp).toDate(),
                                liked: liked,
                              ),
                            ],
                          ),
                        ),
                      ),
                      StreamBuilder<Object>(
                          stream: forumServices.getReplyStreamByForumId(widget.forum.docId!),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10 * 8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      textAlign: TextAlign.center,
                                      "Something went wrong... please try again",
                                      style: TextStyle(
                                          fontSize: 4 * 8,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red[900]),
                                    )
                                  ],
                                ),
                              );
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10 * 8.0),
                                child: Center(
                                  child: Column(
                                    spacing: 4 * 2,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CircularProgressIndicator(),
                                      Text(
                                        "Loading, please wait...",
                                        style:
                                            TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }

                            final List<Reply> replies = snapshot.data as List<Reply>;

                            return CustomSection(
                              children: replies
                                  .map(
                                    (reply) => ForumMessageBubble(reply: reply),
                                  )
                                  .toList(),
                            );
                          })
                    ],
                  ),
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
