import 'package:flutter/material.dart';

class ChatMessageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatMessageAppBar({Key? key}) : super(key: key);

  final double profileImageSize = 30.0;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Colors.white,
      title: Row(
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Midwife"),
              Row(
                spacing: 8 / 2,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Active now",
                    style: TextStyle(fontSize: 8 * 1.5),
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.greenAccent,
                    size: 8 * 1.5,
                  )
                ],
              )
            ],
          )
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.call_outlined)),
        IconButton(onPressed: () {}, icon: Icon(Icons.video_call_outlined)),
      ],
    );
  }
}
