import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/models/revamp/advice.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';
import 'package:smartguide_app/models/revamp/laboratory.dart';
import 'package:smartguide_app/models/revamp/treatments.dart';
import 'package:smartguide_app/models/revamp/counseling.dart';
import 'package:smartguide_app/services/laravel/revamp/prenatal_service.dart';

class SecondTrimester {
  static const String label = "Second Trimester";
  final int? id;
  final int clinicVisitId;
  final ClinicHistoryEnum checkUp;
  final double weight;
  final double height;
  final int ageGestation;
  final String bloodPressure;
  final NutritionalStatusEnum nutritionalStatus;
  final String assessment;
  final String birthPlanChanges;
  final String teethFindings;
  final String urinalysis;
  final String completeBloodCount;
  final String? stiEtiologicTest;
  final String? oralGlucoseTest;
  final String? papSmear;
  final String? bacteriuria;
  final DateTime returnDate;
  final int healthServiceProviderId;
  final String hospitalReferral;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  final List<Advice> advices;
  final List<Laboratory> laboratories;
  final List<Treatment> treatments;
  final List<Counseling> counselings;

  final Person? healthServiceProvider;

  SecondTrimester({
    this.id,
    required this.clinicVisitId,
    required this.checkUp,
    required this.weight,
    required this.height,
    required this.ageGestation,
    required this.bloodPressure,
    required this.nutritionalStatus,
    required this.assessment,
    required this.birthPlanChanges,
    required this.teethFindings,
    required this.urinalysis,
    required this.completeBloodCount,
    required this.stiEtiologicTest,
    required this.oralGlucoseTest,
    required this.papSmear,
    required this.returnDate,
    required this.healthServiceProviderId,
    required this.hospitalReferral,
    required this.notes,
    required this.advices,
    required this.laboratories,
    required this.treatments,
    required this.createdAt,
    required this.updatedAt,
    required this.bacteriuria,
    required this.counselings,
    this.healthServiceProvider,
  });

  String get trimesterLabel => label;

  static SecondTrimester fromJson(Map<String, dynamic> json) {
    final List<Advice> advices = json['advices'] != null
        ? (json['advices'] as List).map((a) => Advice.fromJson(a)).toList()
        : <Advice>[];
    final List<Laboratory> laboratories = json['laboratories'] != null
        ? (json['laboratories'] as List).map((l) => Laboratory.fromJson(l)).toList()
        : <Laboratory>[];

    final List<Treatment> treatments = json['treatments'] != null
        ? (json['treatments'] as List).map((t) => Treatment.fromJson(t)).toList()
        : <Treatment>[];

    final List<Counseling> counselings = json['counselings'] != null
        ? (json['counselings'] as List).map((t) => Counseling.fromJson(t)).toList()
        : <Counseling>[];

    return SecondTrimester(
      id: json['id'],
      bacteriuria: json['bacteriuria'],
      clinicVisitId: json['clinic_visit_id'],
      checkUp: ClinicHistory.fromLaravelValueToClinicHistoryEnum(json['check_up']),
      weight: json['weight'] * 1.0,
      height: json['height'] * 1.0,
      ageGestation: json['age_gestation'],
      bloodPressure: json['blood_pressure'],
      nutritionalStatus:
          ClinicHistory.fromLaravelValueToNutritionalStatus(json['nutritional_status']),
      assessment: json['assessment'],
      birthPlanChanges: json['birth_plan_changes'],
      teethFindings: json['teeth_findings'],
      urinalysis: json['urinalysis'],
      completeBloodCount: json['complete_blood_count'],
      stiEtiologicTest: json['sti_etiologic_test'],
      oralGlucoseTest: json['oral_glucose_test'],
      papSmear: json['pap_smear'],
      returnDate: DateTime.parse(json['return_date']),
      healthServiceProviderId: json['health_service_provider_id'],
      hospitalReferral: json['hospital_referral'],
      notes: json['notes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      advices: advices,
      treatments: treatments,
      laboratories: laboratories,
      counselings: counselings,
      healthServiceProvider: Person.fromJsonStatic(json['health_service_provider'])!,
    );
  }

  Future<void> store({required String token}) async {
    await createSecondTrimesterClinicVisit(token: token, visit: this);
  }
}
