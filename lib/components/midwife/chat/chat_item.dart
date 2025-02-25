import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/pages/midwife/chat/chat_message_view.dart';

class ChatItem extends StatelessWidget {
  ChatItem({super.key, required this.user, required this.message});

  final String user;
  final String message;

  final double profileImageSize = 60.0;
  final String time = DateFormat('KK:mm a').format(DateTime.now());

  void onTap(context) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => ChatMessageView()));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      user,
                      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 8 * 3),
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    Flexible(
                      child: Text(
                        message,
                        style: TextStyle(fontSize: 8 * 2),
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Icon(
                Icons.circle,
                color: Colors.greenAccent,
                size: 8 * 2,
              ),
              Text(time)
            ],
          )
        ],
      ),
    );
  }
}
