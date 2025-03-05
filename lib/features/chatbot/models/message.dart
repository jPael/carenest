// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String role;
  final String content;

  const Message({
    required this.role,
    required this.content,
  });

  @override
  List<Object> get props => [role, content];

  Message copyWith({
    String? role,
    String? content,
  }) {
    return Message(
      role: role ?? this.role,
      content: content ?? this.content,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'content': content,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      role: map['role'] as String,
      content: map['content'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
