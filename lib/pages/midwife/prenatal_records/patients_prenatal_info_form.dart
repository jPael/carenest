import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/form/prenatal_info_form.dart';
import 'package:smartguide_app/models/person.dart';

class PatientsPrenatalInfoForm extends StatelessWidget {
  const PatientsPrenatalInfoForm(
      {super.key,
      required this.patient,
      this.patientInformationId,
      this.isCreating = false,
      this.readonly = false});

  final Person patient;
  final int? patientInformationId;
  final bool isCreating;
  final bool readonly;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${isCreating ? "Create " : ""}Prenatal Record"),
          centerTitle: true,
        ),
        body: PrenatalInfoForm(
          patient: patient,
          readonly: false,
        ));
  }
}
