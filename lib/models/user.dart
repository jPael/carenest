import 'package:flutter/material.dart';
import 'package:smartguide_app/fields/user_fields.dart';

class User extends ChangeNotifier {
  String? firstname;
  String? lastname;
  String? type;
  String? address;
  String? phoneNumber;
  String? dateOfBirth;
  String? email;

  Map<String, String> get getUser => {
        UserFields.firstname: firstname!,
        UserFields.lastname: lastname!,
        UserFields.address: address!,
        UserFields.phoneNumber: phoneNumber!,
        UserFields.dateOfBirth: dateOfBirth!,
        UserFields.email: email!,
      };

  void setUser(json) {
    firstname = json[UserFields.firstname];
    lastname = json[UserFields.lastname];
    address = json[UserFields.address];
    phoneNumber = json[UserFields.phoneNumber];
    dateOfBirth = json[UserFields.dateOfBirth];
    email = json[UserFields.email];

    notifyListeners();
  }
}
