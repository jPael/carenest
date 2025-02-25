import 'package:flutter/material.dart';
import 'package:smartguide_app/components/midwife/home/chatbot/chatbot_hero.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0 * 3),
        child: Column(
          children: [ChatbotHero(label: label)],
        ),
      ),
    );
  }
}
