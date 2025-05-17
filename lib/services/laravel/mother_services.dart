import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/models/barangay.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:smartguide_app/services/laravel/barangay_services.dart';

Future<List<Person>> fetchAllMothers({String? barangay}) async {
  final url = apiURIBase.replace(path: LaravelPaths.mothers);

  final res = await http.get(url);

  final List<dynamic> data = jsonDecode(res.body) as List<dynamic>;

  final List<Person> mothers = data
      .where((p) => p['user_id'] != null)
      .toList()
      .map((p) => Person.fromJsonStatic(p))
      .toList()
      .whereType<Person>()
      .toList();

  if (barangay != null) {
    final List<Barangay> b = await BarangayServices().fetchALlBarangays();

    final Barangay cur = b.firstWhere((a) => a.name == barangay);

    return mothers.where((m) => int.parse(cur.id) == m.barangayId!).toList();
  }

  // for (var m in mothers) {
  //   log(m.toJson().toString());
  // }

  return mothers;
}
