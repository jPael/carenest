import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';

class ChatInputField extends StatefulWidget {
  final Function(String) onSendMessage;
  const ChatInputField({super.key, required this.onSendMessage});

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.multitrack_audio_outlined)),
          Expanded(
            child: CustomInput.text(context: context, controller: messageController, label: "Write your message..."),
          ),
          IconButton(
            onPressed: () {
              widget.onSendMessage(messageController.text);
              messageController.clear();
              FocusScope.of(context).unfocus();
            },
            icon: const Icon(
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
