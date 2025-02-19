import 'package:flutter/material.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/components/home/card_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0 * 2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CardButton(
                  content: Image.asset(
                    "lib/assets/images/midwife_home_tips_icon.png",
                    fit: BoxFit.fill,
                    height: 270,
                    width: 180,
                  ),
                  label: "Childcare tips",
                  onPressed: () {}),
              CardButton(
                  content: Image.asset(
                    "lib/assets/images/midwife_home_chatbot_icon.png",
                    fit: BoxFit.fill,
                    height: 270,
                    width: 180,
                  ),
                  label: "Chatbot",
                  onPressed: () {}),
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
                    "lib/assets/images/midwife_home_reminders_icon.png",
                    fit: BoxFit.fill,
                    height: 270,
                    width: 180,
                  ),
                  label: "Reminders",
                  onPressed: () {}),
              CardButton(
                  content: Image.asset(
                    "lib/assets/images/midwife_home_forum_icon.png",
                    fit: BoxFit.fill,
                    height: 270,
                    width: 190,
                  ),
                  label: "Forum",
                  onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
