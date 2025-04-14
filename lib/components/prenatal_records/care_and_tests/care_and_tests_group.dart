import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/prenatal_records/care_and_tests/care_and_tests_advice_item.dart';
import 'package:smartguide_app/components/prenatal_records/care_and_tests/care_and_tests_findings_item.dart';
import 'package:smartguide_app/components/prenatal_records/care_and_tests/care_and_tests_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class CareAndTestsGroup extends StatelessWidget {
  const CareAndTestsGroup({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomSection(
        alignment: CrossAxisAlignment.start,
        title: title,
        action: CustomButton.link(
            context: context,
            onPressed: () {},
            label: "Edit",
            icon: const Icon(
              Ionicons.pencil_outline,
              size: 8 * 2,
            )),
        titleStyle: const TextStyle(fontSize: 8 * 2.5, fontWeight: FontWeight.w500),
        headerSpacing: 2,
        childrenSpacing: 1,
        children: [
          CareAndTestItem(
            type: CareTestItemEnum.careItemDates,
            description: "Date of visit",
            date: DateTime(2025, 1, 25),
          ),
          const SizedBox(
            height: 4 * 2,
          ),
          CareAndTestItem(
            description:
                "The women’s Health team WHT will help me in my Pregnancy if there’s anything I want to know I will consult",
            isTrue: true,
          ),
          CareAndTestItem(
            description: "WTH introduce & helped me accomplished my Birth Plan.",
            isTrue: true,
          ),
          const SizedBox(
            height: 4 * 2,
          ),
          const Row(
            children: [
              Text(
                "Findings",
                style: TextStyle(
                  fontSize: 4 * 6,
                ),
              ),
            ],
          ),
          const CareAndTestsFindingsItem(
            description: "Fundic height",
            value: "26",
            unit: "cm",
            remarksDescription: "Normal",
            remarksValue: "Yes",
          ),
          const CareAndTestsFindingsItem(
            description: "Blood pressure",
            value: "120/80 ",
            unit: "mmHg",
            remarksDescription: "Normal",
            remarksValue: "Yes",
          ),
          const SizedBox(
            height: 4 * 2,
          ),
          const Row(
            children: [
              Text(
                "Advice",
                style: TextStyle(
                  fontSize: 4 * 6,
                ),
              ),
            ],
          ),
          const CareAndTestsAdviceItem(content: "Maintain a healthy diet with reduced salt intake"),
          const CareAndTestsAdviceItem(content: "Monitor blood sugar levels daily"),
          const CareAndTestsAdviceItem(content: "Increase physical activity with light exercises"),
          const SizedBox(
            height: 4 * 2,
          ),
          const Row(
            children: [
              Text(
                "Services",
                style: TextStyle(
                  fontSize: 4 * 6,
                ),
              ),
            ],
          ),
          const CareAndTestsAdviceItem(content: "Routine ultrasound scan"),
          const CareAndTestsAdviceItem(content: "Blood pressure monitoring"),
          const CareAndTestsAdviceItem(content: "Iron and folic acid supplementation"),
          const SizedBox(
            height: 4 * 10,
          ),
          const Column(
            children: [
              Text(
                "Maria Dela Cruz",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Text(
                "WHT Personnel",
                style: TextStyle(fontStyle: FontStyle.italic),
              )
            ],
          )
        ],
      ),
    );
  }
}
