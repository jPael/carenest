import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:smartguide_app/services/laravel/fields.dart';

Future<int> updatePatientInformation(
    {required int id,
    required PatientInformation patientInformation,
    required String token}) async {
  final Map<String, dynamic> payload = {
    PatientInformationFields.philhealth: patientInformation.philhealth,
    PatientInformationFields.nhts: patientInformation.nhts,
    PatientInformationFields.lmp: patientInformation.lmp.toString(),
    PatientInformationFields.obStatus: patientInformation.obStatus.toString(),
    PatientInformationFields.edc: patientInformation.edc.toString(),
    //
  };

  try {
    final Uri url = apiURIBase.replace(path: LaravelPaths.updateMotherPatientInformationById(id));

    final res = await http.put(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: jsonEncode(payload));

    log(url.toString());
    log(payload.toString());
    // log("pi: " + res.body);

    final json = jsonDecode(res.body);

    if (res.statusCode > 299 || res.statusCode < HttpStatus.ok) {
      log(res.statusCode.toString());
      log(json['success'].toString());
      log(json['message'].toString());
      log(json['error'].toString());
      log(json['data'].toString());
      throw Exception();
    }

    return json['id'];
  } catch (e, stackTrace) {
    log(e.toString(), stackTrace: stackTrace);
    rethrow;
  }
}

Future<int> storePatientInformation(
    {required PatientInformation patientInformation, required String token}) async {
  final Map<String, dynamic> payload = {
    'date_of_birth': patientInformation.birthday.toString(),
    PatientInformationFields.philhealth: patientInformation.philhealth,
    PatientInformationFields.nhts: patientInformation.nhts,
    PatientInformationFields.lmp: patientInformation.lmp.toString(),
    PatientInformationFields.obStatus: patientInformation.obStatus.toString(),
    PatientInformationFields.edc: patientInformation.edc.toString(),
    LaravelUserFields.userId: patientInformation.userId,
    //
  };
  log(payload.toString());
  try {
    final Uri url = apiURIBase.replace(path: LaravelPaths.createMotherPatientInformation);
    log(url.toString());

    final res = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: jsonEncode(payload));

    // log("pi: " + res.body);

    final json = jsonDecode(res.body);

    log(json['message'].toString());
    log(json['error'].toString());
    log(json['data'].toString());

    if (res.statusCode > 299 || res.statusCode < HttpStatus.ok) {
      log(res.statusCode.toString());
      throw Exception();
    }

    return json['id'];
  } catch (e, stackTrace) {
    log(e.toString(), stackTrace: stackTrace);
    rethrow;
  }
}
