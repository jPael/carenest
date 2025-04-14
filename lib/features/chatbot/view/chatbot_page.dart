import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:smartguide_app/features/chatbot/chatbot.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => ChatRepository(httpClient: http.Client()),
      child: BlocProvider(
        create: (context) => ChatBloc(
          chatRepository: context.read<ChatRepository>(),
        ),
        child: const ChatPage(),
      ),
    );
  }
}
