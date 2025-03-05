import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/mother/profile/profile_account_information_item.dart';
import 'package:smartguide_app/components/mother/profile/profile_personal_information_item.dart';
import 'package:smartguide_app/components/mother/profile/profile_user_section.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/user.dart' as currentUser;

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final Image profileImage = Image.asset("lib/assets/images/profile_fallback.png");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<currentUser.User>(
        builder: (context, user, child) {
          final data = user.getUser;

          return Column(
            children: [
              ProfileUserSection(
                firstname: data[UserFields.firstname]!,
              ),
              CustomSection(
                childrenSpacing: 2,
                children: [
                  ProfilePersonalInformationItem(
                    firstname: data[UserFields.firstname],
                    lastname: data[UserFields.lastname],
                    dateOfBirth: data[UserFields.dateOfBirth],
                    address: data[UserFields.address],
                    phoneNumber: data[UserFields.phoneNumber],
                  ),
                  ProfileAccountInformationItem(email: data[UserFields.email]),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
