import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForumPostPosterSection extends StatefulWidget {
  const ForumPostPosterSection({super.key, required this.user, this.liked, required this.date});

  final String user;
  final bool? liked;
  final DateTime date;
  @override
  State<ForumPostPosterSection> createState() => _ForumPostPosterSectionState();
}

class _ForumPostPosterSectionState extends State<ForumPostPosterSection> {
  final double profileImageSize = 50.0;

  bool liked = false;
  int likeCount = 10;

  void handleLike() {
    setState(() {
      if (liked) {
        setState(() {
          likeCount--;
        });
      } else {
        setState(() {
          likeCount++;
        });
      }

      liked = !liked;
    });
  }

  @override
  void initState() {
    super.initState();
    liked = widget.liked ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final String timeHumanize = timeago.format(widget.date, locale: "en");

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                    widget.user,
                    style: TextStyle(
                      fontSize: 8 * 2.5,
                      fontWeight: FontWeight.w500,
                    ),
                    softWrap: true,
                  )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      child: Text(
                    timeHumanize,
                    style: TextStyle(
                      fontSize: 8 * 2,
                    ),
                    softWrap: true,
                  )),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
                onPressed: handleLike,
                icon: liked
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(Icons.favorite_outline_outlined)),
            Text(likeCount.toString())
          ],
        )
      ],
    );
  }
}
