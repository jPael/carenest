import 'dart:developer';

import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/models/trimester.dart';
import 'package:smartguide_app/services/laravel/fields.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';
import 'package:smartguide_app/utils/utils.dart';

class ClinicVisit {
  final int id;
  final String birthplace;
  final TrimesterEnum trimester;
  final bool consulWht;
  final bool whtIntroducedBirthPlan;
  final int fundicHeigh;
  final int patientInformationId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final Person assignedBy;
  final Person accompanyBy;

  final String services;
  final String advices;

  final int userId;

  final int? prenatalId;

  final int? ttImunizations;
  final int? ironSupplementNoTabs;
  final bool? isBreastFeeding;
  final bool? isFamilyPlanning;
  final bool? isChildProperNutrition;
  final bool? isSelfProperNutrition;
  final int? midwifeId;

  ClinicVisit({
    required this.userId,
    required this.id,
    required this.birthplace,
    required this.trimester,
    required this.consulWht,
    required this.whtIntroducedBirthPlan,
    required this.fundicHeigh,
    required this.patientInformationId,
    required this.assignedBy,
    required this.accompanyBy,
    required this.services,
    required this.advices,
    this.prenatalId,
    this.createdAt,
    this.updatedAt,
    this.ttImunizations,
    this.ironSupplementNoTabs,
    this.isBreastFeeding,
    this.isFamilyPlanning,
    this.isChildProperNutrition,
    this.isSelfProperNutrition,
    this.midwifeId,
  });

  static ClinicVisit fromJson(Map<String, dynamic> json) {
    log(json[PatientInformationFields.accompanyBy].toString());

    return ClinicVisit(
        id: json[PrenatalFields.id],
        birthplace: json[PrenatalFields.birthplace],
        trimester: getTrimesterEnumFromTrimesterString(json[PrenatalFields.trimester]),
        consulWht: json[PrenatalFields.consultWht] == 1 ? true : false,
        whtIntroducedBirthPlan: json[PrenatalFields.whtIntroducedBirthPlan] == 1 ? true : false,
        fundicHeigh: json[PrenatalFields.fundicHeight],
        patientInformationId: json[PrenatalFields.patientInformationId],
        advices: (json[PrenatalFields.advices] as Map<String, dynamic>)['content'],
        services: (json[PrenatalFields.services] as Map<String, dynamic>)['content'],
        accompanyBy: Person.fromJsonStatic(json[PatientInformationFields.accompanyBy])!,
        assignedBy: Person.fromJsonStatic(json[PatientInformationFields.assignedBy])!,
        userId: json['patient_information']['user_id']);
  }

  final PrenatalServices prenatalServices = PrenatalServices();

  Future<Map<String, dynamic>> storeRecord({required String token}) async {
    try {
      await prenatalServices.storeClinicVisitRecord(this, token: token);
      return {"success": true, "message": "Prenatal record saved successfully"};
    } catch (e, stackTrace) {
      log('Error storing prenatal record: $e', stackTrace: stackTrace);
      return {"success": false, "message": "Failed to save prenatal record"};
    }
  }
}
