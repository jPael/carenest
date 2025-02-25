import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';

class ChatConversationInputField extends StatefulWidget {
  const ChatConversationInputField({super.key});

  @override
  State<ChatConversationInputField> createState() => _ChatConversationInputFieldState();
}

class _ChatConversationInputFieldState extends State<ChatConversationInputField> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.multitrack_audio_outlined)),
          Expanded(
            child: CustomInput.text(
                context: context, controller: messageController, label: "Write your message..."),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.send_rounded,
            ),
            iconSize: 8 * 4,
            color: Colors.blue[700],
          )
        ],
      ),
    );
  }
}
