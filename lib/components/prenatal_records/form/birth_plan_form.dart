import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class BirthPlanForm extends StatelessWidget {
  const BirthPlanForm(
      {super.key,
      required this.birthplaceController,
      required this.assignedByController,
      required this.accompaniedByController});

  final TextEditingController birthplaceController;
  final TextEditingController assignedByController;
  final TextEditingController accompaniedByController;

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Birth Plan",
      headerSpacing: 4,
      children: [
        CustomInput.inline(controller: birthplaceController, label: "Birth place will take at"),
        CustomInput.inline(controller: assignedByController, label: "Assigned by"),
        CustomInput.inline(controller: accompaniedByController, label: "Accompanied"),
      ],
    );
  }
}
