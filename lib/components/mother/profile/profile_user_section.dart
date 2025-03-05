import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartguide_app/components/button/custom_button.dart';

class ProfileUserSection extends StatelessWidget {
  ProfileUserSection({super.key, required this.firstname});

  final String firstname;

  void handleLogout() {
    FirebaseAuth.instance.signOut();
  }

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
          Expanded(
            child: Text(
              "Hi $firstname",
              style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500, color: Colors.white),
            ),
          ),
          CustomButton.ghost(
              context: context,
              onPressed: handleLogout,
              label: "Log out",
              horizontalPadding: 1.5,
              icon: Icon(Ionicons.log_out))
        ],
      ),
    );
  }
}
