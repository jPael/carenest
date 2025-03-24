import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Future<Map<String, dynamic>?> getUserByEmail(String email) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data(); // Return the user data as a Map
    } else {
      return null; // No user found
    }
  } catch (e) {
    if (kDebugMode) {
      print("Error fetching user data: $e");
    }
    return null;
  }
}

Future<Map<String, dynamic>?> getUserByUID(String uid) async {
  try {
    final user = await FirebaseFirestore.instance.collection("users").doc(uid).get();

    return user.data();
  } catch (e) {
    if (kDebugMode) {
      print("Error fetching user data: $e");
    }
    return null;
  }
}
