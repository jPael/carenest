import 'package:flutter/material.dart';
import 'package:smartguide_app/features/chatbot/widgets/bot_message.dart';
import 'package:smartguide_app/features/chatbot/widgets/chat_input_field.dart';
import 'package:smartguide_app/features/chatbot/widgets/user_message.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text(
          "MOMI AI",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    UserMessage(
                      message: "Ano ang dapat kainin para mawala ang morning sickness?",
                    ),
                    BotMessage(message: '''
Here is the step by step guidance:
        
Step 1: Kumain ng maliliit na pagkain tulad ng tinapay o crackers.

Step 2: Uminom ng tubig sa maliliit na lagok para manatiling hydrated.

Step 3: Subukang uminom ng luya na tsaa para maibsan ang pagsusuka.

Panoorin ang 2-minutong video na ito para sa karagdagang gabay [Link] provide by the RHO Admin'''),
                    UserMessage(
                      message: "What are the best travel destinations?",
                    ),
                    BotMessage(
                        message: '''I’m here to help with maternal and childcare guidance. Can I assist you with baby care tips or health advice?''')
                  ],
                ),
              ),
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}
