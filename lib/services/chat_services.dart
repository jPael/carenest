import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartguide_app/models/message.dart';
import 'package:smartguide_app/services/user_services.dart';

class ChatServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream({required String address}) {
    return _firestore
        .collection("users")
        .where('address', isEqualTo: address)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  Future<void> sendMessage(String receiverId, String message) async {
    final String userId = getCurrentUser!.uid;
    final String userEmail = getCurrentUser!.email!;

    final Timestamp timestamp = Timestamp.now();

    final Message newMessage = Message(
        message: message,
        receiverId: receiverId,
        senderId: userId,
        senderEmail: userEmail,
        timestamp: timestamp);

    List<String> ids = [userId, receiverId];
    ids.sort();
    String chatroomId = ids.join("-");

    await _firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];

    ids.sort();
    String chatroomId = ids.join('-');

    return _firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
