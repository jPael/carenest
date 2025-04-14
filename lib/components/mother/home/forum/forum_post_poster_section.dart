import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/forum/forum_like_button.dart';
import 'package:smartguide_app/models/forum/forum.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForumPostPosterSection extends StatefulWidget {
  const ForumPostPosterSection(
      {super.key, required this.user, this.liked, required this.date, required this.forum});

  final String user;
  final bool? liked;
  final DateTime date;
  final Forum forum;
  @override
  State<ForumPostPosterSection> createState() => _ForumPostPosterSectionState();
}

class _ForumPostPosterSectionState extends State<ForumPostPosterSection> {
  final double profileImageSize = 50.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String timeHumanize = timeago.format(widget.date, locale: "en");

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            children: [
              ForumLikeButton(
                forum: widget.forum,
                direction: LikeButtonDirection.horizontal,
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.user,
              style: const TextStyle(
                fontSize: 8 * 2,
                fontWeight: FontWeight.w500,
              ),
              softWrap: true,
            ),
            Text(
              timeHumanize,
              style: const TextStyle(
                fontSize: 8 * 1.5,
              ),
              softWrap: true,
            ),
          ],
        ),
      ],
    );
  }
}
