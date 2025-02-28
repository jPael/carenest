import 'package:flutter/material.dart';

class ConversationItemUser extends StatelessWidget {
  const ConversationItemUser({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.blue[700],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8 * 2),
                      bottomRight: Radius.circular(8 * 2),
                      topLeft: Radius.circular(8 * 2))),
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.white, fontSize: 8 * 3),
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
