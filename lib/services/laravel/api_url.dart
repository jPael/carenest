import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // For kReleaseMode

Uri get apiURIBase {
  if (kReleaseMode) {
    return Uri(scheme: "https", host: dotenv.env['REMOTE_BACKEND_API']!);
  } else {
    return Uri(
      scheme: "https",
      host: dotenv.env['REMOTE_BACKEND_API']!,
      // scheme: "http",
      // host: dotenv.env['LOCAL_BACKEND_API']!,
      // port: int.parse(dotenv.env['LOCAL_BACKEND_PORT']!)
    );
  }
}

class LaravelPaths {
  static String get _baseUrl => "/api/v1";

  static String register = "$_baseUrl/register";
  static String login = "$_baseUrl/login";
  static String logout = "$_baseUrl/logout";
  static String user = "$_baseUrl/user";
  static String patientInformation = "$_baseUrl/user/patient-information";
  static String barangay = "$_baseUrl/barangays";
  static String createMotherPatientInformation = "$_baseUrl/mothers-prenatals-records";
  static String createMotherPrenatalRecord = "$_baseUrl/midwife-prenatals-records";
  static String allPrenatal = "$_baseUrl/prenatals";
  static String prenatal = "$_baseUrl/prenatal";
  static String reminder = "$_baseUrl/reminder";
  static String allReminders = "$_baseUrl/reminders";
  static String reminderMarkAsDone = "$_baseUrl/reminder/mark-as-done";
  static String midwife = "$_baseUrl/midwife";
  static String mothers = "$_baseUrl/mothers";
  static String getAllClinicVisits = '$_baseUrl/clinic-visits';

  static String firstTrimesterCreateClinicVisit =
      "$_baseUrl/clinic-visit/first-trimester/visit/create";
  static String secondTrimesterCreateClinicVisit =
      "$_baseUrl/clinic-visit/second-trimester/visit/create";
  static String thirdTrimesterCreateClinicVisit =
      "$_baseUrl/clinic-visit/third-trimester/visit/create";
  static String createClinicHistory = "$_baseUrl/clinic-history/create";
  static String childCareTips = "$_baseUrl/child-care-tips";

  static String getClinicVisitsById(int i) => '$_baseUrl/clinic-visits/$i';
  static String specificReminder(int i) => "$_baseUrl/reminder/$i";
  static String allReminderByMidwifeId(int i) => "$_baseUrl/reminder/midwife/$i";
  static String motherPatientInformationById(int i) =>
      "$_baseUrl/mothers-prenatals-records/$i/show";
  static String updateMotherPatientInformationById(int id) =>
      "$_baseUrl/mothers-prenatals-records/$id";
}
