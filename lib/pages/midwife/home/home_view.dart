import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/card_button.dart';
import 'package:smartguide_app/pages/midwife/add_reminders/add_reminders_page.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/prenatal_records_list_page.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final Map<String, String> images = {
    "prenatal_records": "lib/assets/images/midwife_home_prenatal_records_icon.png",
    "add_reminders": "lib/assets/images/midwife_home_add_reminders_icon.png",
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
                    // "lib/assets/images/midwife_home_prenatal_records_icon.png",
                    images['prenatal_records']!,
                    fit: BoxFit.fill,
                    height: 270,
                    width: cardWidth,
                  ),
                  label: "Prenatal Records",
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PrenatalRecordsListPage()))),
              CardButton(
                  height: cardHeight,
                  width: cardWidth,
                  content: Image.asset(
                    // "lib/assets/images/midwife_home_add_reminders_icon.png",
                    images['add_reminders']!,
                    fit: BoxFit.fill,
                    height: 270,
                    width: cardWidth,
                  ),
                  label: "Add Reminders",
                  onPressed: () => Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const AddRemindersPage()))),
            ],
          ),
        ],
      ),
    );
  }
}
