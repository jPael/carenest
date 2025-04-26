import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/after_care.dart';
import 'package:smartguide_app/models/birth_plan.dart';
import 'package:smartguide_app/models/care_and_test.dart';
import 'package:smartguide_app/models/counseling.dart';
import 'package:smartguide_app/models/donor.dart';
import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:smartguide_app/services/laravel/fields.dart';
import 'package:smartguide_app/services/laravel/user_services.dart';
import 'package:smartguide_app/services/user_services.dart';
import 'package:smartguide_app/utils/utils.dart';

class PrenatalServices {
  Future<Map<String, dynamic>?> fetchPatientInformationById(
      {required String token, required int userId, required int patientInformationId}) async {
    if (token.isEmpty) return null;

    final List<Prenatal> prenatals =
        await fetchAllPrenatalByLaravelUserId(token: token, id: userId);
    if (prenatals.isEmpty) return null;

    final Prenatal prenatal = prenatals.firstWhere((p) => p.id! == patientInformationId);

    // careAndTest
    final CareAndTest ci = CareAndTest(
        whtPersonnel: prenatal.patientInformation.assignedByData,
        trimester: prenatal.selectedTrimester,
        consultWht: prenatal.consultWht,
        introducedBirthPlann: prenatal.introducedBirthPlan,
        fundicHeight: prenatal.fundicHeight,
        isFundicNormal: prenatal.fundicNormal,
        bloodPressure: prenatal.bloodPressure,
        isBloodPressureNormal: prenatal.bloodPressureNormal,
        dateOfVisit: prenatal.createdAt,
        advices: prenatal.advices,
        services: prenatal.services);

    // birth plan
    final Map<String, dynamic> assignedByJson =
        await fetchUserByUserId(id: prenatal.patientInformation.assignById, token: token);
    final Map<String, dynamic> accompanyByJson =
        await fetchUserByUserId(id: prenatal.patientInformation.accompanyById, token: token);

    final Person? assignedByData = Person.fromJsonStatic(assignedByJson);
    final Person? accompaniedBy = Person.fromJsonStatic(accompanyByJson);

    final BirthPlan bi = BirthPlan(
        birthplace: prenatal.birthplace,
        assignedBy: assignedByData!,
        accompaniedBy: accompaniedBy!);

    // afterCare
    final AfterCare afi = AfterCare(
        immunzation: prenatal.ttItems
            .map((i) => Immunization(term: i['term'], date: DateTime.parse(i['created_at'])))
            .toList(),
        ironSupplement: prenatal.ironSuppItems
            .map((i) => IronSupplement(tabs: i['no_tabs'], date: DateTime.parse(i['created_at'])))
            .toList());

    // counseling
    final Counseling co = Counseling(
        breastFeeding: prenatal.breastFeeding,
        familyPlanning: prenatal.familyPlanning,
        properNutrition: prenatal.properNutrition,
        childProperNutrition: prenatal.properNutritionForChild,
        selfProperNutrition: prenatal.properNutritionForMyself);

    final Map<String, dynamic> patientInformation = {
      "patientInformation": prenatal.patientInformation,
      'careAndTest': ci,
      'birthPlan': bi,
      'afterCare': afi,
      'counseling': co
    };

    return patientInformation;
  }

