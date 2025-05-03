import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/card_button.dart';
import 'package:smartguide_app/features/chatbot/chatbot.dart';
import 'package:smartguide_app/pages/mother/childcare_tips/childcare_tips_page.dart';
import 'package:smartguide_app/pages/mother/forum/forum_page.dart';
import 'package:smartguide_app/pages/mother/reminders/reminders_page.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final Map<String, String> images = {
    "childcare_tips": "lib/assets/images/mother_home_tips_icon.png",
    "chatbot": "lib/assets/images/mother_home_chatbot_icon.png",
    "reminders": "lib/assets/images/mother_home_reminders_icon.png",
    "forum": "lib/assets/images/mother_home_forum_icon.png"
  };

  @override
  Widget build(BuildContext context) {
    images.forEach((key, value) => precacheImage(AssetImage(value), context));

    final double cardHeight = (MediaQuery.of(context).size.height / 2) * (1 - 0.36);

    final double cardWidth = (MediaQuery.of(context).size.width / 2) * 0.9;

    return Padding(
      padding: const EdgeInsets.all(8.0 * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButton(
                  height: cardHeight,
                  width: cardWidth,
                  content: Image.asset(
                    images["childcare_tips"]!,
                    fit: BoxFit.fill,
                    height: cardHeight,
                    width: cardWidth,
                  ),
                  label: "Childcare tips",
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChildcareTipsPage(
                                label: "Childcare tips",
                              )))),
              CardButton(
                  height: cardHeight,
                  width: cardWidth,
                  content: Image.asset(
                    images["chatbot"]!,
                    fit: BoxFit.fill,
                    height: cardHeight,
                    width: cardWidth,
                  ),
                  label: "Chatbot",
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const ChatbotIntro()))),
            ],
          ),
          const SizedBox(
            height: 8 * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButton(
                  height: cardHeight,
                  width: cardWidth,
                  content: Image.asset(
                    images["reminders"]!,
                    fit: BoxFit.fill,
                    height: cardHeight,
                    width: cardWidth,
                  ),
                  label: "Reminders",
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RemindersPage(label: "Reminders")))),
              CardButton(
                  height: cardHeight,
                  width: cardWidth,
                  content: Image.asset(
                    images["forum"]!,
                    fit: BoxFit.fill,
                    height: cardHeight,
                    width: 190,
                  ),
                  label: "Forum",
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const ForumPage(label: "Forum")))),
            ],
          )
        ],
      ),
    );
  }
}
