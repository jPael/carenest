import 'package:flutter/material.dart';
import 'package:smartguide_app/components/midwife/chat/chat_conversation_input_field.dart';
import 'package:smartguide_app/components/midwife/chat/chat_conversation_section.dart';
import 'package:smartguide_app/components/midwife/chat/chat_message_app_bar.dart';
import 'package:smartguide_app/components/midwife/chat/chat_user_details_section.dart';

class ChatMessageView extends StatefulWidget {
  const ChatMessageView({super.key});

  @override
  State<ChatMessageView> createState() => _ChatMessageViewState();
}

class _ChatMessageViewState extends State<ChatMessageView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        "lib/assets/images/midwife_chat_bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        appBar: ChatMessageAppBar(),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    ChatUserDetailsSection(),
                    ChatConversationSection(),
                  ],
                ),
              ),
            ),
            ChatConversationInputField()
          ],
        ),
      ),
    ]);
  }
}
