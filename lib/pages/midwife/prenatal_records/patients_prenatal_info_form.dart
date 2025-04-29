import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/form/prenatal_info_form.dart';
import 'package:smartguide_app/models/person.dart';

class PatientsPrenatalInfoForm extends StatelessWidget {
  const PatientsPrenatalInfoForm({super.key, required this.patient});

  final Person patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Prenatal Record"),
          centerTitle: true,
        ),
        body: PrenatalInfoForm(
          patient: patient,
        ));
  }
}
