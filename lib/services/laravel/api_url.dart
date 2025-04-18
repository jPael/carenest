Uri get apiURIBase => Uri(scheme: "http", host: "192.168.254.105", port: 8000);

class LaravelPaths {
  static const String register = "/api/v1/register";
  static const String login = "/api/v1/login";
  static const String logout = "/api/v1/logout";
  static const String user = "/api/v1/user";
  static const String barangay = "/api/v1/barangays";
  static const String prenatal = "/api/v1/prenatal";
  static const String allPrenatal = "/api/v1/prenatals";
  static const String midwife = "/api/v1/midwife";
  static const String reminder = "/api/v1/reminder";
  static const String allReminders = "/api/v1/reminders";

  static String specificReminder(int i) => "/api/v1/reminder/$i";
}
