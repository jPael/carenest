import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class SettingsPrenatalRecordsBirthPlanTabView extends StatelessWidget {
  SettingsPrenatalRecordsBirthPlanTabView({super.key});

/*

In case of emergency, my blood donors are: (text input)
My blood donors have been blood typed: (Yes/No)
I will be giving birth at: (text input)
I will be accompanied by: (text input)
I will be assigned by: (text input)

*/

  final TextEditingController emergencyBloodDonorsController = TextEditingController();
  final TextEditingController birthLocationController = TextEditingController();
  final TextEditingController birthAccompaniedByController = TextEditingController();
  final TextEditingController birthAssignedByController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      title: "Birth Plan",
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
