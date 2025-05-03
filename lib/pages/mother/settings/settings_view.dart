import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/settings/settings_item.dart';
import 'package:smartguide_app/models/new_user.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/mother/settings/settings_prenatal_records_page.dart';
import 'package:smartguide_app/utils/utils.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0 * 2),
        child: Consumer<User>(builder: (context, user, child) {
          final role = user.type;
          log(role ?? "none");

          return CustomSection(
            childrenSpacing: 0,
            children: [
              // SettingsItem(
              //   icon: Icon(Ionicons.language_outline),
              //   title: "Language",
              //   onTap: () => Navigator.push(
              //       context, MaterialPageRoute(builder: (context) => SettingsLanguagePage())),
              // ),
              SettingsItem(
                icon: const Icon(Ionicons.bookmark_outline),
                title: "Bookmark",
                onTap: () {},
              ),
              if (role == getUserStringFromUserTypeEnum(UserTypeEnum.mother)) ...[
                SettingsItem(
                  icon: const Icon(Ionicons.list_outline),
                  title: "Prenatal Record",
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SettingsPrenatalRecordsPage())),
                ),
                // SettingsItem(
                //   icon: const Icon(Ionicons.list_outline),
                //   title: "PatientInformation Record (delete me)",
                //   onTap: () => Navigator.push(
                //       context, MaterialPageRoute(builder: (context) => PatientsInfoPage())),
                // ),
              ]
            ],
          );
        }),
      ),
    );
  }
}
