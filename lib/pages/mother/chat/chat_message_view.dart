import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/chat/chat_conversation_input_field.dart';
import 'package:smartguide_app/components/mother/chat/chat_conversation_section.dart';
import 'package:smartguide_app/components/mother/chat/chat_message_app_bar.dart';
import 'package:smartguide_app/components/mother/chat/chat_user_details_section.dart';
import 'package:smartguide_app/fields/user_fields.dart';

class ChatMessageView extends StatefulWidget {
  const ChatMessageView({super.key, required this.receiver});

  final Map<String, dynamic> receiver;

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
    precacheImage(const AssetImage("lib/assets/images/mother_chat_bg.png"), context);

    return Stack(children: [
      Image.asset(
        "lib/assets/images/mother_chat_bg.png",
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        appBar: ChatMessageAppBar(
            name:
                "${widget.receiver[UserFields.firstname]} ${widget.receiver[UserFields.lastname]}",
            email: widget.receiver[UserFields.email]),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  children: [
                    ChatUserDetailsSection(
                        name:
                            "${widget.receiver[UserFields.firstname]} ${widget.receiver[UserFields.lastname]}",
                        address: widget.receiver[UserFields.address],
                        type: widget.receiver[UserFields.userType],
                        email: widget.receiver[UserFields.email]),
                    ChatConversationSection(
                        receiverEmail: widget.receiver[UserFields.email],
                        receiverId: widget.receiver[UserFields.uid]),
                  ],
                ),
              ),
            ),
            ChatConversationInputField(
              receiverId: widget.receiver[UserFields.uid],
              receiverEmail: widget.receiver[UserFields.email],
            )
          ],
        ),
      ),
    ]);
  }
}
