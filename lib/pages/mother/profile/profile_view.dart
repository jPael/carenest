import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/profile/profile_account_information_item.dart';
import 'package:smartguide_app/components/mother/profile/profile_personal_information_item.dart';
import 'package:smartguide_app/components/mother/profile/profile_user_section.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final Image profileImage = Image.asset("lib/assets/images/profile_fallback.png");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ProfileUserSection(),
          CustomSection(
            childrenSpacing: 2,
            children: [
              ProfilePersonalInformationItem(),
              ProfileAccountInformationItem(),
            ],
          )
        ],
      ),
    );
  }
}
