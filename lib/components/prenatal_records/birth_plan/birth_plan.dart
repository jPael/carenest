import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/birth_plan/birth_plan_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class BirthPlan extends StatelessWidget {
  const BirthPlan({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2 * 8.0),
      child: CustomSection(
        title: "Birth Plan",
        action: IconButton(
            onPressed: () {},
            tooltip: "Edit",
            icon: const Icon(
              Icons.edit,
              size: 4 * 5,
            )),
        children: const [
          BirthPlanItem(
            description: "Birth will take place at",
            value: "ASTMMC, Tandag City",
          ),
          BirthPlanItem(
            description: "Assigned by",
            value: "Maria dela Cruz",
          ),
          BirthPlanItem(
            description: "Accompanying Midwife/Nurse/Doctor",
            value: "Maria dela Cruz",
          ),
        ],
      ),
    );
  }
}
