import 'package:flutter/material.dart';
import 'package:smartguide_app/constants/app_constants.dart';
import 'package:smartguide_app/features/chatbot/widgets/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartguide_app/features/chatbot/blocs/chat_bloc.dart';
import 'package:smartguide_app/features/chatbot/models/models.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> _messages = [];
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: Colors.white,
        title: Text(
          AppConstants.chatbotName,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocListener<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state is ChatError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else if (state is ChatSuccess) {
                  setState(() {
                    _messages = state.chat.messages;
                    _isLoading = false;
                  });
                } else if (state is ChatLoading) {
                  setState(() {
                    _isLoading = true;
                  });
                }
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: _messages.length + (_isLoading ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return BotLoading();
                  }
                  final message = _messages[index];
                  if (message.role == 'user') {
                    return UserMessage(message: message.content);
                  } else if (message.role == 'assistant') {
                    return BotMessage(message: message.content);
                  }
                  return SizedBox();
                },
              ),
            ),
          ),
          ChatInputField(
            onSendMessage: (String message) {
              context.read<ChatBloc>().add(ChatMessageSent(message));
            },
          ),
        ],
      ),
    );
  }
}