  Future<Map<String, dynamic>?> fetchLatestPatientInformationByToken(String token, int id) async {
    if (token.isEmpty) return null;

    final List<Prenatal> prenatals = await fetchAllPrenatalByLaravelUserId(token: token, id: id);
    if (prenatals.isEmpty) return null;

    final Prenatal prenatal = prenatals.last;

    // careAndTest
    final CareAndTest ci = CareAndTest(
        whtPersonnel: prenatal.patientInformation.assignedByData,
        trimester: prenatal.selectedTrimester,
        consultWht: prenatal.consultWht,
        introducedBirthPlann: prenatal.introducedBirthPlan,
        fundicHeight: prenatal.fundicHeight,
        isFundicNormal: prenatal.fundicNormal,
        bloodPressure: prenatal.bloodPressure,
        isBloodPressureNormal: prenatal.bloodPressureNormal,
        dateOfVisit: prenatal.createdAt,
        advices: prenatal.advices,
        services: prenatal.services);

    // birth plan
    final Map<String, dynamic> assignedByJson =
        await fetchUserByUserId(id: prenatal.patientInformation.assignById, token: token);
    final Map<String, dynamic> accompanyByJson =
        await fetchUserByUserId(id: prenatal.patientInformation.accompanyById, token: token);

    final Person? assignedByData = Person.fromJsonStatic(assignedByJson);
    final Person? accompaniedBy = Person.fromJsonStatic(accompanyByJson);

    final BirthPlan bi = BirthPlan(
        birthplace: prenatal.birthplace,
        assignedBy: assignedByData!,
        accompaniedBy: accompaniedBy!);

    // afterCare
    final AfterCare afi = AfterCare(
        immunzation: prenatal.ttItems
            .map((i) => Immunization(term: i['term'], date: DateTime.parse(i['created_at'])))
            .toList(),
        ironSupplement: prenatal.ironSuppItems
            .map((i) => IronSupplement(tabs: i['no_tabs'], date: DateTime.parse(i['created_at'])))
            .toList());

    // counseling
    final Counseling co = Counseling(
        breastFeeding: prenatal.breastFeeding,
        familyPlanning: prenatal.familyPlanning,
        properNutrition: prenatal.properNutrition,
        childProperNutrition: prenatal.properNutritionForChild,
        selfProperNutrition: prenatal.properNutritionForMyself);

    final Map<String, dynamic> patientInformation = {
      "patientInformation": prenatal.patientInformation,
      'careAndTest': ci,
      'birthPlan': bi,
      'afterCare': afi,
      'counseling': co
    };

    return patientInformation;
  }

  Future<Prenatal?> fetchPrenatalByPrenatalId({required String token, required int id}) async {
    final List<Prenatal> prenatals = await fetchAllPrenatal(token);
    return prenatals.where((p) => p.id == id).firstOrNull;
  }

  Future<List<Prenatal>> fetchAllPrenatalByLaravelUserId(
      {required String token, required int id}) async {
    final List<Prenatal> prenatals = await fetchAllPrenatal(token);
    return prenatals.where((p) => p.laravelId == id).toList();
  }

  Future<List<Prenatal>> fetchAllPrenatalByMidwifeLaravelUserId(
      {required String token, required int id}) async {
    final List<Prenatal> prenatals = await fetchAllPrenatal(token);

    // log(prenatals.length.toString());

    // final List<Prenatal> uniquePrenatals = [];
    final List<int> seenIds = []; // Track seen IDs to ensure uniqueness

    final List<Prenatal?> uniquePrentals = prenatals.map((p) {
      if (!seenIds.contains(p.laravelId)) {
        seenIds.add(p.laravelId);
        return p;
      }
    }).toList();

    return uniquePrentals.whereType<Prenatal>().toList();
  }

