import 'dart:developer';

import 'package:smartguide_app/services/laravel/fields.dart';
import 'package:smartguide_app/services/laravel/patient_information_services.dart';

class PatientInformation {
  final int? id;
  final String philhealth;
  final String nhts;
  final DateTime lmp;
  final DateTime edc;
  final String obStatus;
  final DateTime birthday;
  // final Donor? bloodDonor;
  final int userId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PatientInformation(
      {this.id,
      // this.bloodDonor,
      required this.birthday,
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

    // final Map<String, dynamic> donor = (json[PrenatalFields.bloodDonors] as List).first;
    // log(donor.toString());

    log(json.toString());

    return PatientInformation(
      birthday: DateTime.parse(json['date_of_birth']),
      userId: json[LaravelUserFields.userId],
      id: json[PatientInformationFields.id],
      philhealth: json[PatientInformationFields.philhealth],
      nhts: json[PatientInformationFields.nhts],
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

  Future<Map<String, dynamic>> storeRecord(
      {required int userId, required String token, bool create = true}) async {
    try {
      if (create) {
        final int id = await storePatientInformation(patientInformation: this, token: token);
        return {"success": true, "message": "Patient information  saved successfully", 'id': id};
      } else {
        final int id =
            await updatePatientInformation(id: userId, patientInformation: this, token: token);

        return {"success": true, "message": "Patient information  updated successfully", 'id': id};
      }
    } catch (e, stackTrace) {
      log('Error storing prenatal record: $e', stackTrace: stackTrace);
      return {"success": false, "message": "Failed to save patient information"};
    }
  }
}
