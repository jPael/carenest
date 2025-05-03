import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/services/laravel/fields.dart';

class Person {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? address;
  DateTime? birthday;

  Person({this.id, this.name, this.phone, this.email, this.address, this.birthday});

  void fromJson(Map<String, dynamic> json) {
    id = json[LaravelUserFields.id];
    name = json[LaravelUserFields.name];
    phone = json[UserFields.phoneNumber];
    email = json[UserFields.email];
    address = json[UserFields.address];
  }

  static Person? fromJsonStatic(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Person(
      id: json[LaravelUserFields.id],
      name: json[LaravelUserFields.name],
      phone: json[UserFields.phoneNumber],
      email: json[UserFields.email],
      address: json[UserFields.address],
    );
  }

  Map<String, dynamic> toJson() => {
        LaravelUserFields.id: id,
        LaravelUserFields.name: name,
        UserFields.phoneNumber: phone,
        UserFields.email: email,
        UserFields.address: address,
      };
}
