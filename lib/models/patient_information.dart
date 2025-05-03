import 'dart:developer';

import 'package:smartguide_app/models/donor.dart';
import 'package:smartguide_app/services/laravel/fields.dart';
import 'package:smartguide_app/services/laravel/patient_information_services.dart';

class PatientInformation {
  final int? id;
  final bool philhealth;
  final bool nhts;
  final DateTime lmp;
  final DateTime edc;
  final String obStatus;
  final Donor? bloodDonor;
  final int userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PatientInformation(
      {this.id,
      this.bloodDonor,
      required this.philhealth,
      required this.nhts,
      required this.userId,
      required this.lmp,
      required this.edc,
      required this.obStatus,
      this.createdAt,
      this.updatedAt});

  static PatientInformation fromJson(Map<String, dynamic> json) {
    // final Map<String, dynamic>? midwifeJsonData = json[PatientInformationFields.accompanyByData];

    // Person? midwifePerson;

    // if (midwifeJsonData != null) {
    //   midwifePerson = Person.fromJsonStatic(midwifeJsonData);
    // }

    final Map<String, dynamic> donor = (json[PrenatalFields.bloodDonors] as List).first;
    log(donor.toString());

    return PatientInformation(
      userId: json[LaravelUserFields.userId],
      bloodDonor: Donor(
          id: donor['id'],
          fullname: donor[PrenatalFields.donorFullname],
          contactNumber: donor[PrenatalFields.donorContactNumber],
          bloodTyped: donor[PrenatalFields.donorBloodType] == 1 ? true : false),
      id: json[PatientInformationFields.id],
      philhealth: json[PatientInformationFields.philhealth] == 1 ? true : false,
      nhts: json[PatientInformationFields.nhts] == 1 ? true : false,
      lmp: json[PatientInformationFields.lmp] != null
          ? DateTime.parse(json[PatientInformationFields.lmp]).toLocal()
          : DateTime.now(),
      edc: json[PatientInformationFields.edc] != null
          ? DateTime.parse(json[PatientInformationFields.edc]).toLocal()
          : DateTime.now(),
      obStatus: json[PatientInformationFields.obStatus],
      createdAt: json[PatientInformationFields.createdAt] != null
          ? DateTime.parse(json[PatientInformationFields.createdAt]).toLocal()
          : null,
      updatedAt: json[PatientInformationFields.createdAt] != null
          ? DateTime.parse(json[PatientInformationFields.updatedAt]).toLocal()
          : null,
    );
  }

  Future<Map<String, dynamic>> storeRecord({required String token}) async {
    try {
      await storePatientInformation(patientInformation: this, token: token);
      return {"success": true, "message": "Prenatal record saved successfully"};
    } catch (e, stackTrace) {
      log('Error storing prenatal record: $e', stackTrace: stackTrace);
      return {"success": false, "message": "Failed to save prenatal record"};
    }
  }
}
