import 'dart:developer';

import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/barangay.dart';
import 'package:smartguide_app/services/laravel/fields.dart';

class Person {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? address;
  DateTime? birthday;
  Barangay? barangay;

  Person({this.id, this.name, this.phone, this.email, this.address, this.birthday, this.barangay});

  void fromJson(Map<String, dynamic> json) {
    id = json[LaravelUserFields.id];
    name = json[LaravelUserFields.name];
    phone = json[UserFields.phoneNumber];
    email = json[UserFields.email];
    address = json[UserFields.address];
    barangay = Barangay.fromJson(json['barangay']);
  }

  static Person? fromJsonStatic(Map<String, dynamic>? json) {
    // log(json.toString());
    // log("Person:::id ${json?[LaravelUserFields.id]} |  ${json?['date_of_birth '].toString()}");
    if (json == null) return null;

    return Person(
        id: json[LaravelUserFields.id],
        name: json[LaravelUserFields.name],
        phone: json[UserFields.phoneNumber],
        email: json[UserFields.email],
        address: json[UserFields.address],
        birthday: json['date_of_birth'],
        barangay: json['barangay'] == null ? null : Barangay.fromJson(json['barangay']));
  }

  Map<String, dynamic> toJson() => {
        LaravelUserFields.id: id,
        LaravelUserFields.name: name,
        UserFields.phoneNumber: phone,
        UserFields.email: email,
        UserFields.address: address,
      };
}
