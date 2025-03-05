import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartguide_app/features/chatbot/bloc/chat_bloc.dart';
import 'package:smartguide_app/features/chatbot/view/chatbot_intro.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),
      child: ChatbotIntro(),
    );
  }
}
