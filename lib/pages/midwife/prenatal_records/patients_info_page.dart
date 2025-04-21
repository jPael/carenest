
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartguide_app/components/checklist/custom_checklist.dart';
import 'package:smartguide_app/components/input/custom_input.dart';
import 'package:smartguide_app/components/midwife/prenatal_records/midwife_prenatal_records_patients_info_blood_donors_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';

class PatientsInfoPage extends StatelessWidget {
  PatientsInfoPage({super.key, this.prenatalId});

  final int? prenatalId;

  final PrenatalServices prenatalServices = PrenatalServices();

  // Future that simulates fetching patient data
  Future<Map<String, dynamic>> _fetchPatientData({required String token}) async {
    // await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    if (prenatalId == null) {
      return {
        'name': 'Maria Santos',
        'age': '28',
        'birthday': DateTime(1995, 5, 15),
        'address': '123 Main Street, City',
        'philHealth': true,
        'nhts': false,
        'lastMenstrualPeriod': DateTime.now().subtract(const Duration(days: 90)),
        'obStatus': 'G2P1',
        'expectedDateOfConfinement': DateTime.now().add(const Duration(days: 90)),
        'bloodDonors': [
          {'fullname': 'Juan Dela Cruz', 'phoneNumber': '09999999214', 'verified': true},
          {'fullname': 'Maria Clara', 'phoneNumber': '09123456789', 'verified': false},
        ]
      };
    } else {
      final Prenatal? prenatal =
          await prenatalServices.fetchPrenatalByPrenatalId(token: token, id: prenatalId!);

      if (prenatal == null) {
        throw Exception();
      }

      return {
        'name': prenatal.fullname,
        'age': prenatal.age,
        'birthday': prenatal.birthday,
        'address': prenatal.barangay,
        'philHealth': prenatal.patientInformation.philhealth,
        'nhts': prenatal.patientInformation.nhts,
        'lastMenstrualPeriod': prenatal.patientInformation.lmp,
        'obStatus': prenatal.patientInformation.obStatus,
        'expectedDateOfConfinement': prenatal.patientInformation.edc,
        'bloodDonors': [
          {
            'fullname': prenatal.donorFullname,
            'phoneNumber': prenatal.donorContact,
            'verified': prenatal.donorBloodTyped
          },
        ]
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    final User user = context.read<User>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Patients information"),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _fetchPatientData(token: user.token!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final patientData = snapshot.data!;
          final nameController = TextEditingController(text: patientData['name']);
          final ageController = TextEditingController(text: patientData['age']);
          final addressController = TextEditingController(text: patientData['address']);
          final obStatusController = TextEditingController(text: patientData['obStatus']);

          // log(patientData.toString());

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: CustomSection(children: [
                CustomInput.text(
                    readonly: true,
                    context: context,
                    controller: nameController,
                    label: "Full name"),
                CustomInput.text(
                    readonly: true, context: context, controller: ageController, label: "Age"),
                CustomInput.datepicker(
                    readonly: true,
                    context: context,
                    onChange: (date) {},
                    selectedDate: patientData['birthday'],
                    label: "Birthday"),
                CustomInput.text(
                    readonly: true,
                    context: context,
                    controller: addressController,
                    label: "Address"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      child: CustomChecklist(
                        label: "PhilHealth",
                        checked: patientData['philHealth'],
                      ),
                    ),
                    Flexible(
                      child: CustomChecklist(
                        label: "NHTS/4Ps",
                        checked: patientData['nhts'],
                      ),
                    ),
                  ],
                ),
                CustomInput.datepicker(
                    readonly: true,
                    context: context,
                    onChange: (p0) {},
                    label: "My Last Menstrual Period (LMP)",
                    selectedDate: patientData['lastMenstrualPeriod']),
                CustomInput.text(
                    readonly: true,
                    context: context,
                    controller: obStatusController,
                    label: "OB Status"),
                CustomInput.datepicker(
                    readonly: true,
                    context: context,
                    selectedDate: patientData['expectedDateOfConfinement'],
                    onChange: (e) {},
                    label: "I am expected to Give Birth to my Child (EDC) on"),
                CustomSection(
                  title: "In case of emergency, my blood donors are",
                  headerSpacing: 1,
                  titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  alignment: CrossAxisAlignment.start,
                  children: [
                    ...patientData['bloodDonors'].map((donor) => PatientsInfoBloodDonorsItem(
                        fullname: donor['fullname'],
                        phoneNumber: donor['phoneNumber'],
                        verified: donor['verified']))
                  ],
                )
              ]),
            ),
          );
        },
      ),
    );
  }
}
