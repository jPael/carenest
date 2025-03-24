import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/mother/profile/profile_account_information_item.dart';
import 'package:smartguide_app/components/mother/profile/profile_personal_information_item.dart';
import 'package:smartguide_app/components/mother/profile/profile_user_section.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/user.dart' as current_user;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int? idOpened;

  UniqueKey personalInformationItemKey = UniqueKey();
  UniqueKey accountInformationItemKey = UniqueKey();

  void setIdOpened(int? i) {
    setState(() {
      if (i == null) {
        personalInformationItemKey = UniqueKey();
        accountInformationItemKey = UniqueKey();
      } else if (i == 0) {
        accountInformationItemKey = UniqueKey();
      } else if (i == 1) {
        personalInformationItemKey = UniqueKey();
      }

      idOpened = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Consumer<current_user.User>(
        builder: (context, user, child) {
          final data = user.getUser;

          return Column(
            children: [
              ProfileUserSection(
                firstname: data[UserFields.firstname]!,
                email: data[UserFields.email] as String,
              ),
              CustomSection(
                childrenSpacing: 2,
                children: [
                  ProfilePersonalInformationItem(
                    key: personalInformationItemKey,
                    id: 0,
                    idOpened: idOpened,
                    setIdOpened: setIdOpened,
                    firstname: data[UserFields.firstname],
                    lastname: data[UserFields.lastname],
                    dateOfBirth: data[UserFields.dateOfBirth],
                    address: data[UserFields.address],
                    phoneNumber: data[UserFields.phoneNumber],
                  ),
                  ProfileAccountInformationItem(
                      key: accountInformationItemKey,
                      id: 1,
                      idOpened: idOpened,
                      setIdOpened: setIdOpened,
                      email: data[UserFields.email]),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
