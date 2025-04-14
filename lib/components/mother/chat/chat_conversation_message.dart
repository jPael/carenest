import 'dart:developer';

import 'package:flutter/material.dart';

enum MessageType { outgoing, incoming }

class ChatConversationMessage extends StatelessWidget {
  const ChatConversationMessage(
      {super.key, required this.type, required this.content, required this.userEmail});

  final String content;
  final MessageType type;
  final String userEmail;

  // final Image img = Image.asset("lib/assets/images/profile_fallback.png");

  @override
  Widget build(BuildContext context) {
    log(userEmail);

    switch (type) {
      case MessageType.incoming:
        return Padding(
          padding: const EdgeInsets.all(8.0 * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CircleAvatar(
                foregroundImage: NetworkImage("https://i.pravatar.cc/200?u=$userEmail"),
                backgroundImage: const AssetImage("lib/assets/images/profile_fallback.png"),
              ),
              const SizedBox(
                width: 8,
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8 * 2),
                  decoration: BoxDecoration(
                      color: const Color(0xffA0E9E0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8 * 2),
                          bottomRight: Radius.circular(8 * 2),
                          topRight: Radius.circular(8 * 2))),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          content,
                          style: const TextStyle(fontSize: 8 * 2),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      case MessageType.outgoing:
        return Padding(
          padding: const EdgeInsets.all(8.0 * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Container(
                  padding: const EdgeInsets.all(8 * 2),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 0),
                        ),
                      ],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8 * 2),
                          bottomLeft: Radius.circular(8 * 2),
                          topRight: Radius.circular(8 * 2))),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(
                          content,
                          style: TextStyle(
                              fontSize: 8 * 2, color: Theme.of(context).colorScheme.inversePrimary),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              CircleAvatar(
                foregroundImage: NetworkImage("https://i.pravatar.cc/200?u=$userEmail"),
                backgroundImage: const AssetImage("lib/assets/images/profile_fallback.png"),
              ),
            ],
          ),
        );
    }
  }
}
