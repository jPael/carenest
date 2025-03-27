import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartguide_app/fields/forum/forum_fields.dart';
import 'package:smartguide_app/fields/forum/reply_fields.dart';
import 'package:smartguide_app/fields/user_fields.dart';
import 'package:smartguide_app/models/forum/author.dart';
import 'package:smartguide_app/models/forum/forum.dart';
import 'package:smartguide_app/models/forum/reply.dart';

class ForumServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Forum>> getForumStream(String barangay) {
    try {
      return _firestore.collection("forums").snapshots().asyncMap((snapshot) async {
        // Filter and sort documents
        final docs = snapshot.docs.where((doc) => doc.data()['barangay'] == barangay).toList()
          ..sort((a, b) => (b['created_at'] as Timestamp).compareTo(a['created_at'] as Timestamp));

        // Convert documents to forums with author information
        final forums = await Future.wait(docs.map((forumDoc) async {
          final data = forumDoc.data();
          data[ForumFields.docId] = forumDoc.id; // Add document ID

          final int replyCount = await getReplyCountByForumId(forumDoc.id);

          // data['replies'] = replies;

          final authorId = data[ForumFields.authorId];
          final author = await getAuthorByAuthorId(authorId);

          final List<Map<String, dynamic>>? likes = await getLikesByForumId(forumDoc.id);

          return Forum(
              title: data[ForumFields.title],
              content: data[ForumFields.content],
              barangay: data[ForumFields.barangay],
              createdAt: data[ForumFields.createdAt],
              updatedAt: data[ForumFields.updatedAt],
              authorId: authorId,
              docId: forumDoc.id,
              author: author,
              replyCount: replyCount,
              likes: likes ?? []);
        }));

        return forums;
      });
    } catch (e, stackTrace) {
      log("There was an error fetching your forum: $e", stackTrace: stackTrace);
      throw Exception();
    }
  }

  Stream<Map<String, dynamic>> getLikeStreamByForumId(String forumId, String userId) {
    try {
      return _firestore
          .collection("forums")
          .doc(forumId)
          .collection("likes")
          .snapshots()
          .map((snapshot) {
        final count = snapshot.docs.length;
        final isLiked = snapshot.docs.any((doc) => doc.data()[LikeFields.userId] == userId);
        return {'count': count, 'isLiked': isLiked};
      });
    } catch (e, stackTrace) {
      log("There was an error on your like stream: $e", stackTrace: stackTrace);
      return Stream.value({"isLiked": false, "count": 0});
    }
  }

  Stream<List<Reply>> getReplyStreamByForumId(String forumId) {
    try {
      return _firestore
          .collection("forums")
          .doc(forumId)
          .collection("replies")
          .snapshots()
          .asyncMap((snapshot) async {
        final docs = snapshot.docs.toList()
          ..sort((a, b) => (b[ReplyFields.createdAt] as Timestamp)
              .compareTo(a[ReplyFields.createdAt] as Timestamp));

        final List<Reply> replies = await Future.wait(docs.map((replyDoc) async {
          final replyData = replyDoc.data();
          final String authorId = replyData[ReplyFields.authorId];
          final Author author = await getAuthorByAuthorId(authorId);

          return Reply(
              content: replyData[ReplyFields.content],
              forumId: forumId,
              authorId: authorId,
              author: author,
              createdAt: replyData[ReplyFields.createdAt],
              updatedAt: replyData[ReplyFields.updatedAt]);
        }));
        return replies;
      });
    } catch (e, stackTrace) {
      log("There was an error on your reply stream: $e", stackTrace: stackTrace);
      throw Exception();
    }
  }

  Future<void> postForum(Map<String, dynamic> json) async {
    await _firestore.collection("forums").add(json);
  }

  Future<void> likePost({
    required String forumId,
    required String userId,
  }) async {
    try {
      // Check if user already liked this post
      final existingLike = await _firestore
          .collection("forums")
          .doc(forumId)
          .collection("likes")
          .where(LikeFields.userId, isEqualTo: userId)
          .limit(1)
          .get();

      if (existingLike.docs.isEmpty) {
        // Add like
        await _firestore.collection("forums").doc(forumId).collection("likes").add({
          LikeFields.userId: userId,
          ForumFields.createdAt: FieldValue.serverTimestamp(),
        });
      } else {
        // Remove like
        await existingLike.docs.first.reference.delete();
      }
    } catch (e, stackTrace) {
      log('Error toggling like: $e', stackTrace: stackTrace);
      throw Exception('Failed to toggle like');
    }
  }

  Future<List<Map<String, dynamic>>?> getLikesByForumId(String forumId) async {
    try {
      final likesSnapshot =
          await _firestore.collection("forums").doc(forumId).collection("likes").get();

      if (likesSnapshot.docs.isEmpty) {
        return null;
      }

      return likesSnapshot.docs.map((doc) => doc.data()).toList();
    } catch (e, stackTrace) {
      log("There was an error fetching your forum likes: $e", stackTrace: stackTrace);
      return null;
    }
  }

  Future<Author> getAuthorByAuthorId(String authorId) async {
    final authorDoc = await _firestore.collection("users").doc(authorId).get();

    return Author(
        id: authorId,
        firstname: authorDoc[UserFields.firstname],
        lastname: authorDoc[UserFields.lastname],
        email: authorDoc[UserFields.email]);
  }

  Future<int> getReplyCountByForumId(String forumId) async {
    final repliesSnapshot =
        await _firestore.collection("forums").doc(forumId).collection("replies").get();
    return repliesSnapshot.docs.length;
  }
}
