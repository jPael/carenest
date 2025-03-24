import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartguide_app/fields/message_fields.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      MessageFields.senderId: senderId,
      MessageFields.senderEmail: senderEmail,
      MessageFields.message: message,
      MessageFields.receiverId: receiverId,
      MessageFields.timestamp: timestamp
    };
  }
}
