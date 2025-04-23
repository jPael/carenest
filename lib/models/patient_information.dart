import 'dart:developer';

import 'package:smartguide_app/models/donor.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/services/laravel/fields.dart';

class PatientInformation {
  final int? id;
  final bool philhealth;
  final bool nhts;
  final DateTime lmp;
  final DateTime edc;
  final String obStatus;
  final int assignById;
  final int accompanyById;
  final Person? accompaniedByData;
  final Donor? bloodDonor;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PatientInformation(
      {this.id,
      this.bloodDonor,
      required this.philhealth,
      required this.nhts,
      required this.lmp,
      required this.edc,
      required this.obStatus,
      required this.assignById,
      required this.accompanyById,
      this.accompaniedByData,
      this.createdAt,
      this.updatedAt});

  static PatientInformation fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? midwifeJsonData = json[PatientInformationFields.accompanyByData];

    Person? midwifePerson;

    if (midwifeJsonData != null) {
      midwifePerson = Person.fromJsonStatic(midwifeJsonData);
    }

    final Map<String, dynamic> donor = (json[PrenatalFields.bloodDonors] as List).first;
    log(donor.toString());

    return PatientInformation(
      bloodDonor: Donor(
          id: donor['id'],
          fullname: donor[PrenatalFields.donorFullname],
          contactNumber: donor[PrenatalFields.donorContactNumber],
          bloodTyped: donor[PrenatalFields.donorBloodType] == 1 ? true : false),
      id: json[PatientInformationFields.id],
      philhealth: json[PatientInformationFields.philhealth] == 1 ? true : false,
      nhts: json[PatientInformationFields.nhts] == 1 ? true : false,
      lmp: json[PatientInformationFields.lmp] != null
          ? DateTime.parse(json[PatientInformationFields.lmp])
          : DateTime.now(),
      edc: json[PatientInformationFields.edc] != null
          ? DateTime.parse(json[PatientInformationFields.edc])
          : DateTime.now(),
      obStatus: json[PatientInformationFields.obStatus],
      assignById: json[PatientInformationFields.assignedBy],
      accompanyById: json[PatientInformationFields.accompanyBy],
      createdAt: json[PatientInformationFields.createdAt] != null
          ? DateTime.parse(json[PatientInformationFields.createdAt])
          : null,
      updatedAt: json[PatientInformationFields.createdAt] != null
          ? DateTime.parse(json[PatientInformationFields.updatedAt])
          : null,
    );
  }
}
