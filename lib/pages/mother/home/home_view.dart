import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/card_button.dart';
import 'package:smartguide_app/pages/mother/chatbot/chatbot_page.dart';
import 'package:smartguide_app/pages/mother/childcare_tips/childcare_tips_page.dart';
import 'package:smartguide_app/pages/mother/forum/forum_page.dart';
import 'package:smartguide_app/pages/mother/reminders/reminders_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0 * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButton(
                  content: Image.asset(
                    "lib/assets/images/mother_home_tips_icon.png",
                    fit: BoxFit.fill,
                    height: 270,
                    width: 180,
                  ),
                  label: "Childcare tips",
                  notifCount: 3,
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChildcareTipsPage(
                                label: "Childcare tips",
                              )))),
              CardButton(
                  content: Image.asset(
                    "lib/assets/images/mother_home_chatbot_icon.png",
                    fit: BoxFit.fill,
                    height: 270,
                    width: 180,
                  ),
                  label: "Chatbot",
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ChatbotPage(label: "Chatbot")))),
            ],
          ),
          const SizedBox(
            height: 8 * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButton(
                  content: Image.asset(
                    "lib/assets/images/mother_home_reminders_icon.png",
                    fit: BoxFit.fill,
                    height: 270,
                    width: 180,
                  ),
                  notifCount: 3,
                  label: "Reminders",
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RemindersPage(label: "Reminders")))),
              CardButton(
                  content: Image.asset(
                    "lib/assets/images/mother_home_forum_icon.png",
                    fit: BoxFit.fill,
                    height: 270,
                    width: 190,
                  ),
                  notifCount: 4,
                  label: "Forum",
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => ForumPage(label: "Forum")))),
            ],
          )
        ],
      ),
    );
  }
}
