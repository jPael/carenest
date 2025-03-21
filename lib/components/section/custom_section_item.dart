import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomSectionItem extends StatefulWidget {
  const CustomSectionItem(
      {super.key,
      required this.title,
      required this.user,
      required this.replyCount,
      required this.date,
      this.liked,
      required this.onTap});

  final String title;
  final String user;
  final int replyCount;
  final DateTime date;
  final bool? liked;
  final GestureTapCallback onTap;

  @override
  State<CustomSectionItem> createState() => _CustomSectionItemState();
}

class _CustomSectionItemState extends State<CustomSectionItem> {
  final double profileImageSize = 50.0;
  bool liked = false;

  void handleLike() {
    setState(() {
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

    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
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
                      widget.title,
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
                      widget.user,
                      style: TextStyle(
                          fontSize: 8 * 2.3,
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
                      "${widget.replyCount} replies",
                      style: TextStyle(
                        fontSize: 8 * 2,
                        fontWeight: FontWeight.w600,
                      ),
                      softWrap: true,
                    )),
                  ],
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 8 * 2,
            children: [
              IconButton(
                  iconSize: 8 * 4,
                  onPressed: handleLike,
                  icon: liked
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border)),
              Text(timeHumanize)
            ],
          )
        ],
      ),
    );
  }
}
