import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_schedule_item.dart';

class RemindersMissedSchedule extends StatelessWidget {
  const RemindersMissedSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Text(
            "Missed Schedule",
            style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
          ),
        ],
      ),
      const SizedBox(
        height: 8,
      ),
      Column(spacing: 8 * 2, children: [
        RemindersScheduleItem(
          title: "Nutrition Seminar",
          datetime: DateTime(2025, 3, 22, 8, 0),
          iconSrc: "lib/assets/images/reminders_card_nutrition_seminar_icon.png",
          statusType: ScheduleItemStatusType.missed,
        ),
      ])
    ]);
  }
}
