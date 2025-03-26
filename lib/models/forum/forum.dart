import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartguide_app/error/app_error.dart';
import 'package:smartguide_app/fields/forum/forum_fields.dart';
import 'package:smartguide_app/models/forum/author.dart';
import 'package:smartguide_app/models/forum/reply.dart';

class Forum {
  final String title;
  final String content;
  final String barangay;
  final String authorId;
  final String? docId;
  Timestamp? createdAt;
  Timestamp? updatedAt;
  Author? author;
  List<Reply>? replies;

  Forum(
      {required this.title,
      required this.content,
      required this.barangay,
      required this.authorId,
      this.createdAt,
      this.updatedAt,
      this.docId,
      this.author,
      this.replies});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Map<String, dynamic> toMap() => {
        ForumFields.title: title,
        ForumFields.content: content,
        ForumFields.barangay: barangay,
        ForumFields.updatedAt: updatedAt,
        ForumFields.createdAt: createdAt,
        ForumFields.authorId: authorId
      };

  Future<Map<String, dynamic>> post() async {
    try {
      createdAt = Timestamp.now();
      updatedAt = Timestamp.now();

      final user = await _firestore.collection("users").doc();

      await _firestore.collection("forums").add(toMap());
      return {"success": true};
    } catch (e, stackTrace) {
      log("There was an error: ${e.toString()}", stackTrace: stackTrace);
      return {"success": false, "message": errorMessage("Post unsuccessful")};
    }
  }
}
