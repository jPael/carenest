import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:smartguide_app/models/revamp/child_care_tips.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';

Future<List<ChildCareTips>> fetchAllChildCareTips() async {
  final url = apiURIBase.replace(path: LaravelPaths.childCareTips);

  final res = await http.get(url);

  if (res.statusCode == 200) {
    final responseData = jsonDecode(res.body) as Map<String, dynamic>;
    final List<dynamic> dataList = responseData['data'] ?? [];

    return dataList
        .map<ChildCareTips>((c) => ChildCareTips.fromJson(c as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Failed to load child care tips');
  }
}
