import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/pages/mother/chat/chat_message_view.dart';

class ChatItem extends StatelessWidget {
  ChatItem({super.key, required this.user, this.message});

  final Map<String, dynamic> user;
  final String? message;

  final double profileImageSize = 60.0;
  final String time = DateFormat('KK:mm a').format(DateTime.now());

  void onTap(context) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ChatMessageView(
                receiver: user,
              )));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            CircleAvatar(
              foregroundImage:
                  NetworkImage("https://i.pravatar.cc/200?u=${user[UserFields.email]}"),
              backgroundImage: const AssetImage("lib/assets/images/profile_fallback.png"),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${user[UserFields.firstname]} ${user[UserFields.lastname]} | ${user[UserFields.userType]}",
                        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 8 * 3),
                      ),
                    ],
                  ),
                  if (message != null)
                    Row(
                      spacing: 8,
                      children: [
                        Flexible(
                          child: Text(
                            message!,
                            style: const TextStyle(fontSize: 8 * 2),
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            // Column(
            //   spacing: 8,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Icon(
            //       Icons.circle,
            //       color: Colors.greenAccent,
            //       size: 8 * 2,
            //     ),
            //     Text(time)
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