  Future<List<Prenatal>> fetchAllPrenatal(String token) async {
    final url = apiURIBase.replace(path: LaravelPaths.allPrenatal);
    final res = await http.get(url);

    if (res.statusCode != 200) {
      log('Failed to fetch prenatal data. Status code: ${res.statusCode}');
      return [];
    }

    final List<dynamic> prenatalsMap = jsonDecode(res.body);

    // log("prenatalsMap: ${prenatalsMap.length.toString()}");

    if (prenatalsMap.isEmpty) return [];

    final List<Prenatal?> prenatals = await Future.wait(prenatalsMap.map((p) async {
      try {
        final int userId = p[LaravelUserFields.userId];
        final Map<String, dynamic> user = await fetchUserByUserId(id: userId, token: token);
        final String userEmail = user[LaravelUserFields.email];
        final Map<String, dynamic>? firebaseUser = await getUserByEmail(userEmail);

        if (firebaseUser == null) {
          log('Firebase user not found for email: $userEmail');
          return null;
        }

        // Handle clinic visits
        final List<dynamic> clinicVisits = p[PrenatalFields.clinicVisits] as List;
        if (clinicVisits.isEmpty) {
          log('No clinic visits found for prenatal record ${p[PrenatalFields.id]}');
          return null;
        }
        final Map<String, dynamic> clinicVisit = clinicVisits.first;

        // Handle counselings
        final List<dynamic> counselings = p[PrenatalFields.counselings] as List;
        final Map<String, dynamic> counseling = counselings.isNotEmpty ? counselings.first : {};

        // Handle blood donors
        final List<dynamic> bloodDonors = p[PrenatalFields.bloodDonors] as List;
        final Map<String, dynamic> bloodDonor = bloodDonors.isNotEmpty ? bloodDonors.first : {};

        final DateTime birthday = DateTime.parse(firebaseUser[UserFields.dateOfBirth]);
        final String barangay = firebaseUser[UserFields.address];

        return Prenatal(
          laravelId: p[LaravelUserFields.userId],
          selectedTrimester: getTrimesterEnumFromTrimesterString(
              clinicVisit['trimester']?.toString() ?? '1st Trimester'),
          consultWht: clinicVisit[PrenatalFields.consultWht] == 1,
          introducedBirthPlan: clinicVisit[PrenatalFields.whtIntroducedBirthPlan] == 1,
          fundicHeight: clinicVisit[PrenatalFields.fundicHeight]?.toString() ?? 'NA',
          fundicNormal: true,
          bloodPressure: (p[PrenatalFields.bloodPressure] ?? "NA").toString(),
          bloodPressureNormal: true,
          advices: [
            (clinicVisit[PrenatalFields.advices] as Map?)?.containsKey('content') ?? false
                ? (clinicVisit[PrenatalFields.advices]!['content'] ?? "NA")
                : "NA"
          ],
          services: [
            (clinicVisit[PrenatalFields.services] as Map?)?.containsKey('content') ?? false
                ? (clinicVisit[PrenatalFields.services]!['content'] ?? "NA")
                : "NA"
          ],
          birthplace: p[PrenatalFields.birthPlace] ?? "NA",
          patientInformation: PatientInformation(
            assignedByData: Person.fromJsonStatic(p['assigned_by'] ?? {}),
            bloodDonor: Donor(
              id: bloodDonor['id'] ?? 0,
              fullname: bloodDonor[PrenatalFields.donorFullname] ?? 'NA',
              contactNumber: bloodDonor[PrenatalFields.donorContactNumber] ?? 'NA',
              bloodTyped: bloodDonor[PrenatalFields.donorBloodType] == 1,
            ),
            philhealth: p[PatientInformationFields.philhealth] == 1,
            nhts: p[PatientInformationFields.nhts] == 1,
            lmp: DateTime.parse(p[PatientInformationFields.lmp]),
            edc: DateTime.parse(p[PatientInformationFields.edc]),
            obStatus: p[PatientInformationFields.obStatus] ?? 'NA',
            assignById: (p[PatientInformationFields.assignedBy] as Map?)?.containsKey('id') ?? false
                ? p[PatientInformationFields.assignedBy]['id']
                : 0,
            accompanyById:
                (p[PatientInformationFields.accompanyBy] as Map?)?.containsKey('id') ?? false
                    ? p[PatientInformationFields.accompanyBy]['id']
                    : 0,
            accompaniedByData:
                Person.fromJsonStatic(p[PatientInformationFields.accompanyByData] ?? {}),
          ),
          ttItems:
              (p[PrenatalFields.immunizationTerm] as List?)?.cast<Map<String, dynamic>>() ?? [],
          ironSuppItems:
              (p[PrenatalFields.ironSupplements] as List?)?.cast<Map<String, dynamic>>() ?? [],
          barangay: barangay,
          birthday: birthday,
          fullname: user[LaravelUserFields.name],
          age: calculateAge(birthday).toString(),
          breastFeeding: counseling[PrenatalFields.isBreastFeeding] == 1,
          familyPlanning: counseling[PrenatalFields.isFamilyPlanning] == 1,
          properNutrition: true,
          properNutritionForChild: counseling[PrenatalFields.isChildProperNutrition] == 1,
          properNutritionForMyself: counseling[PrenatalFields.isSelfProperNutrition] == 1,
          donorFullname: bloodDonor[PrenatalFields.donorFullname] ?? 'NA',
          donorContact: bloodDonor[PrenatalFields.donorContactNumber] ?? 'NA',
          donorBloodTyped: bloodDonor[PrenatalFields.donorBloodType] == 1,
          createdAt: DateTime.parse(p[PrenatalFields.createdAt]),
          updatedAt: DateTime.parse(p[PrenatalFields.updatedAt]),
          id: p[PrenatalFields.id],
        );
      } catch (e) {
        log('Error processing prenatal record: $e');
        return null;
      }
    }).toList());

    return prenatals.whereType<Prenatal>().toList();
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
