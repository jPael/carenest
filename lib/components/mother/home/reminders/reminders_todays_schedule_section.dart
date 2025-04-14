import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_schedule_item.dart';

class RemindersTodaysScheduleSection extends StatefulWidget {
  const RemindersTodaysScheduleSection({super.key});

  @override
  RemindersTodaysScheduleSectionState createState() => RemindersTodaysScheduleSectionState();
}

class RemindersTodaysScheduleSectionState extends State<RemindersTodaysScheduleSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Text(
              "Today’s Schedule",
              style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          spacing: 8 * 2,
          children: [
            RemindersScheduleItem(
              title: "Prenatal Check-up",
              datetime: DateTime(2025, 3, 15, 9, 0),
              iconSrc: "lib/assets/images/reminders_card_prenatal_checkup_icon.png",
            ),
            RemindersScheduleItem(
              title: "Nutrition Seminar",
              datetime: DateTime(2025, 3, 22, 8, 0),
              iconSrc: "lib/assets/images/reminders_card_nutrition_seminar_icon.png",
            ),
          ],
        )
      ],
    );
  }
}
