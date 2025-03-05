import 'package:equatable/equatable.dart';

import 'message.dart';

class Chat extends Equatable {
  final String? id;
  final List<Message> messages;
  final int userId;

  const Chat({
    this.id,
    required this.messages,
    required this.userId,
  });

  @override
  List<Object?> get props => [id, messages, userId];
}