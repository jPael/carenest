import 'package:flutter/material.dart';

class ProfileUserSection extends StatelessWidget {
  const ProfileUserSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8 * 3, right: 8 * 3, top: 8 * 8, bottom: 8 * 4),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
      child: Row(
        spacing: 8 * 2,
        children: [
          Container(
            height: 80,
            width: 80,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all()),
            child: OverflowBox(
              minHeight: 50,
              minWidth: 50,
              maxHeight: 100,
              maxWidth: 100,
              child: Image.asset("lib/assets/images/profile_fallback.png", fit: BoxFit.contain),
            ),
          ),
          Text(
            "Hi [Username]",
            style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500, color: Colors.white),
          )
        ],
      ),
    );
  }
}
