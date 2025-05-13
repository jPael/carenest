import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/models/revamp/STI.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/counseling.dart';
import 'package:smartguide_app/models/revamp/laboratory.dart';
import 'package:smartguide_app/models/revamp/treatments.dart';
import 'package:smartguide_app/services/laravel/revamp/prenatal_service.dart';

class FirstTrimester {
  static String label = "First Trimester";
  final int? id;
  final int clinicVisitId;
  final ClinicHistoryEnum checkUp;
  final double weight;
  final double height;
  final int ageGestation;
  final String bloodPressure;
  final NutritionalStatusEnum nutritionalStatus;
  final String birthPlan;
  final String teethFindings;
  final String hemoglobinCount;
  final String urinalysis;
  final String completeBloodCount;
  final String stoolExam;
  final String aceticAcidWash;
  final bool tetanusVaccine;
  final DateTime tetanusVaccineGivenAt;
  final DateTime returnDate;
  final int healthServiceProviderId;
  final String hospitalReferral;
  final String? otherServices;
  final DateTime createdAt;
  final DateTime updatedAt;

  final List<Laboratory> laboratories;
  final List<Sti> stis;
  final List<Treatment> treatments;
  final List<Counseling> counselings;
  final Person? healthServiceProvider;

  FirstTrimester(
      {this.id,
      required this.clinicVisitId,
      required this.checkUp,
      required this.weight,
      required this.height,
      required this.ageGestation,
      required this.bloodPressure,
      required this.nutritionalStatus,
      required this.birthPlan,
      required this.teethFindings,
      required this.hemoglobinCount,
      required this.urinalysis,
      required this.completeBloodCount,
      required this.stoolExam,
      required this.aceticAcidWash,
      required this.tetanusVaccine,
      required this.tetanusVaccineGivenAt,
      required this.returnDate,
      required this.healthServiceProviderId,
      required this.hospitalReferral,
      required this.otherServices,
      required this.createdAt,
      required this.updatedAt,
      required this.laboratories,
      required this.stis,
      required this.treatments,
      required this.counselings,
      this.healthServiceProvider});

  String get trimesterlabel => label;

  static FirstTrimester fromJson(Map<String, dynamic> json) {
    return FirstTrimester(
      id: json['id'],
      clinicVisitId: json['clinic_visit_id'],
      checkUp: ClinicHistory.fromLaravelValueToClinicHistoryEnum(json['check_up']),
      weight: json['weight'] * 1.0,
      height: json['height'] * 1.0,
      ageGestation: json['age_gestation'],
      bloodPressure: json['blood_pressure'],
      nutritionalStatus:
          ClinicHistory.fromLaravelValueToNutritionalStatus(json['nutritional_status']),
      birthPlan: json['birth_plan'],
      teethFindings: json['teeth_findings'],
      hemoglobinCount: json['hemoglobin_count'],
      urinalysis: json['urinalysis'],
      completeBloodCount: json['complete_blood_count'],
      stoolExam: json['stool_exam'],
      aceticAcidWash: json['acetic_acid_wash'],
      tetanusVaccine: (json['tetanus_vaccine'] == 1),
      tetanusVaccineGivenAt: DateTime.parse(json['tetanus_vaccine_given_at']),
      returnDate: DateTime.parse(json['return_date']),
      healthServiceProviderId: json['health_service_provider_id'],
      hospitalReferral: json['hospital_referral'],
      otherServices: json['other_services'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      laboratories: json['laboratories'] != null
          ? (json['laboratories'] as List).map((l) => Laboratory.fromJson(l)).toList()
          : <Laboratory>[],
      stis: json['stis'] != null
          ? (json['stis'] as List).map((s) => Sti.fromJson(s)).toList()
          : <Sti>[],
      treatments: json['treatments'] != null
          ? (json['treatments'] as List).map((t) => Treatment.fromJson(t)).toList()
          : <Treatment>[],
      counselings: json['counselings'] != null
          ? (json['counselings'] as List).map((c) => Counseling.fromJson(c)).toList()
          : <Counseling>[],
      healthServiceProvider: Person.fromJsonStatic(json['health_service_provider'])!,
    );
  }

  Future<void> store({required String token}) async {
    await createFirsTrimesterClinicVisit(visit: this, token: token);
  }
}
