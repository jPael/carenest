import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/services/laravel/fields.dart';

class Midwife {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? address;

  Midwife({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
  });

  void fromJson(Map<String, dynamic> json) {
    id = json[LaravelUserFields.id];
    name = json[LaravelUserFields.name];
    phone = json[UserFields.phoneNumber];
    email = json[UserFields.email];
    address = json[UserFields.address];
  }
}
