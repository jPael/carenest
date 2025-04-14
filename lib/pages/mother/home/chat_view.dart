import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/chat/chat_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/services/chat_services.dart';
import 'package:smartguide_app/services/user_services.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  final ChatServices chatServices = ChatServices();

  final user = getCurrentUser;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8 * 2),
          child: StreamBuilder<Object>(
              stream: chatServices.getUsersStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 10 * 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          "Something went wrong... please try again",
                          style: TextStyle(
                              fontSize: 4 * 8, fontWeight: FontWeight.bold, color: Colors.red[900]),
                        )
                      ],
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 10 * 8.0),
                    child: Column(
                      spacing: 4 * 2,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        Text(
                          "Loading, please wait...",
                          style: TextStyle(fontSize: 4 * 4, fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  );
                }

                final items = [
                  ...(snapshot.data as List<Map<String, dynamic>>).map((d) {
                    if (d["email"] == user!.email) {
                      return null;
                    }
                    return ChatItem(
                      user: d,
                    );
                  })
                ];

                return CustomSection(
                    emptyChildrenContent: const Text("No Users available"),
                    childrenSpacing: 0,
                    children: items.where((child) => child != null).cast<Widget>().toList());
              })),
    );
  }
}
