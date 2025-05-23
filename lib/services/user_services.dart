import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/services/laravel/user_services.dart';

User? get getCurrentUser => FirebaseAuth.instance.currentUser;

Future<Map<String, dynamic>?> getUserByEmail(String email) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .limit(1)
        .get();

    final data = querySnapshot.docs.first.data();

    if (querySnapshot.docs.isNotEmpty) {
      return data; // Return the user data as a Map
    } else {
      return null; // No user found
    }
  } catch (e, stackTrace) {
    if (kDebugMode) {
      print("Error fetching user data: $e");
      print(stackTrace);
    }
    return null;
  }
}

Future<Map<String, dynamic>?> getUserByUID(String uid) async {
  try {
    final user = await FirebaseFirestore.instance.collection("users").doc(uid).get();

    final data = user.data();

    Map<String, dynamic> laravelData = await loginAccount(
        email: data![UserFields.email], password: data[UserFields.laravelPassword]);

    // log("from user service: " + laravelData.toString());

    return {
      ...data,
      UserFields.isVerified: laravelData[UserFields.isVerified],
      UserFields.token: laravelData[UserFields.token],
      UserFields.uid: uid,
      UserFields.laravelId: laravelData[UserFields.laravelId]
    };
  } catch (e, stackTrace) {
    if (kDebugMode) {
      print("Error fetching user data: $e");
      print(stackTrace);
    }
    return null;
  }
}

Future<Person?> getUserByLaravelId({required int laravelId}) async {
  try {
    final query = await FirebaseFirestore.instance
        .collection("users")
        .where('laravelId', isEqualTo: laravelId)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) {
      final Map<String, dynamic> data = query.docs.first.data();

      return Person(
          name: "${data[UserFields.firstname]} ${data[UserFields.lastname]}",
          address: data[UserFields.address],
          email: data[UserFields.email],
          phone: data[UserFields.phoneNumber],
          birthday: DateTime.parse(data[UserFields.dateOfBirth]).toLocal());
    }
    return null;
  } catch (e, stackTrace) {
    if (kDebugMode) {
      print("Error fetching user data: $e");
      print(stackTrace);
    }
    return null;
  }
}
