import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/midwife.dart';
import 'package:smartguide_app/models/patient_information.dart';

import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:smartguide_app/services/laravel/fields.dart';
import 'package:smartguide_app/services/laravel/user_services.dart';
import 'package:smartguide_app/services/user_services.dart';
import 'package:smartguide_app/utils/utils.dart';

class PrenatalServices {
  Future<PatientInformation> fetchPatientInformationByToken(String token) async {
    final url = apiURIBase.replace(path: LaravelPaths.patientInformation);

    final res = await http
        .get(url, headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"});

    final patientInformationJson = jsonDecode(res.body);

    return PatientInformation.fromJson(patientInformationJson);
  }

  Future<Prenatal?> fetchPrenatalByPrenatalId({required String token, required int id}) async {
    final List<Prenatal> prenatals = await fetchAllPrenatal(token);

    return prenatals.where((p) => p.id == id).firstOrNull;
  }

  Future<List<Prenatal>> fetchAllPrenatalByLaravelUserId(
      {required String token, required int id}) async {
    final List<Prenatal> prenatals = await fetchAllPrenatal(token);

    final List<Prenatal> filteredPrenatal = prenatals.where((p) => p.laravelId == id).toList();

    return filteredPrenatal;
  }

  Future<List<Prenatal>> fetchAllPrenatal(String token) async {
    final url = apiURIBase.replace(path: LaravelPaths.allPrenatal);

    final res = await http.get(url);

    final List<dynamic> prenatalsMap = jsonDecode(res.body);

    final List<Prenatal?> prenatals = await Future.wait(prenatalsMap.map((p) async {
      final int userId = p[LaravelUserFields.userId];

      final Map<String, dynamic> user = await fetchUserByUserId(id: userId, token: token);

      final String userEmail = user[LaravelUserFields.email];

      final Map<String, dynamic>? firebaseUser = await getUserByEmail(userEmail);

      if (firebaseUser == null) {
        return null;
      }

      final DateTime birthday = DateTime.parse(firebaseUser[UserFields.dateOfBirth]);
      final String barangay = firebaseUser[UserFields.address];

      return Prenatal(
          laravelId: p[LaravelUserFields.userId],
          selectedTrimester: getTrimesterEnumFromTrimesterString(
              p[PrenatalFields.clinicVisits].first['trimester']),
          consultWht:
              p[PrenatalFields.clinicVisits].first[PrenatalFields.consultWht] == 1 ? true : false,
          introducedBirthPlan:
              p[PrenatalFields.clinicVisits].first[PrenatalFields.whtIntroducedBirthPlan] == 1
                  ? true
                  : false,
          fundicHeight:
              p[PrenatalFields.clinicVisits].first[PrenatalFields.fundicHeight].toString(),
          fundicNormal: true,
          bloodPressure: (p[PrenatalFields.bloodPressure] ?? "NA").toString(),
          bloodPressureNormal: true,
          advices: [
            (p[PrenatalFields.clinicVisits].first[PrenatalFields.advices])['content'] ?? "NA"
          ],
          services: [
            p[PrenatalFields.clinicVisits].first[PrenatalFields.services]['content'] ?? "NA"
          ],
          birthplace: p[PrenatalFields.birthPlace] ?? "NA",
          patientInformation: PatientInformation(
              philhealth: p[PatientInformationFields.philhealth] == 1 ? true : false,
              nhts: p[PatientInformationFields.nhts] == 1 ? true : false,
              lmp: DateTime.parse(p[PatientInformationFields.lmp]),
              edc: DateTime.parse(p[PatientInformationFields.edc]),
              obStatus: p[PatientInformationFields.obStatus],
              assignById: p[PatientInformationFields.assignedBy],
              accompanyById: p[PatientInformationFields.accompanyBy],
              accompaniedBy: Midwife.fromJsonStatic(p[PatientInformationFields.accompanyByData])),
          // assignedBy: p[PrenatalFields.assignedBy].toString(),
          // accompaniedBy: p[PrenatalFields.accompanyBy].toString(),
          // philhealth: p[PrenatalFields.philhealth] == 1 ? true : false,
          // nhts: p[PrenatalFields.nhts] == 1 ? true : false,
          // expectedDateOfConfinement: DateTime.parse(p[PrenatalFields.edc]),
          // lastMenstrualPeriod: DateTime.parse(p[PrenatalFields.lmp]),
          // obStatus: p[PrenatalFields.obStatus],
          ttItems: (p[PrenatalFields.immunizationTerm] as List).cast<Map<String, dynamic>>(),
          ironSuppItems: (p[PrenatalFields.ironSupplements] as List).cast<Map<String, dynamic>>(),
          barangay: barangay,
          birthday: birthday,
          fullname: user[LaravelUserFields.name],
          age: calculateAge(birthday).toString(),
          breastFeeding: p[PrenatalFields.counselings].first[PrenatalFields.isBreastFeeding] == 1
              ? true
              : false,
          familyPlanning: p[PrenatalFields.counselings].first[PrenatalFields.isFamilyPlanning] == 1
              ? true
              : false,
          properNutrition: true,
          properNutritionForChild:
              p[PrenatalFields.counselings].first[PrenatalFields.isChildProperNutrition] == 1
                  ? true
                  : false,
          properNutritionForMyself:
              p[PrenatalFields.counselings].first[PrenatalFields.isSelfProperNutrition] == 1
                  ? true
                  : false,
          donorFullname: p[PrenatalFields.bloodDonors].first[PrenatalFields.donorFullname],
          donorContact: p[PrenatalFields.bloodDonors].first[PrenatalFields.donorContactNumber],
          donorBloodTyped: p[PrenatalFields.bloodDonors].first[PrenatalFields.donorBloodType] == 1
              ? true
              : false,
          createdAt: DateTime.parse(p[PrenatalFields.createdAt]),
          updatedAt: DateTime.parse(p[PrenatalFields.updatedAt]),
          id: p[PrenatalFields.id]);
    }).toList());

    // final List<Prenatal> cleanPrenatals = prenatals.where((p) => p != null).map((p)=>p!).toList();
    final List<Prenatal> cleanPrenatal = prenatals.whereType<Prenatal>().toList();

    return cleanPrenatal;
  }

  Future<void> storePrenatalRecord(Prenatal prenatal) async {
    final url = apiURIBase.replace(path: LaravelPaths.prenatal);

    final ttItem = prenatal.ttItems.isNotEmpty ? prenatal.ttItems.first : {'term': '1st Trimester'};

    final ironSuppItem = prenatal.ironSuppItems.isNotEmpty
        ? prenatal.ironSuppItems.first
        : {'iron_supplement_no_tabs': '30'};

    final serviceContent = prenatal.services.isNotEmpty ? prenatal.services.join(', ') : 'None';
    final adviceContent = prenatal.advices.isNotEmpty ? prenatal.advices.join(', ') : 'None';

    const int patientInfoId = 1;

    final Map<String, dynamic> payload = {
      PatientInformationFields.philhealth: prenatal.patientInformation.philhealth,
      PatientInformationFields.nhts: prenatal.patientInformation.nhts,
      PatientInformationFields.lmp: prenatal.patientInformation.lmp.toString(),
      PatientInformationFields.obStatus: prenatal.patientInformation.obStatus.toString(),
      PatientInformationFields.edc: prenatal.patientInformation.edc.toString(),
      PatientInformationFields.assignedBy: prenatal.patientInformation.assignById,
      PrenatalFields.patientInformationAccompaniedBy: prenatal.patientInformation.accompanyById,
      PrenatalFields.patientInformationUserId: prenatal.laravelId,
      PrenatalFields.immunizationTerm: ttItem['term'] ?? "NA",
      PrenatalFields.ironSupplementNoTabs: ironSuppItem['iron_supplement_no_tabs'] ?? "NA",
      PrenatalFields.isBreastFeeding: prenatal.breastFeeding ? 1 : 0,
      PrenatalFields.isFamilyPlanning: prenatal.familyPlanning ? 1 : 0,
      PrenatalFields.isChildProperNutrition: prenatal.properNutritionForChild ? 1 : 0,
      PrenatalFields.isSelfProperNutrition: prenatal.properNutritionForMyself ? 1 : 0,
      PrenatalFields.donorFullname: prenatal.donorFullname,
      PrenatalFields.donorContactNumber: prenatal.donorContact,
      PrenatalFields.donorBloodType: prenatal.donorBloodTyped ? 1 : 0,
      PrenatalFields.clinicVisitTrimester: getIntegerTrimesterEnum(prenatal.selectedTrimester),
      PrenatalFields.clinicVisitConsultWht: prenatal.consultWht ? 1 : 0,
      PrenatalFields.clinicVisitWhtIntroducedBirthPlan: prenatal.introducedBirthPlan ? 1 : 0,
      PrenatalFields.clinicVisitFundicHeight: prenatal.fundicHeight,
      PrenatalFields.serviceContent: serviceContent,
      PrenatalFields.adviceContent: adviceContent,
      PrenatalFields.trimester: getIntegerTrimesterEnum(prenatal.selectedTrimester),
      PrenatalFields.consultWht: prenatal.consultWht ? 1 : 0,
      PrenatalFields.whtIntroducedBirthPlan: prenatal.introducedBirthPlan ? 1 : 0,
      PrenatalFields.fundicHeight: prenatal.fundicHeight,
      PrenatalFields.patientInformationId: patientInfoId,
      PatientInformationFields.accompanyBy: prenatal.patientInformation.accompanyById,
    };

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        log('Success: ${responseData['message']}');
      } else {
        log('Failed to store prenatal data. Status code: ${response.statusCode}');
        log('Response: ${response.body}');
        throw Exception(
            'Failed to store prenatal data. Status code: ${response.statusCode} \n Response: ${response.body}');
      }
    } catch (e) {
      log('Exception during API call: $e');
      throw Exception('Error connecting to the server: $e');
    }
  }
}
