import 'package:flutter/material.dart';
import 'package:smartguide_app/models/forum/reply.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForumMessageBubble extends StatefulWidget {
  const ForumMessageBubble({super.key, required this.reply});

  final Reply reply;

  @override
  State<ForumMessageBubble> createState() => _ForumMessageBubbleState();
}

class _ForumMessageBubbleState extends State<ForumMessageBubble> {
  bool liked = false;

  void handleLike() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double profileImageSize = 40.0;

    final String timeHumanize = timeago.format(widget.reply.createdAt!.toDate());

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Container(
              height: profileImageSize,
              width: profileImageSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: OverflowBox(
                child: Image.asset("lib/assets/images/profile_fallback.png"),
              ),
            ),
            Expanded(
              child: Column(
                spacing: 0,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Color(
                          0xFFEDEDED,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.reply.author!.firstname} ${widget.reply.author!.lastname}",
                          style: TextStyle(
                            fontSize: 8 * 2.5,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: Text(
                              widget.reply.content,
                              style: TextStyle(fontSize: 8 * 2),
                              softWrap: true,
                            )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(timeHumanize),
                      // InkWell(
                      //   onTap: () => Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => ForumReplyPage(
                      //               title:
                      //                   "${widget.reply.author!.firstname} ${widget.reply.author!.lastname}"))),
                      //   child: Text(
                      //     "Reply",
                      //     style: TextStyle(fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                      // IconButton(
                      //     onPressed: handleLike,
                      //     icon: liked
                      //         ? Icon(
                      //             Icons.favorite,
                      //             color: Colors.red,
                      //           )
                      //         : Icon(Icons.favorite_outline))
                    ],
                  ),
                  // Column(
                  //   spacing: 8,
                  //   children: [if (widget.replies != null) ...widget.replies!],
                  // )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
