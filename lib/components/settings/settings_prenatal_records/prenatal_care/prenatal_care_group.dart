import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/components/settings/settings_prenatal_records/prenatal_care/prenatal_care_item.dart';

class PrenatalCareGroup extends StatelessWidget {
  const PrenatalCareGroup({super.key, required this.title});

  final String title;

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
      description: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.black.withValues(alpha: 0.1)))),
        child: Row(
          children: [
            Expanded(
                child: Text(
              "Please check Services Provided",
              style: TextStyle(fontStyle: FontStyle.italic),
            )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                      right: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
                    )),
                    child: Icon(
                      Ionicons.checkmark_circle,
                      color: Colors.green.shade200,
                    ),
                  )),
                  Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                            left: BorderSide(color: Colors.black.withValues(alpha: 0.1)),
                          )),
                          child: Icon(Ionicons.close_circle, color: Colors.red.shade200)))
                ],
              ),
            )
          ],
        ),
      ),
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
