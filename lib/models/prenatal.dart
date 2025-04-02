import 'dart:developer';

import 'package:smartguide_app/components/prenatal_records/form/prenatal_info_form.dart';
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
    required this.assignedBy,
    required this.accompaniedBy,
    required this.ttItems,
    required this.ironSuppItems,
    required this.barangay,
    required this.philhealth,
    required this.nhts,
    required this.expectedDateOfConfinement,
    required this.birthday,
    required this.lastMenstrualPeriod,
    required this.fullname,
    required this.age,
    required this.obStatus,
    required this.breastFeeding,
    required this.familyPlanning,
    required this.properNutrition,
    required this.properNutritionForChild,
    required this.properNutritionForMyself,
    required this.donorFullname,
    required this.donorContact,
    required this.donorBloodType,
  });

  final bool breastFeeding;
  final bool familyPlanning;
  final bool properNutrition;
  final bool properNutritionForChild;
  final bool properNutritionForMyself;
  final String donorFullname;
  final String donorContact;
  final String donorBloodType;
  final String fullname;
  final String age;
  final String obStatus;
  final int laravelId;
  TrimesterEnum selectedTrimester;
  String barangay;
  bool philhealth;
  bool nhts;
  DateTime expectedDateOfConfinement;
  DateTime birthday;
  DateTime lastMenstrualPeriod;
  bool consultWht;
  bool introducedBirthPlan;
  String fundicHeight;
  bool fundicNormal;
  String bloodPressure;
  bool bloodPressureNormal;
  List<String> advices;
  List<String> services;
  String birthplace;
  String assignedBy;
  String accompaniedBy;
  final List<Map<String, dynamic>> ttItems;
  final List<Map<String, dynamic>> ironSuppItems;

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
