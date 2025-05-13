import 'package:smartguide_app/models/revamp/first_trimester.dart';
import 'package:smartguide_app/models/revamp/second_trimester.dart';
import 'package:smartguide_app/models/revamp/third_trimester.dart';

class ClinicHistory {
  final int id;
  final int patientInformationId;
  final String obStatus;
  final DateTime dateOfBirth;
  final String philhealt;
  final String nhts;
  final int userId;
  final String barangayName;
  final DateTime lmp;
  final DateTime edc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<FirstTrimester> firstTrimesters;
  final List<SecondTrimester> secondTrimesters;
  final List<ThirdTrimester> thirdTrimesters;

  ClinicHistory({
    required this.userId,
    required this.id,
    required this.patientInformationId,
    required this.obStatus,
    required this.dateOfBirth,
    required this.philhealt,
    required this.nhts,
    required this.barangayName,
    required this.lmp,
    required this.edc,
    required this.createdAt,
    required this.updatedAt,
    required this.firstTrimesters,
    required this.secondTrimesters,
    required this.thirdTrimesters,
  });

  static ClinicHistory fromJson(Map<String, dynamic> json, int id) {
    // log(json.toString());
    final List<FirstTrimester> firstTrimester = (json['first_trimester'] as List).map((t) {
      return FirstTrimester.fromJson(t);
    }).toList();
    final List<SecondTrimester> secondTimester =
        (json['second_trimester'] as List).map((t) => SecondTrimester.fromJson(t)).toList();
    final List<ThirdTrimester> thirdTrimester =
        (json['third_trimester'] as List).map((t) => ThirdTrimester.fromJson(t)).toList();

    return ClinicHistory(
        userId: id,
        id: json['id'],
        patientInformationId: json['patient_information_id'],
        obStatus: json['ob_status'],
        dateOfBirth: DateTime.parse(json['date_of_birth']),
        philhealt: json['philhealt'],
        nhts: json['nhts'],
        barangayName: json['barangay_name'],
        lmp: DateTime.parse(json['lmp']),
        edc: DateTime.parse(json['edc']),
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        firstTrimesters: firstTrimester,
        secondTrimesters: secondTimester,
        thirdTrimesters: thirdTrimester);
  }

  static ClinicHistoryEnum fromLaravelValueToClinicHistoryEnum(String v) {
    switch (v) {
      case "FIRST":
        return ClinicHistoryEnum.first;
      case "SECOND":
        return ClinicHistoryEnum.second;
      case "THIRD":
        return ClinicHistoryEnum.third;
      default:
        throw Exception("Unknown clinic history");
    }
  }

  static NutritionalStatusEnum fromLaravelValueToNutritionalStatus(String v) {
    switch (v) {
      case "NORMAL":
        return NutritionalStatusEnum.normal;
      case "OVERWEIGHT":
        return NutritionalStatusEnum.overweight;
      case "UNDERWEIGHT":
        return NutritionalStatusEnum.underweight;
      default:
        throw Exception("Unknown nutrition status");
    }
  }
}

enum ClinicHistoryEnum { first, second, third }

extension ClinicHistoryEnumExtension on ClinicHistoryEnum {
  String get label {
    switch (this) {
      case ClinicHistoryEnum.first:
        return "First check-up";
      case ClinicHistoryEnum.second:
        return "Second check-up";
      case ClinicHistoryEnum.third:
        return "Third check-up";
    }
  }

  String get laravelValue {
    switch (this) {
      case ClinicHistoryEnum.first:
        return "FIRST";
      case ClinicHistoryEnum.second:
        return "SECOND";
      case ClinicHistoryEnum.third:
        return "THIRD";
    }
  }
}

enum NutritionalStatusEnum { normal, underweight, overweight }

extension NutritionalStatusEnumExtension on NutritionalStatusEnum {
  String get laravelValue {
    switch (this) {
      case NutritionalStatusEnum.normal:
        return "NORMAL";
      case NutritionalStatusEnum.overweight:
        return "OVERWEIGHT";
      case NutritionalStatusEnum.underweight:
        return "UNDERWEIGHT";
    }
  }
}
