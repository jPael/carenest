import 'dart:developer';

class Barangay {
  final String id;
  final String name;
  final String address;
  final DateTime createdAt;
  final DateTime updatedAt;

  Barangay(
      {required this.id,
      required this.name,
      required this.address,
      required this.createdAt,
      required this.updatedAt});

  static Barangay fromJson(Map<String, dynamic> json) {
    return Barangay(
        id: json["id"].toString(),
        name: json["name"],
        address: json["address"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]));
  }
}
