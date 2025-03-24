import 'dart:convert';
import 'dart:developer';

import 'package:smartguide_app/error/app_error.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:http/http.dart' as http;
import 'package:smartguide_app/services/laravel/fields.dart';

Future<void> registerAccount(
    {required String name, required String email, required String password}) async {
  Map<String, String> body = {
    Registration.name: name,
    Registration.email: email,
    Registration.password: password,
    Registration.passwordConfirmation: password,
    Registration.barangayId: "1"
  };

  final url = apiURIBase.replace(path: LaravelPaths.register);

  final res = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body));

  final data = jsonDecode(res.body);
  log(res.body);

  final message = data[RegistrationResponseJsonProperties.message];

  if (data[RegistrationResponseJsonProperties.errors] != null) {
    throw Exception(message);
  }

  return;
}

Future<String> loginAccount({required String email, required String password}) async {
  final url = apiURIBase.replace(path: LaravelPaths.login);

  final res = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"email": email, "password": password}));

  final data = jsonDecode(res.body);

  if (data["error"] != null) {
    throw Exception(errorMessage(data["message"]));
  }

  return data["data"]["token"];
}
