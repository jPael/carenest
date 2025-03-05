import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String role;
  final String content;

  const Message({
    required this.role,
    required this.content,
  });

  @override
  List<Object?> get props => [role, content];
}