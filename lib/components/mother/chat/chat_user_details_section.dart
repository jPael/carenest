import 'package:flutter/material.dart';

class ChatUserDetailsSection extends StatelessWidget {
  const ChatUserDetailsSection(
      {super.key,
      required this.email,
      required this.name,
      required this.address,
      required this.type});

  final String email;
  final String name;
  final String address;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 8,
        children: [
          CircleAvatar(
            foregroundImage: NetworkImage("https://i.pravatar.cc/200?u=$email"),
            backgroundImage: AssetImage("lib/assets/images/profile_fallback.png"),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
          ),
          Text(address),
          Text(type),
        ],
      ),
    );
  }
}
