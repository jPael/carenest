import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/models/forum/forum.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/services/forum/forum_services.dart';

enum LikeButtonDirection { vertical, horizontal }

class ForumLikeButton extends StatefulWidget {
  const ForumLikeButton(
      {super.key,
      required this.forum,
      this.showLikeCount = true,
      this.direction = LikeButtonDirection.vertical});

  final Forum forum;
  final bool showLikeCount;
  final LikeButtonDirection direction;

  @override
  State<ForumLikeButton> createState() => _ForumLikeButtonState();
}

class _ForumLikeButtonState extends State<ForumLikeButton> {
  final ForumServices forumServices = ForumServices();
  late final User user;

  bool liked = false;
  int likeCount = 0;

  Future<void> handleLike() async {
    setState(() {
      liked = !liked;
    });

    final res = await widget.forum.likePost(user.uid!);

    if (res["success"] == false) {
      setState(() {
        liked = res["value"];
      });
      if (!mounted) return;
      showErrorMessage(context: context, message: res["message"]);
    }
  }

  @override
  void initState() {
    super.initState();
    likeCount = widget.forum.likes?.length ?? 0;
    user = context.read<User>();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.w500);

    return StreamBuilder<Object>(
      stream: forumServices.getLikeStreamByForumId(widget.forum.docId!, user.uid!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox();
        }

        int realLikeCount =
            ((snapshot.data as Map<String, dynamic>?)?["count"] as int?) ?? likeCount;

        final bool like = ((snapshot.data as Map<String, dynamic>?)?["isLiked"] as bool);

        if (widget.direction == LikeButtonDirection.vertical) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox.fromSize(
                size: Size.square(4 * 9),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    style: ButtonStyle(
                      iconSize: WidgetStatePropertyAll(4 * 8),
                    ),
                    onPressed: handleLike,
                    icon: like
                        ? Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : Icon(Icons.favorite_border)),
              ),
              widget.showLikeCount
                  ? Text(
                      realLikeCount.toString(),
                      style: textStyle,
                    )
                  : Container(),
            ],
          );
        } else {
          return Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                  iconSize: 8 * 4,
                  onPressed: handleLike,
                  icon: like
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                        )
                      : Icon(Icons.favorite_border)),
              widget.showLikeCount
                  ? Text(
                      realLikeCount.toString(),
                      style: textStyle,
                    )
                  : Container(),
            ],
          );
        }
      },
    );
  }
}
