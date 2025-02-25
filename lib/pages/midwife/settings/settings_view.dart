import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/settings/settings_item.dart';
import 'package:smartguide_app/pages/midwife/settings/settings_language_page.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0 * 2),
        child: CustomSection(
          spacing: 0,
          children: [
            SettingsItem(
              icon: Icon(Ionicons.language_outline),
              title: "Language",
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SettingsLanguagePage())),
            ),
            SettingsItem(
              icon: Icon(Ionicons.bookmark_outline),
              title: "Bookmark",
              onTap: () {},
            ),
            SettingsItem(
              icon: Icon(Ionicons.list_outline),
              title: "Prenatal Record",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
