import 'dart:developer';

import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/models/trimester.dart';
import 'package:smartguide_app/services/laravel/prenatal_services.dart';

class Prenatal {
  Prenatal({
    required this.laravelId,
    required this.selectedTrimester,
    required this.consultWht,
    required this.introducedBirthPlan,
    required this.fundicHeight,
    required this.fundicNormal,
    required this.bloodPressure,
    required this.bloodPressureNormal,
    required this.advices,
    required this.services,
    required this.birthplace,
    required this.ttItems,
    required this.ironSuppItems,
    required this.barangay,
    required this.birthday,
    // required this.assignedBy,
    // required this.accompaniedBy,
    // required this.philhealth,
    // required this.nhts,
    // required this.expectedDateOfConfinement,
    // required this.lastMenstrualPeriod,
    // required this.obStatus,
    required this.patientInformation,
    required this.fullname,
    required this.age,
    required this.breastFeeding,
    required this.familyPlanning,
    required this.properNutrition,
    required this.properNutritionForChild,
    required this.properNutritionForMyself,
    required this.donorFullname,
    required this.donorContact,
    required this.donorBloodTyped,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  final bool breastFeeding;
  final bool familyPlanning;
  final bool properNutrition;
  final bool properNutritionForChild;
  final bool properNutritionForMyself;
  final String donorFullname;
  final String donorContact;
  final bool donorBloodTyped;
  final String fullname;
  final String age;
  final int laravelId;
  TrimesterEnum selectedTrimester;
  String barangay;
  DateTime birthday;
  PatientInformation patientInformation;
  // final String obStatus;
  // bool philhealth;
  // bool nhts;
  // DateTime expectedDateOfConfinement;
  // DateTime lastMenstrualPeriod;
  // String assignedBy;
  // String accompaniedBy;
  bool consultWht;
  bool introducedBirthPlan;
  String fundicHeight;
  bool fundicNormal;
  String bloodPressure;
  bool bloodPressureNormal;
  List<String> advices;
  List<String> services;
  String birthplace;
  final List<Map<String, dynamic>> ttItems;
  final List<Map<String, dynamic>> ironSuppItems;
  DateTime? createdAt;
  DateTime? updatedAt;
  final int? id;

  final PrenatalServices prenatalServices = PrenatalServices();

  Future<Map<String, dynamic>> storeRecord() async {
    try {
      await prenatalServices.storePrenatalRecord(this);
      return {"success": true, "message": "Prenatal record saved successfully"};
    } catch (e, stackTrace) {
      log('Error storing prenatal record: $e', stackTrace: stackTrace);
      return {"success": false, "message": "Failed to save prenatal record"};
    }
  }
}
