import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/chat/chat_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(8 * 2),
          child: CustomSection(emptyChildrenContent: Text("No Midwife is available"), children: [
            ChatItem(
              user: "Maria",
              message:
                  "Your appointment is confirmed for February 23, 2025, at 3:00 PM. Let me know if you need to reschedule! 😊",
            )
          ])),
    );
  }
}
