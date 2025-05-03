import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/birth_plan/birth_plan_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

import 'package:smartguide_app/models/birth_plan.dart' as bp;

class BirthPlan extends StatelessWidget {
  const BirthPlan({super.key, this.data});

  final bp.BirthPlan? data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2 * 8.0),
      child: CustomSection(
        title: "Birth Plan",
        children: [
          BirthPlanItem(
            description: "Birth will take place at",
            value: data?.birthplace == "NA" ? "ASTMMC, Tandag City" : data!.birthplace,
          ),
          BirthPlanItem(
            description: "Assigned by",
            value: data?.assignedBy?.name ?? "Maria dela Cruz",
          ),
          BirthPlanItem(
            description: "Accompanying Midwife/Nurse/Doctor",
            value: data?.accompaniedBy?.name ?? "Maria dela Cruz",
          ),
        ],
      ),
    );
  }
}
