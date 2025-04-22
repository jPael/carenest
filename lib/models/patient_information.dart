import 'dart:developer';

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
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Person? accompaniedBy;

  PatientInformation(
      {this.id,
      required this.philhealth,
      required this.nhts,
      required this.lmp,
      required this.edc,
      required this.obStatus,
      required this.assignById,
      required this.accompanyById,
      this.accompaniedBy,
      this.createdAt,
      this.updatedAt});

  static PatientInformation fromJson(Map<String, dynamic> json) {
    final Person? midwifeData =
        Person.fromJsonStatic(json[PatientInformationFields.accompanyByData]);

    log(json.toString());
    log("${midwifeData?.id?.toString() ?? "NA"}: ${midwifeData?.name ?? "NA"}::${json[PatientInformationFields.accompanyByData].toString()}");

    return PatientInformation(
        id: json[PatientInformationFields.id],
        philhealth: json[PatientInformationFields.philhealth] == 1 ? true : false,
        nhts: json[PatientInformationFields.nhts] == 1 ? true : false,
        lmp: DateTime.parse(json[PatientInformationFields.lmp]),
        edc: DateTime.parse(json[PatientInformationFields.edc]),
        obStatus: json[PatientInformationFields.obStatus],
        assignById: json[PatientInformationFields.assignedBy],
        accompanyById: json[PatientInformationFields.accompanyBy],
        createdAt: DateTime.parse(json[PatientInformationFields.createdAt]),
        updatedAt: DateTime.parse(json[PatientInformationFields.updatedAt]),
        accompaniedBy: midwifeData);
  }
}
