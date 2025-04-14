import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/chatbot/chatbot_input_field.dart';
import 'package:smartguide_app/components/mother/home/chatbot/conversation.dart';

class ChatbotChatPage extends StatelessWidget {
  const ChatbotChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "MOMI AI",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue[700],
      ),
      body: const Column(
        children: [
          Expanded(child: SingleChildScrollView(child: Conversation())),
          ChatbotInputField()
        ],
      ),
    );
  }
}
