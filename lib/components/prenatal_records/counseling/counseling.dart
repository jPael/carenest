import 'package:flutter/material.dart';
import 'package:smartguide_app/components/checklist/custom_checklist.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/counseling.dart' as c;

class Counseling extends StatelessWidget {
  const Counseling({super.key, required this.counseling});

  final c.Counseling? counseling;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2 * 8.0),
      child: CustomSection(
        title: "Counseling",
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: CustomChecklist(
                  label: "Breastfeeding",
                  checked: counseling?.breastFeeding ?? false,
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
                  checked: counseling?.familyPlanning ?? false,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4 * 6,
          ),
          const Text(
            "Proper Nutrition",
            style: TextStyle(fontSize: 4 * 6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                child: CustomChecklist(
                  label: "Child",
                  checked: counseling?.childProperNutrition ?? false,
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
                  checked: counseling?.selfProperNutrition ?? false,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
