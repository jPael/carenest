Uri get apiURIBase => Uri(scheme: "http", host: "192.168.254.191", port: 8000);

class LaravelPaths {
  static String get register => "/api/v1/register";
  static String get login => "/api/v1/login";
  static String get barangay => "/api/v1/barangays";
  static String get prenatal => "/api/v1/prenatal";
  static String get midwife => "/api/v1/midwife";
}
