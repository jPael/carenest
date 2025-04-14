import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:smartguide_app/models/midwife.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';

class MidwifeServices {
  Future<List<Midwife>> fetchAllMidwife() async {
    final apiUrl = apiURIBase.replace(path: LaravelPaths.midwife);
    log(apiUrl.toString());

    final res = await http.get(apiUrl);

    final data = jsonDecode(res.body) as List<dynamic>;

    if (kDebugMode) {
      print(data);
    }

    final List<Midwife> midwife = data.map((d) {
      final Midwife m = Midwife();
      m.fromJson(d);
      return m;
    }).toList();

    return midwife;
  }
}
