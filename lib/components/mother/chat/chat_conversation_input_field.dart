import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/services/chat_services.dart';

class ChatConversationInputField extends StatefulWidget {
  const ChatConversationInputField(
      {super.key, required this.receiverId, required this.receiverEmail});

  final String receiverId;
  final String receiverEmail;

  @override
  State<ChatConversationInputField> createState() => _ChatConversationInputFieldState();
}

class _ChatConversationInputFieldState extends State<ChatConversationInputField> {
  final TextEditingController messageController = TextEditingController();

  final ChatServices chatServices = ChatServices();

  Future<void> sendMessage() async {
    if (messageController.text.isNotEmpty) {
      if (kDebugMode) {
        print("sending: ${messageController.text}");
      }
      await chatServices.sendMessage(widget.receiverId, messageController.text);

      messageController.clear();
    }
  }

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
            child: CustomInput.text(
                context: context, controller: messageController, label: "Write your message..."),
          ),
          IconButton(
            onPressed: sendMessage,
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
