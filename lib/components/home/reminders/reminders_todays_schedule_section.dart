import 'package:flutter/material.dart';
import 'package:smartguide_app/components/home/reminders/reminders_todays_schedule_item.dart';

class RemindersTodaysScheduleSection extends StatefulWidget {
  const RemindersTodaysScheduleSection({Key? key}) : super(key: key);

  @override
  _RemindersTodaysScheduleSectionState createState() => _RemindersTodaysScheduleSectionState();
}

class _RemindersTodaysScheduleSectionState extends State<RemindersTodaysScheduleSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Today’s Schedule",
              style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(
          height: 8 * 3,
        ),
        Column(
          spacing: 8 * 2,
          children: [
            RemindersTodaysScheduleItem(
              title: "Prenatal Check-up",
              datetime: DateTime(2025, 3, 15, 9, 0),
              iconSrc: "lib/assets/images/reminders_card_prenatal_checkup_icon.png",
            ),
            RemindersTodaysScheduleItem(
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
