import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/services/laravel/user_services.dart';
import 'package:smartguide_app/utils/utils.dart';

class NewUser {
  final UserType type;
  final String firstname;
  final String lastname;
  final String address;
  final String phoneNumber;
  final DateTime dateOfBirth;
  final String email;
  final String password;

  NewUser({
    required this.type,
    required this.firstname,
    required this.lastname,
    required this.address,
    required this.phoneNumber,
    required this.dateOfBirth,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> getUserDetails() => {
        UserFields.email: email,
        UserFields.firstname: firstname,
        UserFields.lastname: lastname,
        UserFields.address: address,
        UserFields.phoneNumber: phoneNumber,
        UserFields.dateOfBirth: dateOfBirth.toString(),
        UserFields.userType: getUserStringFromUserTyeEnum(type),
        UserFields.laravelPassword: password,
      };

  Future<Map<String, String>> createAccount() async {
    try {
      final user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final String uid = user.user!.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .set({UserFields.uid: uid, ...getUserDetails()});

      await registerAccount(name: "$firstname $lastname", email: email, password: password);

      return {"success": "Registered successfully! Continue logging in with your new account"};
    } on FirebaseException catch (e, stackTrace) {
      if (kDebugMode) {
        print(e.code);
        print(stackTrace);
      }
      return {"error": e.code};
    } on Exception catch (e, stackTrace) {
      if (kDebugMode) {
        print(e);
        print("on exception: $stackTrace");
      }
      return {"error": e.toString()};
    }
  }

  @override
  String toString() {
    return 'User(type: $type, firstname: $firstname, lastname: $lastname, address: $address, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, email: $email, password: $password)';
  }
}

enum UserType { mother, midwife }
