import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/chat/chat_conversation_message.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/fields/message_fields.dart';
import 'package:smartguide_app/services/chat_services.dart';
import 'package:smartguide_app/services/user_services.dart';

class ChatConversationSection extends StatelessWidget {
  ChatConversationSection({super.key, required this.receiverId, required this.receiverEmail});

  final String receiverId;
  final String receiverEmail;

  final ChatServices chatServices = ChatServices();
  @override
  Widget build(BuildContext context) {
    final String userId = getCurrentUser!.uid;

    return StreamBuilder(
        stream: chatServices.getMessages(userId, receiverId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.only(top: 10 * 8.0),
              child: CustomSection(
                children: [
                  Text(
                    "There was an error. Please try again later",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 4 * 8, fontWeight: FontWeight.bold, color: Colors.red[900]),
                  )
                ],
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.only(top: 10 * 8.0),
              child: CustomSection(
                children: [CircularProgressIndicator()],
              ),
            );
          }

          return Column(
            children: [
              ...(snapshot.data)!.docs.map((doc) {
                final data = doc.data() as Map<String, dynamic>;

                final String senderEmail = getCurrentUser!.email!;

                final MessageType type = data[MessageFields.senderId] != userId
                    ? MessageType.incoming
                    : MessageType.outgoing;

                final email = type == MessageType.outgoing ? senderEmail : receiverEmail;

                return ChatConversationMessage(
                    userEmail: email, type: type, content: doc[MessageFields.message]);
              })
            ],
          );
        });
  }
}
