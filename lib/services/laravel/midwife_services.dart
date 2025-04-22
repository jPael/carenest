import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';

class MidwifeServices {
  Future<List<Person>> fetchAllMidwife() async {
    final apiUrl = apiURIBase.replace(path: LaravelPaths.midwife);
    log(apiUrl.toString());

    final res = await http.get(apiUrl);

    final data = jsonDecode(res.body) as List<dynamic>;

    if (kDebugMode) {
      print(data);
    }

    final List<Person> midwife = data.map((d) {
      final Person m = Person();
      m.fromJson(d);
      return m;
    }).toList();

    return midwife;
  }
}
