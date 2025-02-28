import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/password_strength_checklist/checklist.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class SettingsPrenatalRecordsExaminationFindingsTabView extends StatelessWidget {
  SettingsPrenatalRecordsExaminationFindingsTabView({super.key});

  final TextEditingController fundicHeightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController bloodPressureController = TextEditingController();
  final TextEditingController risksController = TextEditingController();
  final TextEditingController advisoryController = TextEditingController();
  final TextEditingController servicesController = TextEditingController();

  final bool fundicHeightNormal = true;
  final bool weightNormal = true;
  final bool bloodPressureNormal = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomSection(
        title: "Examination findings",
        children: [
          CustomInput.text(
              context: context,
              controller: fundicHeightController,
              label: "Fundic Height",
              hint: "cm"),
          Checklist(meet: fundicHeightNormal, label: "Normal: "),
          CustomInput.text(
              context: context, controller: weightController, label: "Weight", hint: "kg"),
          Checklist(meet: weightNormal, label: "Normal: "),
          CustomInput.text(
              context: context,
              controller: bloodPressureController,
              label: "Blood Pressure",
              hint: "mmHg"),
          Checklist(meet: bloodPressureNormal, label: "Normal: "),
          CustomInput.text(
              context: context,
              controller: risksController,
              label: "The following risks were noted: ",
              hint: ""),
          CustomInput.text(
              context: context,
              controller: advisoryController,
              label: "I was advised to do the following: ",
              hint: ""),
          CustomInput.text(
              context: context,
              controller: servicesController,
              label: "I was given the following services: ",
              hint: ""),
        ],
      ),
    );
  }
}
