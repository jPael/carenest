import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/pages/mother/chatbot/chatbot_chat_page.dart';

class ChatbotHero extends StatelessWidget {
  const ChatbotHero({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Hero(
          tag: label,
          child: Container(
            height: 240,
            width: 240,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: OverflowBox(
              minHeight: 50,
              minWidth: 50,
              maxHeight: 250,
              maxWidth: 250,
              child: Image.asset("lib/assets/images/mother_chatbot_icon.png", fit: BoxFit.contain),
            ),
          ),
        ),
        const SizedBox(
          height: 8 * 3,
        ),
        Text(
          "Hi!👋 How can i help you today?",
          style: TextStyle(fontSize: 8 * 3.5),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 8 * 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
                child: Text(
              "Start chatting with MOMI AI now you can ask me anything",
              style: TextStyle(fontSize: 8 * 2.5),
              textAlign: TextAlign.center,
              softWrap: true,
            )),
          ],
        ),
        const SizedBox(
          height: 8 * 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0 * 3),
          child: CustomButton.large(
              context: context,
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ChatbotChatPage())),
              label: "Start Chat",
              radius: 3,
              color: Colors.blueAccent[700]),
        )
      ],
    ));
  }
}
