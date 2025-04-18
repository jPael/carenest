import 'package:flutter/material.dart';
import 'package:smartguide_app/components/checklist/custom_checklist.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class Counseling extends StatelessWidget {
  const Counseling({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(2 * 8.0),
      child: CustomSection(
        title: "Counseling",
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: CustomChecklist(
                  label: "Breastfeeding",
                  checked: true,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: CustomChecklist(
                  label: "Family Planning",
                  checked: true,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 4 * 6,
          ),
          Text(
            "Proper Nutrition",
            style: TextStyle(fontSize: 4 * 6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: CustomChecklist(
                  label: "Child",
                  checked: true,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: CustomChecklist(
                  label: "Mother",
                  checked: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
