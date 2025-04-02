import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:smartguide_app/models/prenatal.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:smartguide_app/utils/utils.dart';

class PrenatalServices {
  Future<void> storePrenatalRecord(Prenatal prenatal) async {
    final url = apiURIBase.replace(path: LaravelPaths.prenatal);

    // The key issues are with these fields - ensure they're non-empty strings
    // Extract first items from TT immunization and iron supplement lists with proper default values
    final ttItem = prenatal.ttItems.isNotEmpty
        ? prenatal.ttItems.first
        : {'term': '1st Trimester'}; // Make sure this is never empty

    final ironSuppItem = prenatal.ironSuppItems.isNotEmpty
        ? prenatal.ironSuppItems.first
        : {'iron_supplement_no_tabs': '30'}; // Make sure this is never empty

    // Format services and advice content
    final serviceContent = prenatal.services.isNotEmpty ? prenatal.services.join(', ') : 'None';
    final adviceContent = prenatal.advices.isNotEmpty ? prenatal.advices.join(', ') : 'None';

    // Add the patient_information_id field that was missing
    final int patientInfoId = 1; // You may need to get this from somewhere

    // Prepare request payload
    final Map<String, dynamic> payload = {
      'philhealt': prenatal.philhealth,
      'nhts': prenatal.nhts,
      'lmp': prenatal.lastMenstrualPeriod.toString(),
      'ob_status': prenatal.obStatus.toString(),
      'edc': prenatal.expectedDateOfConfinement.toString(),
      'assigned_by': prenatal.assignedBy,
      'patient_information_accompany_by': prenatal.accompaniedBy,
      'patient_information_user_id': prenatal.laravelId, // Using default value as per controller

      // Ensure these values are never empty strings
      'immuniztion_term': ttItem['term'] ?? "NA",
      'iron_supplement_no_tabs': ironSuppItem['iron_supplement_no_tabs'] ?? "NA",

      'is_breast_feeding': prenatal.breastFeeding ? 1 : 0,
      'is_family_planning': prenatal.familyPlanning ? 1 : 0,
      'is_child_proper_nutrition': prenatal.properNutritionForChild ? 1 : 0,
      'is_self_proper_nutrition': prenatal.properNutritionForMyself ? 1 : 0,

      'full_name': prenatal.donorFullname,
      'contact_number': prenatal.donorContact,
      'blood_type': prenatal.donorBloodType,

      'clinic_visit_trimester': getIntegerTrimesterEnum(prenatal.selectedTrimester),
      'clinic_visit_consul_wht': prenatal.consultWht ? 1 : 0,
      'clinic_visit_wht_introduced_birth_plan': prenatal.introducedBirthPlan ? 1 : 0,
      'clinic_visit_fundic_heigh': prenatal.fundicHeight,

      'service_content': serviceContent,
      'advice_content': adviceContent,

      // Required fields from clinic_visit (duplicated as per API contract)
      'trimester': getIntegerTrimesterEnum(prenatal.selectedTrimester),
      'consul_wht': prenatal.consultWht ? 1 : 0,
      'wht_introduced_birth_plan': prenatal.introducedBirthPlan ? 1 : 0,
      'fundic_heigh': prenatal.fundicHeight,
      'patient_information_id': patientInfoId, // This was missing in your payload
    };

    log('Sending payload: ${jsonEncode(payload)}');

    try {
      // Make POST request
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        body: jsonEncode(payload),
      );

      // Check response
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
