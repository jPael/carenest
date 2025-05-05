import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/models/patient_information.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:smartguide_app/services/laravel/fields.dart';

Future<int> storePatientInformation(
    {required PatientInformation patientInformation, required String token}) async {
  final Map<String, dynamic> payload = {
    PatientInformationFields.philhealth: patientInformation.philhealth == true ? 1 : 0,
    PatientInformationFields.nhts: patientInformation.nhts == true ? 1 : 0,
    PatientInformationFields.lmp: patientInformation.lmp.toString(),
    PatientInformationFields.obStatus: patientInformation.obStatus.toString(),
    PatientInformationFields.edc: patientInformation.edc.toString(),
    LaravelUserFields.userId: patientInformation.userId,
    //

    PrenatalFields.donorFullname: patientInformation.bloodDonor!.fullname,
    PrenatalFields.donorContactNumber: patientInformation.bloodDonor!.contactNumber,
    PrenatalFields.donorBloodType: patientInformation.bloodDonor!.bloodTyped ? 1 : 0,
  };

  try {
    final Uri url = apiURIBase.replace(path: LaravelPaths.createMotherPatientInformation);

    final res = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: jsonEncode(payload));

    // log("pi: " + res.body);

    final json = jsonDecode(res.body);

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
