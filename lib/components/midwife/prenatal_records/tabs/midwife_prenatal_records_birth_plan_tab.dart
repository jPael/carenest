import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class MidwifePrenatalRecordsBirthPlanTab extends StatelessWidget {
  MidwifePrenatalRecordsBirthPlanTab({super.key});

  final TextEditingController emergencyBloodDonorsController = TextEditingController();
  final TextEditingController birthLocationController = TextEditingController();
  final TextEditingController birthAccompaniedByController = TextEditingController();
  final TextEditingController birthAssignedByController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      headerSpacing: 1,
      children: [
        CustomInput.text(
            context: context,
            controller: emergencyBloodDonorsController,
            label: "In case of emergency, my blood donors are:"),
        CustomInput.text(
            context: context,
            controller: birthLocationController,
            label: "I will be giving birth at:"),
        CustomInput.text(
            context: context,
            controller: birthAccompaniedByController,
            label: "I will be accompanied by:"),
        CustomInput.text(
            context: context,
            controller: birthAssignedByController,
            label: "I will be assigned by:"),
      ],
    );
  }
}
