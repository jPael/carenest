import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Hero(
          tag: label,
          child: Container(
            height: 80,
            width: 80,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: OverflowBox(
              minHeight: 50,
              minWidth: 50,
              maxHeight: 150,
              maxWidth: 150,
              child:
                  Image.asset("lib/assets/images/mother_home_tips_icon.png", fit: BoxFit.contain),
            ),
          ),
        ),
        const SizedBox(
          width: 8 * 3,
        ),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good day!",
              style: TextStyle(fontSize: 8 * 4, fontWeight: FontWeight.w500),
            ),
            Text(
              "Marry",
              style:
                  TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500, color: Colors.redAccent),
            ),
          ],
        ),
      ],
    );
  }
}
