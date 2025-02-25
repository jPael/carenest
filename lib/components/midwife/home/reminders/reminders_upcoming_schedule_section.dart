import 'package:flutter/material.dart';
import 'package:smartguide_app/components/midwife/home/reminders/reminders_card.dart';

class RemindersUpcomingScheduleSection extends StatelessWidget {
  const RemindersUpcomingScheduleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Upcoming schedules",
              style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            spacing: 8,
            children: [
              RemindersCard(
                title: "Prenatal Check-up",
                datetime: DateTime(2025, 3, 15, 9, 0),
                iconSrc: "lib/assets/images/reminders_card_prenatal_checkup_icon.png",
              ),
              RemindersCard(
                title: "Nutrition Seminar",
                datetime: DateTime(2025, 3, 22, 8, 0),
                iconSrc: "lib/assets/images/reminders_card_nutrition_seminar_icon.png",
              ),
              RemindersCard(
                title: "Vaccination drive",
                datetime: DateTime(2025, 4, 20, 10, 0),
                iconSrc: "lib/assets/images/reminders_card_vaccination_drive_icon.png",
              )
            ],
          ),
        )
      ],
    );
  }
}
