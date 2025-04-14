import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthServices {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final userDoc = await firestore.collection("users").doc(userCredential.user!.uid).get();

        if (!userDoc.exists) {
          await auth.signOut();
          return {"status": false, "message": "User not found"};
        }

        // final userData = userDoc.data()!;
        // final userDataType = userData[UserFields.userType];

        // if (userType != getUserEnumFromUserTypeString(userDataType)) {
        //   await auth.signOut();
        //   return {"status": false, "message": "User not found"};
        // }

        return {"status": true};
      } else {
        throw Exception("User not found");
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Sign-in error: ${e.code} - ${e.message}");
      }

      return {"status": false, "message": e.code};
    } catch (e) {
      if (kDebugMode) {
        print("Unexpected error: $e");
      }

      return {"status": false, "message": "An unexpected error occurred"};
    }
  }
}
