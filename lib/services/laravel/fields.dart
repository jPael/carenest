class RegistrationFields {
  static const String name = "name";
  static const String email = "email";
  static const String password = "password";
  static const String passwordConfirmation = "password_confirmation";
  static const String barangayId = "barangay_id";
  static const String userType = "role_id";
}

class RegistrationResponseJsonProperties {
  static String get message => "message";
  static String get errors => "errors";
}

class LaravelUserFields {
  static String get id => "id";
  static String get name => "name";
  static String get phoneNumber => "phone";
  static String get email => "email";
  static String get address => "barangay_id";
  static String get dateOfBirth => "date_of_birth";
  static String get password => "password";
  static String get token => "token";
  static String get roleId => "role_id";
  static String get roleName => "role_name";
  static String get userId => "user_id";
  static String get barangayId => "barangay_id";
  static String get createdAt => "created_at";
  static String get updatedAt => "updated_at";
}
