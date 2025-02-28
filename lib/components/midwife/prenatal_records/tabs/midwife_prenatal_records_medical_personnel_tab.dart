import 'package:flutter/material.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/section/custom_section.dart';

class MidwifePrenatalRecordsMedicalPersonnelTab extends StatelessWidget {
  MidwifePrenatalRecordsMedicalPersonnelTab({super.key});

  final TextEditingController name = TextEditingController();
  final TextEditingController whtName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomSection(
      headerSpacing: 1,
      children: [
        CustomInput.text(context: context, controller: name, label: "Name of Midwife/Nurse/Doctor"),
        CustomInput.text(context: context, controller: whtName, label: "Name of WHT member"),
      ],
    );
  }
}
