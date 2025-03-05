// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'message.dart';

class Chat extends Equatable {
  final String? id;
  final List<Message> messages;
  final int? userId;

  const Chat({
    this.id,
    required this.messages,
    this.userId,
  });

  @override
  List<Object?> get props => [id, messages, userId];

  Chat copyWith({
    String? id,
    List<Message>? messages,
    int? userId,
  }) {
    return Chat(
      id: id ?? this.id,
      messages: messages ?? this.messages,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'messages': messages.map((x) => x.toMap()).toList(),
      'userId': userId,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      id: map['id'] != null ? map['id'] as String : null,
      messages: List<Message>.from(
        (map['messages'] as List<int>).map<Message>(
          (x) => Message.fromMap(x as Map<String, dynamic>),
        ),
      ),
      userId: map['userId'] != null ? map['userId'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Chat.fromJson(String source) => Chat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
