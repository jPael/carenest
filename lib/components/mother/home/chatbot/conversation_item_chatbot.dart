import 'package:flutter/material.dart';

class ConversationItemChatbot extends StatelessWidget {
  const ConversationItemChatbot({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    Image img = Image.asset("lib/assets/images/mother_chatbot_icon.png");

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            backgroundImage: img.image,
          ),
          const SizedBox(
            width: 8,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(8 * 2),
                      bottomRight: Radius.circular(8 * 2),
                      topRight: Radius.circular(8 * 2))),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      message,
                      style: const TextStyle(fontSize: 8 * 3),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
