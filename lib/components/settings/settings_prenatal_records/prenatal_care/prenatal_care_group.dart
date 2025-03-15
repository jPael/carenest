import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/prenatal_care/prenatal_care_item.dart';

class PrenatalCareGroup extends StatelessWidget {
  const PrenatalCareGroup({super.key, required this.title});

  final String title;

  // TODO:: edit the prenatal care group into something in the notepad

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      alignment: CrossAxisAlignment.start,
      title: title,
      action: CustomButton.link(
          context: context,
          onPressed: () {},
          label: "Edit",
          icon: Icon(
            Ionicons.pencil_outline,
            size: 8 * 2,
          )),
      titleStyle: TextStyle(fontSize: 8 * 2.5, fontWeight: FontWeight.w500),
      headerSpacing: 2,
      children: [
        PrenatalCareItem(
          description:
              "The women’s Health team WHT will help me in my Pregnancy if there’s anything I want to know I will consult",
          checked: false,
        ),
        PrenatalCareItem(
          description: '''Name of WHT member

Date of First Visit: __/__/__
Date of Last delivery: __/__/__''',
          checked: true,
        ),
        PrenatalCareItem(
          description: '''WTH introduce & helped me accomplished my Birth Plan.

In case of emergency my blood donors are ''',
          checked: false,
        ),
        PrenatalCareItem(
          description: '''My blood donors have been blood typed.''',
          checked: false,
        ),
      ],
    );
  }
}
