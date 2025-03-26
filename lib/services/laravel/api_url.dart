Uri get apiURIBase => Uri(scheme: "http", host: "192.168.113.83", port: 8000);

class LaravelPaths {
  static String get register => "/api/v1/register";
  static String get login => "/api/v1/login";
  static String get barangay => "/api/v1/barangays";
}
