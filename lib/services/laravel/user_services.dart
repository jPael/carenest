import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/error/app_error.dart';
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/new_user.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:smartguide_app/services/laravel/fields.dart';
import 'package:smartguide_app/utils/utils.dart';

Future<void> registerAccount(
    {required String name,
    required String email,
    required String password,
    required UserType type}) async {
  Map<String, dynamic> body = {
    RegistrationFields.name: name,
    RegistrationFields.email: email,
    RegistrationFields.password: password,
    RegistrationFields.passwordConfirmation: password,
    RegistrationFields.barangayId: "1",
    RegistrationFields.userType: getIntegerFromUserTypeEnum(type),
  };

  final url = apiURIBase.replace(path: LaravelPaths.register);

  final res = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body));

  final data = jsonDecode(res.body);

  final message = data[RegistrationResponseJsonProperties.message];

  if (data[RegistrationResponseJsonProperties.errors] != null) {
    throw Exception(message);
  }

  return;
}

Future<Map<String, dynamic>> loginAccount({required String email, required String password}) async {
  final url = apiURIBase.replace(path: LaravelPaths.login);

  final res = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}));

  final data = jsonDecode(res.body);

  if (data["error"] != null) {
    throw Exception(errorMessage(data["message"]));
  }

  return {
    UserFields.token: data["data"]["token"],
    UserFields.laravelId: data["data"]["user"]["id"],
  };
}
