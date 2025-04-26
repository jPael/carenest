import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/card_button.dart';
import 'package:smartguide_app/pages/midwife/add_reminders/add_reminders_page.dart';
import 'package:smartguide_app/pages/midwife/prenatal_records/prenatal_records_list_page.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
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
                  content: Image.asset(
                    "lib/assets/images/midwife_home_prenatal_records_icon.png",
                    fit: BoxFit.fill,
                    height: 270,
                    width: cardWidth,
                  ),
                  label: "Prenatal Records",
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const PrenatalRecordsListPage()))),
              CardButton(
                  content: Image.asset(
                    "lib/assets/images/midwife_home_add_reminders_icon.png",
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
