import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/mother/home/forum/forum_like_button.dart';
import 'package:smartguide_app/models/forum/forum.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/mother/forum/forum_post_page.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomSectionItem extends StatefulWidget {
  const CustomSectionItem({
    super.key,
    required this.forum,
  });

  final Forum forum;

  @override
  State<CustomSectionItem> createState() => _CustomSectionItemState();
}

class _CustomSectionItemState extends State<CustomSectionItem> {
  final double profileImageSize = 50.0;

  @override
  Widget build(BuildContext context) {
    // final User user = context.read<User>();
    // final isUser = widget.forum.authorId == user.uid;

    final String timeHumanize =
        timeago.format((widget.forum.createdAt as Timestamp).toDate(), locale: "en");

    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ForumPostPage(
                    forum: widget.forum,
                    liked: true,
                  ))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            foregroundImage:
                NetworkImage("https://i.pravatar.cc/200?u=${widget.forum.author!.email}"),
            backgroundImage: const AssetImage("lib/assets/images/profile_fallback.png"),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                        child: Text(
                      widget.forum.title,
                      style: const TextStyle(
                        fontSize: 4 * 6,
                        fontWeight: FontWeight.w500,
                      ),
                      softWrap: true,
                    )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            child: Text(
                          "${widget.forum.author!.firstname} ${widget.forum.author!.lastname}",
                          style: TextStyle(
                              fontSize: 4 * 4,
                              fontWeight: FontWeight.w500,
                              color: Colors.black.withValues(alpha: 0.5)),
                          softWrap: true,
                        )),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            child: Text(
                          "${widget.forum.replyCount} replies",
                          style: const TextStyle(
                            fontSize: 8 * 2,
                            fontWeight: FontWeight.w600,
                          ),
                          softWrap: true,
                        )),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [ForumLikeButton(forum: widget.forum), Text(timeHumanize)],
          )
        ],
      ),
    );
  }
}
