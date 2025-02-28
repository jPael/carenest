import 'package:flutter/material.dart';
import 'package:smartguide_app/components/checklist/custom_checklist.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class PatientsInfoPage extends StatelessWidget {
  PatientsInfoPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController obStatusController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final bool philHealth = false;
  final bool nhts = false;
  final DateTime expectedDateOfConfinement = DateTime.now();
  final DateTime birthday = DateTime.now();
  final DateTime lastMenstrualPeriod = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2 * 8.0),
        child: CustomSection(title: "Patients information", children: [
          CustomInput.text(context: context, controller: nameController, label: "Full name"),
          CustomInput.text(context: context, controller: ageController, label: "Age"),
          CustomInput.datepicker(
              context: context, onChange: (date) {}, selectedDate: birthday, label: "Birthday"),
          CustomInput.text(context: context, controller: addressController, label: "Address"),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomChecklist(
                label: "PhilHealth",
                checked: true,
              ),
              CustomChecklist(
                label: "NHTS/4Ps",
                checked: true,
              ),
            ],
          ),
          CustomInput.datepicker(
              context: context,
              onChange: (p0) {},
              label: "My Last Menstrual Period (LMP)",
              selectedDate: DateTime.now()),
          CustomInput.text(context: context, controller: obStatusController, label: "OB Status"),
          CustomInput.datepicker(
              context: context,
              selectedDate: expectedDateOfConfinement,
              onChange: (e) {},
              label: "I am expected to Give Birth to my Child (EDC) on"),
        ]),
      ),
    );
  }
}
