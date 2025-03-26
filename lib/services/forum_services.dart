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
    return _firestore.collection("forums").snapshots().asyncMap((snapshot) async {
      // Filter and sort documents
      final docs = snapshot.docs.where((doc) => doc.data()['barangay'] == barangay).toList()
        ..sort((a, b) => (b['created_at'] as Timestamp).compareTo(a['created_at'] as Timestamp));

      // Convert documents to forums with author information
      final forums = await Future.wait(docs.map((forumDoc) async {
        final data = forumDoc.data();
        data[ForumFields.docId] = forumDoc.id; // Add document ID

        final List<Reply> replies = await getRepliesByForumId(forumDoc.id);

        data['replies'] = replies;

        final authorId = data[ForumFields.authorId];
        final author = await getForumAuthorByForumId(authorId);

        return Forum(
            title: data[ForumFields.title],
            content: data[ForumFields.content],
            barangay: data[ForumFields.barangay],
            createdAt: data[ForumFields.createdAt],
            updatedAt: data[ForumFields.updatedAt],
            authorId: authorId,
            docId: forumDoc.id,
            author: author,
            replies: replies);
      }));

      return forums;
    });
  }

  Future<Author> getForumAuthorByForumId(String authorId) async {
    final authorDoc = await _firestore.collection("users").doc(authorId).get();

    return Author(
        id: authorId,
        firstname: authorDoc[UserFields.firstname],
        lastname: authorDoc[UserFields.lastname],
        email: authorDoc[UserFields.email]);
  }

  Future<List<Reply>> getRepliesByForumId(String forumId) async {
    final repliesSnapshot =
        await _firestore.collection("forums").doc(forumId).collection("replies").get();

    final List<Reply> replies = await Future.wait(repliesSnapshot.docs.map((replyDoc) async {
      final replyData = replyDoc.data();

      final replyAuthorId = replyData[ReplyFields.authorId];
      final replyAuthorDoc = await _firestore.collection("users").doc(replyAuthorId).get();

      final replyAuthor = Author(
          id: replyAuthorId,
          firstname: replyAuthorDoc[UserFields.firstname],
          lastname: replyAuthorDoc[UserFields.lastname],
          email: replyAuthorDoc[UserFields.email]);

      return Reply(
          content: replyData[ReplyFields.content],
          authorId: replyData[ReplyFields.content],
          author: replyAuthor,
          forumId: forumId);
    }).toList());

    return replies;
  }
}
