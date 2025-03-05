import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:smartguide_app/features/chatbot/chatbot.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc({
    required this.chatRepository,
  }) : super(ChatInitial()) {
    on<ChatMessageSent>(_onChatMessageSent);
  }

  Future<void> _onChatMessageSent(ChatMessageSent event, Emitter<ChatState> emit) async {
    final Chat initialChat = (Chat(messages: [
      Message(
          role: 'system',
          content:
              'Ikaw ay MOMI AI, isang chat assistant na tumutulong sa mga buntis o hindi buntis na babae na makakuha ng impormasyon tungkol sa pagbubuntis at pag-aalaga ng sanggol. Maaari ka lamang magsalita/mag-reply sa Tagalog.'),
    ]));

    try {
      final currentChat = state is ChatSuccess ? (state as ChatSuccess).chat : initialChat;

      final updatedChat = currentChat.copyWith(
        messages: [
          ...currentChat.messages,
          Message(role: 'user', content: event.message),
        ],
      );

      emit(ChatSuccess(updatedChat));

      emit(ChatLoading());

      final botReply = await chatRepository.sendMessage(updatedChat.messages, dotenv.env['OPENAI_API_KEY']!);

      updatedChat.messages.add(Message(role: 'assistant', content: botReply));

      emit(ChatSuccess(updatedChat));
    } catch (error) {
      emit(ChatError(error.toString()));
    }
  }
}
