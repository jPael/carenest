import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/components/alert/alert.dart';

import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/first_trimester.dart';
import 'package:smartguide_app/models/revamp/second_trimester.dart';
import 'package:smartguide_app/models/revamp/third_trimester.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';

Future<void> createFirsTrimesterClinicVisit(
    {required FirstTrimester visit, required String token}) async {
  final Map<String, dynamic> payload = {
    "clinic_visit_id": visit.clinicVisitId,
    "check_up": visit.checkUp.laravelValue,
    "weight": visit.weight,
    "height": visit.height,
    "age_gestation": visit.ageGestation,
    "blood_pressure": visit.bloodPressure,
    "nutritional_status": visit.nutritionalStatus.laravelValue,
    "birth_plan": visit.birthPlan,
    "teeth_findings": visit.teethFindings,
    "hemoglobin_count": visit.hemoglobinCount,
    "urinalysis": visit.urinalysis,
    "complete_blood_count": visit.completeBloodCount,
    "stool_exam": visit.stoolExam,
    "acetic_acid_wash": visit.aceticAcidWash,
    "tetanus_vaccine": visit.tetanusVaccine,
    "tetanus_vaccine_given_at": visit.tetanusVaccineGivenAt.toString(),
    "return_date": visit.returnDate.toString(),
    "health_service_provider_id": visit.healthServiceProviderId,
    "hospital_referral": visit.hospitalReferral,
    "laboratories":
        visit.laboratories.map((l) => {"name": l.name, "description": l.description}).toList(),
    "sti": visit.stis.map((s) => {"name": s.name, "description": s.description}).toList(),
    "treatments":
        visit.treatments.map((t) => {"description": t.description, "value": t.value}).toList(),
    "counseling": visit.counselings.map((c) => {"name": c.description}).toList(),
    "other_services":
        visit.otherServices == null || visit.otherServices!.isEmpty ? "None" : visit.otherServices,
  };

  // log(payload.toString());

  final url = apiURIBase.replace(path: LaravelPaths.firstTrimesterCreateClinicVisit);

  final _json = jsonEncode(payload);

  final res = await http.post(url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
      body: _json);

  final json = jsonDecode(res.body);

  if (json['success'] ?? false) {
    Alert.showSuccessMessage(message: "Clinic visit has beem created successfully");
  } else {
    Alert.showErrorMessage(message: json['message']);
    log(json['message'].toString());
    log(json['error']);
    log(json['data'].toString());
  }
}

Future<void> createSecondTrimesterClinicVisit(
    {required String token, required SecondTrimester visit}) async {
  final Map<String, dynamic> payload = {
    "clinic_visit_id": visit.clinicVisitId,
    "check_up": visit.checkUp.laravelValue,
    "weight": visit.weight,
    "height": visit.height,
    "age_gestation": visit.ageGestation,
    "blood_pressure": visit.bloodPressure,
    "nutritional_status": visit.nutritionalStatus.laravelValue,
    "assessment": visit.assessment,
    "birth_plan_changes": visit.birthPlanChanges,
    "teeth_findings": visit.teethFindings,
    "urinalysis": visit.urinalysis,
    "bacteriuria": visit.bacteriuria,
    "complete_blood_count": visit.completeBloodCount,
    "sti_etiologic_test": visit.stiEtiologicTest,
    "oral_glucose_test": visit.oralGlucoseTest,
    "pap_smear": visit.papSmear,
    "return_date": visit.returnDate.toString(),
    "health_service_provider_id": visit.healthServiceProviderId,
    "hospital_referral": visit.hospitalReferral,
    "advices": visit.advices.map((a) => {'name': a.content}).toList(),
    "laboratories":
        visit.laboratories.map((l) => {"name": l.name, "description": l.description}).toList(),
    "treatments":
        visit.treatments.map((t) => {"description": t.description, "value": t.value}).toList(),
    "counseling": visit.counselings.map((c) => {"name": c.description}).toList(),
    "other_services": visit.notes == null || visit.notes!.isEmpty ? "None" : visit.notes,
  };

  final url = apiURIBase.replace(path: LaravelPaths.secondTrimesterCreateClinicVisit);

  // log(url.toString());
  // log(payload.toString());

  final res = await http.post(url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(payload));

  // log(res.statusCode.toString());

  final json = jsonDecode(res.body);

  if (json['success'] ?? false) {
    Alert.showSuccessMessage(message: "Clinic visit has beem created successfully");
  } else {
    Alert.showErrorMessage(message: json['message']);
    log(json['error']);
    log(json['data'].toString());
  }
}

Future<void> createThirdTrimesterClinicVisit(
    {required String token, required ThirdTrimester visit}) async {
  final Map<String, dynamic> payload = {
    "clinic_visit_id": visit.clinicVisitId,
    "check_up": visit.checkUp.laravelValue,
    "weight": visit.weight,
    "height": visit.height,
    "age_gestation": visit.ageGestation,
    "blood_pressure": visit.bloodPressure,
    "nutritional_status": visit.nutritionalStatus.laravelValue,
    "assessment": visit.assessment,
    "birth_plan_changes": visit.birthPlanChanges,
    "teeth_findings": visit.teethFindings,
    "urinalysis": visit.urinalysis,
    "complete_blood_count": visit.completeBloodCount,
    "blood_rh_group": visit.bloodRhGroup,
    "return_date": visit.returnDate.toString(),
    "health_service_provider_id": visit.healthServiceProviderId,
    "hospital_referral": visit.hospitalReferral,
    "notes": visit.notes == null || visit.notes!.isEmpty ? "None" : visit.notes,
    "laboratories": visit.laboratories.map((l) => l.toJson()).toList(),
    "treatments": visit.treatments.map((t) => t.toJson()).toList(),
    "advices": visit.advices.map((a) => a.toJson()).toList(),
    "counseling": visit.counselings.map((c) => c.toJson()).toList(),
  };

  // log(payload.toString());

  final url = apiURIBase.replace(path: LaravelPaths.thirdTrimesterCreateClinicVisit);
  // log(url.toString());

  final res = await http.post(url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(payload));

  // log(res.statusCode.toString());

  final json = jsonDecode(res.body);

  if (json['success'] ?? false) {
    Alert.showSuccessMessage(message: "Clinic visit has beem created successfully");
  } else {
    Alert.showErrorMessage(message: json['message']);
    log(json['message'].toString());
    log(json['error']);
    log(json['data'].toString());
  }
}

Future<void> createClinicHistory(
    {required String philhealh,
    required String nhts,
    required String obStatus,
    required String barangay,
    required DateTime dateOfBirth,
    required DateTime lmp,
    required DateTime edc,
    required int userId,
    required String token}) async {
  final Map<String, dynamic> payload = {
    "philhealt": philhealh,
    "nhts": nhts,
    "ob_status": obStatus,
    "date_of_birth": dateOfBirth.toString(),
    "lmp": lmp.toString(),
    "edc": edc.toString(),
    "user_id": userId,
    "barangay_name": barangay,
  };

  log(payload.toString());

  final url = apiURIBase.replace(path: LaravelPaths.createClinicHistory);

  log(url.toString());

  final res = await http.post(url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
        'Authorization': "Bearer $token"
      },
      body: jsonEncode(payload));

  log(res.statusCode.toString());

  final json = jsonDecode(res.body);

  if (json['success'] ?? false) {
    Alert.showSuccessMessage(message: "Clinic visit has been created successfully");
  } else {
    Alert.showErrorMessage(message: json['message']);
    log(json['error']);
    log(json['data'].toString());
  }
}
