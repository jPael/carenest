import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/utils/utils.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final User user = context.read<User>();

    final String g = getGreeting();

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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              g,
              style: TextStyle(fontSize: 8 * 4, fontWeight: FontWeight.w500),
            ),
            Text(
              "${user.firstname}",
              style: const TextStyle(
                  fontSize: 8 * 3, fontWeight: FontWeight.w500, color: Colors.redAccent),
            ),
          ],
        ),
      ],
    );
  }
}
