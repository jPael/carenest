import 'dart:developer';

import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/models/revamp/clinic_history.dart';

class PersonHistory {
  final int id;
  final String philHealth;
  final String nhts;
  final String obStatus;
  final DateTime lmp;
  final DateTime edc;
  final int userId;
  final DateTime? dateOfBirth;
  final Person? user;
  final DateTime createdAt;
  final DateTime updatedAt;

  final List<ClinicHistory> clinicVisits;

  PersonHistory({
    this.dateOfBirth,
    required this.id,
    required this.philHealth,
    required this.nhts,
    required this.obStatus,
    required this.lmp,
    required this.edc,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.clinicVisits,
  });

  static PersonHistory fromJson(Map<String, dynamic> json) {
    // log("fromjson: " + json.toString());
    final List<dynamic> clinicVisitsJson = json['clinic_visits'];

    List<ClinicHistory> history;

    if (clinicVisitsJson.isEmpty) {
      history = [];
    } else {
      history = clinicVisitsJson.map((c) => ClinicHistory.fromJson(c, json['user_id'])).toList();
    }

    return PersonHistory(
        id: json['id'],
        philHealth: json['philhealt'] ?? "",
        nhts: json['nhts'] ?? "",
        obStatus: json['ob_status'],
        lmp: DateTime.parse(json['lmp']),
        user: Person.fromJsonStatic({...json['user'], "date_of_birth ": json['date_of_birth']}),
        edc: DateTime.parse(json['edc']),
        dateOfBirth: json['date_of_birth'] == null ? null : DateTime.parse(json['date_of_birth']),
        userId: json['user_id'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        clinicVisits: history);
  }

  // PersonHistory
}
