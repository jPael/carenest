import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/after_care.dart';
import 'package:smartguide_app/models/birth_plan.dart';
import 'package:smartguide_app/models/care_and_test.dart';
import 'package:smartguide_app/models/clinic_visit.dart';
import 'package:smartguide_app/models/counseling.dart';
import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/models/revamp/person_history.dart';
import 'package:smartguide_app/models/trimester.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:smartguide_app/services/laravel/fields.dart';
import 'package:smartguide_app/services/laravel/user_services.dart';
import 'package:smartguide_app/services/user_services.dart';
import 'package:smartguide_app/utils/utils.dart';

class PrenatalServices {
  Future<PatientInformation?> fetchMotherPatientInformationById(
      {required int id, required String token}) async {
    final url = apiURIBase.replace(path: LaravelPaths.motherPatientInformationById(id));

    log(url.toString());

    final res = await http
        .get(url, headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"});

    final json = jsonDecode(res.body);

    try {
      final PatientInformation patientInformation = PatientInformation.fromJson(json);

      return patientInformation;
    } catch (e, StackTrace) {
      log("$e", stackTrace: StackTrace);

      return null;
    }
  }

  Future<List<ClinicVisit>> fetchClinicVisitByPrenatalId(
      {required int prenatalId, required String token}) async {
    final Uri url = apiURIBase.replace(path: LaravelPaths.getClinicVisitsById(prenatalId));

    final http.Response res = await http
        .get(url, headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"});

    final List<dynamic> json = jsonDecode(res.body);
    // log(res.body);

    return json.map((e) => ClinicVisit.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Map<String, dynamic>?> fetchPatientInformationByIdWithClinicId(
      {required String token, required int patientInformationId, required int clinicId}) async {
    if (token.isEmpty) return null;

    final List<Prenatal> prenatals = await fetchPrenatalIdWithClinicId(
        token: token, clinicId: clinicId, prenatalId: patientInformationId);
    if (prenatals.isEmpty) return null;

    final Prenatal prenatal = prenatals.firstWhere((p) => p.id! == patientInformationId);

    final Map<String, dynamic>? assignedByJson =
        await fetchUserByUserId(id: prenatal.assignedBy, token: token);
    final Map<String, dynamic>? accompanyByJson =
        await fetchUserByUserId(id: prenatal.accompaniedBy, token: token);

    final Person? assignedByData = Person.fromJsonStatic(assignedByJson);
    final Person? accompaniedBy = Person.fromJsonStatic(accompanyByJson);

    final CareAndTest ci = CareAndTest(
        whtPersonnel: assignedByData,
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

    final BirthPlan bi = BirthPlan(
        birthplace: prenatal.birthplace, assignedBy: assignedByData, accompaniedBy: accompaniedBy);

    final AfterCare afi = AfterCare(
        immunzation: prenatal.ttItems
            .map((i) =>
                Immunization(term: i['term'], date: DateTime.parse(i['created_at']).toLocal()))
            .toList(),
        ironSupplement: prenatal.ironSuppItems
            .map((i) =>
                IronSupplement(tabs: i['no_tabs'], date: DateTime.parse(i['created_at']).toLocal()))
            .toList());

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

  Future<Map<String, dynamic>?> fetchPatientInformationById(
      {required String token, required int userId, required int patientInformationId}) async {
    if (token.isEmpty) return null;

    final List<Prenatal> prenatals =
        await fetchAllPrenatalByLaravelUserId(token: token, id: userId);
    if (prenatals.isEmpty) return null;

    final Prenatal prenatal = prenatals.firstWhere((p) => p.id! == patientInformationId);

    final Map<String, dynamic>? assignedByJson =
        await fetchUserByUserId(id: prenatal.assignedBy, token: token);
    final Map<String, dynamic>? accompanyByJson =
        await fetchUserByUserId(id: prenatal.accompaniedBy, token: token);

    final Person? assignedByData = Person.fromJsonStatic(assignedByJson);
    final Person? accompaniedBy = Person.fromJsonStatic(accompanyByJson);

    final CareAndTest ci = CareAndTest(
        whtPersonnel: assignedByData,
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

    final BirthPlan bi = BirthPlan(
        birthplace: prenatal.birthplace, assignedBy: assignedByData, accompaniedBy: accompaniedBy);

    final AfterCare afi = AfterCare(
        immunzation: prenatal.ttItems
            .map((i) =>
                Immunization(term: i['term'], date: DateTime.parse(i['created_at']).toLocal()))
            .toList(),
        ironSupplement: prenatal.ironSuppItems
            .map((i) =>
                IronSupplement(tabs: i['no_tabs'], date: DateTime.parse(i['created_at']).toLocal()))
            .toList());

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

    final Map<String, dynamic>? assignedByJson =
        await fetchUserByUserId(id: prenatal.assignedBy, token: token);
    final Map<String, dynamic>? accompanyByJson =
        await fetchUserByUserId(id: prenatal.accompaniedBy, token: token);

    final Person? assignedByData = Person.fromJsonStatic(assignedByJson);
    final Person? accompaniedBy = Person.fromJsonStatic(accompanyByJson);

    final CareAndTest? ci = CareAndTest(
        whtPersonnel: assignedByData,
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

    final BirthPlan? bi = BirthPlan(
        birthplace: prenatal.birthplace, assignedBy: assignedByData, accompaniedBy: accompaniedBy);

    final AfterCare? afi = AfterCare(
      immunzation: prenatal.ttItems.where((i) => i.isNotEmpty).map<Immunization>((i) {
        return Immunization(
          term: i['term'],
          date: DateTime.parse(i['created_at'] as String).toLocal(),
        );
      }).toList(),
      ironSupplement: prenatal.ironSuppItems.where((i) => i.isNotEmpty).map<IronSupplement>((i) {
        return IronSupplement(
          tabs: i['no_tabs'],
          date: DateTime.parse(i['created_at'] as String).toLocal(),
        );
      }).toList(),
    );

    final Counseling? co = Counseling(
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

  Future<PersonHistory?> fetchAllClinicHistoryByUserId(
      {required String token, required int id}) async {
    final url = apiURIBase.replace(path: LaravelPaths.allPrenatal);
    // log(message)
    try {
      final res = await http.get(url);

      if (res.statusCode != 200) {
        log('Failed to fetch prenatal data. Status code: ${res.statusCode}');
        throw Exception('Failed to fetch prenatal data. Status code: ${res.statusCode}');
      }

      final List<dynamic> prenatalsMap = jsonDecode(res.body)
        ..sort(
          (a, b) => DateTime.parse(a[PrenatalFields.createdAt])
              .compareTo(DateTime.parse(b[PrenatalFields.createdAt])),
        );

      if (prenatalsMap.isEmpty) {
        throw Exception('Failed to fetch prenatal data. Status code: ${res.statusCode}');
      }

      // log(prenatalsMap.toString());

      final currentHistory = prenatalsMap.firstWhere(
        (t) {
          log(t['id'].toString());
          log(t['user_id'].toString());
          log(id.toString());

          return t['user_id'] == id;
        },
        orElse: () => throw Exception('No records found for user id: $id'),
      );

      List<Map<String, dynamic>> clinicVisits = [];
      for (var prenatal in prenatalsMap) {
        if (prenatal['user_id'] == id) {
          clinicVisits.addAll((prenatal["clinic_visits"] as List).cast<Map<String, dynamic>>());
        }
      }

      clinicVisits.sort(
        (a, b) => DateTime.parse(b['created_at']).compareTo(DateTime.parse(a['created_at'])),
      );

      currentHistory['clinic_visits'] = clinicVisits;

      // log(currentHistory.toString());

      return PersonHistory.fromJson(currentHistory);
    } on Exception catch (e, stackTrace) {
      log("e");
      log(e.toString(), stackTrace: stackTrace);
      return null;
    }
  }

  Future<List<Prenatal>> fetchAllPrenatalByLaravelUserId(
      {required String token, required int id}) async {
    final List<Prenatal> prenatals = await fetchAllPrenatal(token);

    return prenatals.whereType<Prenatal>().where((p) {
      return p.laravelId == id;
    }).toList();
  }

  Future<List<Prenatal>> fetchAllPrenatalByMidwifeLaravelUserId(
      {required String token, required int id}) async {
    final List<Prenatal> prenatals = await fetchAllPrenatal(token);

    final List<int> seenIds = [];

    final List<Prenatal?> uniquePrentals = prenatals.map((p) {
      if (!seenIds.contains(p.laravelId)) {
        seenIds.add(p.laravelId!);
        return p;
      }
    }).toList();

    return uniquePrentals.whereType<Prenatal>().toList();
  }

  Future<List<Prenatal>> fetchPrenatalIdWithClinicId(
      {required String token, required int clinicId, required int prenatalId}) async {
    final url = apiURIBase.replace(path: LaravelPaths.allPrenatal);
    final res = await http.get(url);

    if (res.statusCode != 200) {
      log('Failed to fetch prenatal data. Status code: ${res.statusCode}');
      return [];
    }

    final List<dynamic> prenatalsMap = jsonDecode(res.body);

    if (prenatalsMap.isEmpty) return [];

    final List<Prenatal?> prenatals =
        await Future.wait(prenatalsMap.where((p) => p['id'] == prenatalId).map((p) async {
      try {
        final int userId = p[LaravelUserFields.userId];

        final Map<String, dynamic> user =
            await fetchUserByUserId(id: userId, token: token) as Map<String, dynamic>;
        final String userEmail = user[LaravelUserFields.email];
        final Map<String, dynamic>? firebaseUser = await getUserByEmail(userEmail);

        if (firebaseUser == null) {
          log('Firebase user not found for email: $userEmail');
          return null;
        }

        final List<dynamic> clinicVisits = p[PrenatalFields.clinicVisits] as List;

        Map<String, dynamic>? clinicVisit;

        if (clinicVisits.isEmpty) {
          log('No clinic visits found for prenatal record ${p[PrenatalFields.id]}');
          clinicVisit = null;
        } else {
          clinicVisit = clinicVisits.firstWhere((c) {
            final int currClinicId = c['id'];
            return currClinicId == clinicId;
          });
        }

        final Map<String, dynamic> counseling =
            clinicVisit != null ? clinicVisit[PrenatalFields.counselings] : {};
        final Map<String, dynamic> ttItems =
            clinicVisit != null ? clinicVisit[PrenatalFields.immunizationTerm] : {};
        final Map<String, dynamic> ironSupplement =
            clinicVisit != null ? clinicVisit[PrenatalFields.ironSupplements] : {};

        final List<dynamic> bloodDonors = p[PrenatalFields.bloodDonors] as List;
        final Map<String, dynamic> bloodDonor = bloodDonors.isNotEmpty ? bloodDonors.first : {};

        final DateTime birthday = DateTime.parse(firebaseUser[UserFields.dateOfBirth]).toLocal();
        final String barangay = firebaseUser[UserFields.address];

        return Prenatal(
          laravelId: p[LaravelUserFields.userId],
          selectedTrimester: getTrimesterEnumFromTrimesterString(
              clinicVisit?['trimester']?.toString() ?? TrimesterEnum.first.laravelValue),
          consultWht: clinicVisit?[PrenatalFields.consultWht] == 1,
          introducedBirthPlan: clinicVisit?[PrenatalFields.whtIntroducedBirthPlan] == 1,
          fundicHeight: clinicVisit?[PrenatalFields.fundicHeight]?.toString() ?? 'NA',
          fundicNormal: true,
          bloodPressure: (p[PrenatalFields.bloodPressure] ?? "NA").toString(),
          bloodPressureNormal: true,
          advices: [
            (clinicVisit?[PrenatalFields.advices] as Map?)?.containsKey('content') ?? false
                ? (clinicVisit?[PrenatalFields.advices]!['content'] ?? "NA")
                : "NA"
          ],
          services: [
            (clinicVisit?[PrenatalFields.services] as Map?)?.containsKey('content') ?? false
                ? (clinicVisit?[PrenatalFields.services]!['content'] ?? "NA")
                : "NA"
          ],
          birthplace: clinicVisit?[PrenatalFields.bokenBirthPlace] ?? "NA",
          patientInformation: PatientInformation(
            userId: p[LaravelUserFields.userId],
            birthday: p['date_of_birth'],
            philhealth: p[PatientInformationFields.philhealth],
            nhts: p[PatientInformationFields.nhts],
            lmp: DateTime.parse(p[PatientInformationFields.lmp]).toLocal(),
            edc: DateTime.parse(p[PatientInformationFields.edc]).toLocal(),
            obStatus: p[PatientInformationFields.obStatus] ?? 'NA',
          ),
          ttItems: [ttItems],
          ironSuppItems: [ironSupplement],
          barangay: barangay,
          birthday: birthday,
          fullname: user[LaravelUserFields.name],
          age: calculateAge(birthday).toString(),
          breastFeeding: counseling[PrenatalFields.isBreastFeeding] == 1,
          familyPlanning: counseling[PrenatalFields.isFamilyPlanning] == 1,
          properNutrition: true,
          properNutritionForChild: counseling[PrenatalFields.isChildProperNutrition] == 1,
          properNutritionForMyself: counseling[PrenatalFields.isSelfProperNutrition] == 1,
          // TODO:: createdAt
          createdAt: DateTime.parse(p[PrenatalFields.createdAt]),
          updatedAt: DateTime.parse(p[PrenatalFields.updatedAt]).toLocal(),

          accompaniedBy: clinicVisit?[PatientInformationFields.accompanyBy],
          assignedBy: clinicVisit?[PatientInformationFields.assignedBy],
          id: p[PrenatalFields.id],
        );
      } catch (e, stackTrace) {
        log('Error processing prenatal record: $e', stackTrace: stackTrace);
        return null;
      }
    }).toList());

    return prenatals.whereType<Prenatal>().toList();
  }

  Future<List<Prenatal>> fetchAllPrenatal(String token) async {
    final url = apiURIBase.replace(path: LaravelPaths.allPrenatal);
    final res = await http.get(url);

    if (res.statusCode != 200) {
      log('Failed to fetch prenatal data. Status code: ${res.statusCode}');
      return [];
    }

    final List<dynamic> prenatalsMap = jsonDecode(res.body)
      ..sort(
        (a, b) => DateTime.parse(a[PrenatalFields.createdAt])
            .compareTo(DateTime.parse(b[PrenatalFields.createdAt])),
      );

    for (var p in prenatalsMap) {
      log(DateFormat('hh:MM aa')
          .format(DateTime.parse(p[PrenatalFields.createdAt]).toLocal())
          .toString());
    }

    if (prenatalsMap.isEmpty) return [];

    Map<int, dynamic> bloodDonorsById = {};

    final List<Prenatal?> prenatals = await Future.wait(prenatalsMap.map((p) async {
      log(p.toString());

      try {
        final int userId = p[LaravelUserFields.userId];
        final Map<String, dynamic>? donor = (p[PrenatalFields.bloodDonors] as List<dynamic>).isEmpty
            ? null
            : p[PrenatalFields.bloodDonors].first;

        if (donor != null && donor.isNotEmpty && donor[PrenatalFields.donorFullname] != null) {
          bloodDonorsById[userId] = donor;
        }

        final Map<String, dynamic> user =
            await fetchUserByUserId(id: userId, token: token) as Map<String, dynamic>;
        final String userEmail = user[LaravelUserFields.email];
        final Map<String, dynamic>? firebaseUser = await getUserByEmail(userEmail);

        if (firebaseUser == null) {
          log('Firebase user not found for email: $userEmail');
          return null;
        }

        final List<dynamic> clinicVisits = p[PrenatalFields.clinicVisits] as List;

        Map<String, dynamic>? clinicVisit;

        if (clinicVisits.isEmpty) {
          log('No clinic visits found for prenatal record ${p[PrenatalFields.id]}');
          clinicVisit = null;
        } else {
          clinicVisit = clinicVisits.first;
        }

        final Map<String, dynamic> counseling =
            clinicVisit != null ? clinicVisit[PrenatalFields.counselings] : {};
        final Map<String, dynamic> ttItems =
            clinicVisit != null ? clinicVisit[PrenatalFields.immunizationTerm] : {};
        final Map<String, dynamic> ironSupplement =
            clinicVisit != null ? clinicVisit[PrenatalFields.ironSupplements] : {};
        // final Map<String, dynamic> counseling = counselings.isNotEmpty ? counselings.first : {};

        // log(bloodDonorsById[userId].toString());

        final List<dynamic> bloodDonors = p[PrenatalFields.bloodDonors] as List;
        final Map<String, dynamic> bloodDonor = bloodDonors.isNotEmpty ? bloodDonors.first : {};

        final DateTime birthday = DateTime.parse(firebaseUser[UserFields.dateOfBirth]).toLocal();
        final String barangay = firebaseUser[UserFields.address];

        return Prenatal(
          laravelId: p[LaravelUserFields.userId],
          selectedTrimester: getTrimesterEnumFromTrimesterString(
              clinicVisit?['trimester']?.toString() ?? TrimesterEnum.first.laravelValue),
          consultWht: clinicVisit?[PrenatalFields.consultWht] == 1,
          introducedBirthPlan: clinicVisit?[PrenatalFields.whtIntroducedBirthPlan] == 1,
          fundicHeight: clinicVisit?[PrenatalFields.fundicHeight]?.toString() ?? 'NA',
          fundicNormal: true,
          bloodPressure: (p[PrenatalFields.bloodPressure] ?? "NA").toString(),
          bloodPressureNormal: true,
          advices: [
            (clinicVisit?[PrenatalFields.advices] as Map?)?.containsKey('content') ?? false
                ? (clinicVisit?[PrenatalFields.advices]!['content'] ?? "NA")
                : "NA"
          ],
          services: [
            (clinicVisit?[PrenatalFields.services] as Map?)?.containsKey('content') ?? false
                ? (clinicVisit?[PrenatalFields.services]!['content'] ?? "NA")
                : "NA"
          ],
          birthplace: clinicVisit?[PrenatalFields.bokenBirthPlace] ?? "NA",
          patientInformation: PatientInformation(
            birthday: p['date_of_birth'],
            userId: p[LaravelUserFields.userId],
            philhealth: p[PatientInformationFields.philhealth],
            nhts: p[PatientInformationFields.nhts],
            lmp: DateTime.parse(p[PatientInformationFields.lmp]).toLocal(),
            edc: DateTime.parse(p[PatientInformationFields.edc]).toLocal(),
            obStatus: p[PatientInformationFields.obStatus] ?? 'NA',
          ),
          ttItems: [ttItems],
          ironSuppItems: [ironSupplement],
          barangay: barangay,
          birthday: birthday,
          fullname: user[LaravelUserFields.name],
          age: calculateAge(birthday).toString(),
          breastFeeding: counseling[PrenatalFields.isBreastFeeding] == 1,
          familyPlanning: counseling[PrenatalFields.isFamilyPlanning] == 1,
          properNutrition: true,
          properNutritionForChild: counseling[PrenatalFields.isChildProperNutrition] == 1,
          properNutritionForMyself: counseling[PrenatalFields.isSelfProperNutrition] == 1,
          createdAt: DateTime.parse(p[PrenatalFields.createdAt]).toLocal(),
          updatedAt: DateTime.parse(p[PrenatalFields.updatedAt]).toLocal(),
          accompaniedBy: p[PatientInformationFields.accompanyBy],
          assignedBy: p[PatientInformationFields.assignedBy],
          id: p[PrenatalFields.id],
        );
      } catch (e, stackTrace) {
        log('Error processing prenatal record: $e', stackTrace: stackTrace);
        return null;
      }
    }).toList());

    return prenatals.whereType<Prenatal>().toList();
  }

  Future<void> storeClinicVisitRecord(ClinicVisit clinicVisit, {required String token}) async {
    final Map<String, dynamic> payload = {
      "barangay_name": clinicVisit.birthplace,
      "clinic_visit_trimester": clinicVisit.trimester.laravelValue,
      "clinic_visit_consul_wht": clinicVisit.consulWht ? 1 : 0,
      "clinic_visit_wht_introduced_birth_plan": clinicVisit.whtIntroducedBirthPlan ? 1 : 0,
      "clinic_visit_fundic_heigh": clinicVisit.fundicHeigh,
      "assigned_by": clinicVisit.assignedBy.id,
      "patient_information_accompany_by": clinicVisit.accompanyBy.id,
      "service_content": clinicVisit.services,
      "advice_content": clinicVisit.advices,
      "tt_imunizations": clinicVisit.ttImunizations,
      "iron_supplement_no_tabs": clinicVisit.ironSupplementNoTabs,
      "is_breast_feeding": clinicVisit.isBreastFeeding,
      "is_family_planning": clinicVisit.isFamilyPlanning,
      "is_child_proper_nutrition": clinicVisit.isChildProperNutrition,
      "is_self_proper_nutrition": clinicVisit.isSelfProperNutrition,
    };

    try {
      Uri url = apiURIBase.replace(
          path: LaravelPaths.getClinicVisitsById(clinicVisit.patientInformationId));

      // log(payload.toString());

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        log(responseData.toString());
      } else {
        throw Exception(
            'Failed to store prenatal data. Status code: ${response.statusCode} \n Response: ${response.body}');
      }
    } catch (e) {
      log('Exception during API call: $e');
      throw Exception('Error connecting to the server: $e');
    }
  }

  Future<void> storePrenatalRecord({required Prenatal prenatal, required String token}) async {
    final ttItem = prenatal.ttItems.isNotEmpty ? prenatal.ttItems.first : {'term': '1st Trimester'};
    final ironSuppItem = prenatal.ironSuppItems.isNotEmpty
        ? prenatal.ironSuppItems.first
        : {'iron_supplement_no_tabs': '30'};

    final serviceContent = prenatal.services.isNotEmpty ? prenatal.services.join(', ') : 'None';
    final adviceContent = prenatal.advices.isNotEmpty ? prenatal.advices.join(', ') : 'None';

    final Map<String, dynamic> payload = {
      PrenatalFields.birthplace: prenatal.birthplace,
      PatientInformationFields.philhealth: prenatal.patientInformation.philhealth == true ? 1 : 0,
      PatientInformationFields.nhts: prenatal.patientInformation.nhts == true ? 1 : 0,
      PatientInformationFields.lmp: prenatal.patientInformation.lmp.toString(),
      PatientInformationFields.obStatus: prenatal.patientInformation.obStatus.toString(),
      PatientInformationFields.edc: prenatal.patientInformation.edc.toString(),
      PatientInformationFields.assignedBy: prenatal.assignedBy,
      PrenatalFields.patientInformationAccompaniedBy: prenatal.accompaniedBy,
      PrenatalFields.patientInformationUserId: prenatal.laravelId,
      PrenatalFields.immunizationTerm: ttItem['term'] ?? "NA",
      PrenatalFields.ironSupplementNoTabs: ironSuppItem['iron_supplement_no_tabs'] ?? "NA",
      PrenatalFields.isBreastFeeding: prenatal.breastFeeding ? 1 : 0,
      PrenatalFields.isFamilyPlanning: prenatal.familyPlanning ? 1 : 0,
      PrenatalFields.isChildProperNutrition: prenatal.properNutritionForChild ? 1 : 0,
      PrenatalFields.isSelfProperNutrition: prenatal.properNutritionForMyself ? 1 : 0,
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
      PatientInformationFields.accompanyBy: prenatal.accompaniedBy,
    };

    try {
      Uri url = apiURIBase.replace(path: LaravelPaths.prenatal);

      log(payload.toString());

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
        log(responseData.toString());
      } else {
        throw Exception(
            'Failed to store prenatal data. Status code: ${response.statusCode} \n Response: ${response.body}');
      }
    } catch (e) {
      log('Exception during API call: $e');
      throw Exception('Error connecting to the server: $e');
    }
  }
}
