import 'package:flutter/material.dart';

class ChatUserDetailsSection extends StatelessWidget {
  const ChatUserDetailsSection({super.key});

  final double profileImageSize = 90.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 8,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8 * 5),
            height: profileImageSize,
            width: profileImageSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: OverflowBox(
              child: Image.asset("lib/assets/images/profile_fallback.png"),
            ),
          ),
          Text(
            "Maria",
            style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
          ),
          Text("Purisima, Tago, Surigao Del Sur"),
          Text("Midwife"),
        ],
      ),
    );
  }
}
