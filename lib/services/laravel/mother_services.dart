import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';

Future<List<Person>> fetchAllMothers() async {
  final url = apiURIBase.replace(path: LaravelPaths.mothers);

  final res = await http.get(url);

  final List<dynamic> data = jsonDecode(res.body) as List<dynamic>;

  // log(data.toString());

  final List<Person> mothers = data
      .where((p) => p['user_id'] != null)
      .toList()
      .map((p) => Person.fromJsonStatic(p))
      .toList()
      .whereType<Person>()
      .toList();

  // for (var m in mothers) {
  //   log(m.toJson().toString());
  // }

  return mothers;
}
