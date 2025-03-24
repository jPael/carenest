import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/fields/barangay_fields.dart';
import 'package:smartguide_app/models/barangay.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';

class BarangayServices {
  Future<List<Barangay>> fetchALlBarangays() async {
    final url = apiURIBase.replace(path: LaravelPaths.barangay);

    final res = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );

    final json = jsonDecode(res.body) as List<dynamic>;

    final List<Barangay> barangays = json
        .map((b) => Barangay(
            id: b[BarangayFields.id].toString(),
            name: b[BarangayFields.name],
            address: b[BarangayFields.address],
            createdAt: DateTime.tryParse(b[BarangayFields.createdAt])!,
            updatedAt: DateTime.tryParse(b[BarangayFields.updatedAt])!))
        .toList();

    return barangays;
  }
}
