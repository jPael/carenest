import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/chat/chat_conversation_message.dart';

class ChatConversationSection extends StatelessWidget {
  const ChatConversationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChatConversationMessage(
          type: MessageType.outgoing,
          content: "Hi, Midwife Maria, can I take Vitamin C alongside my prenatal vitamins?",
        ),
        ChatConversationMessage(
          type: MessageType.incoming,
          content: "Yes, Vitamin C is safe, but please stick to the recommended dose",
        ),
        ChatConversationMessage(
          type: MessageType.incoming,
          content: "Yes, Vitamin C is safe, but please stick to the recommended dose",
        ),
        ChatConversationMessage(
          type: MessageType.incoming,
          content: "Yes, Vitamin C is safe, but please stick to the recommended dose",
        ),
        ChatConversationMessage(
          type: MessageType.incoming,
          content: "Yes, Vitamin C is safe, but please stick to the recommended dose",
        ),
        ChatConversationMessage(
          type: MessageType.incoming,
          content: "Yes, Vitamin C is safe, but please stick to the recommended dose",
        ),
        ChatConversationMessage(
          type: MessageType.incoming,
          content: "Yes, Vitamin C is safe, but please stick to the recommended dose",
        ),
      ],
    );
  }
}
