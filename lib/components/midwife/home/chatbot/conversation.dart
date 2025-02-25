import 'package:flutter/material.dart';
import 'package:smartguide_app/components/midwife/home/chatbot/conversation_item_chatbot.dart';
import 'package:smartguide_app/components/midwife/home/chatbot/conversation_item_user.dart';

class Conversation extends StatelessWidget {
  const Conversation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          ConversationItemUser(
            message: "Ano ang dapat kainin para mawala ang morning sickness?",
          ),
          ConversationItemChatbot(message: '''
Here is the step by step guidance:

Step 1: Kumain ng maliliit na pagkain tulad ng tinapay o crackers.

Step 2: Uminom ng tubig sa maliliit na lagok para manatiling hydrated.

Step 3: Subukang uminom ng luya na tsaa para maibsan ang pagsusuka.

Panoorin ang 2-minutong video na ito para sa karagdagang gabay [Link] provide by the RHO Admin
'''),
          ConversationItemUser(
            message: "What are the best travel destinations?",
          ),
          ConversationItemChatbot(
              message:
                  '''I’m here to help with maternal and childcare guidance. Can I assist you with baby care tips or health advice?''')
        ],
      ),
    );
  }
}
