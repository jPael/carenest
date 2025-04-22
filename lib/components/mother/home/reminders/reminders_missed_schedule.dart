import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_schedule_item.dart';
import 'package:smartguide_app/models/reminder.dart';

class RemindersMissedSchedule extends StatelessWidget {
  const RemindersMissedSchedule({super.key, required this.reminders});
  final List<Reminder> reminders;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Row(
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
      Column(
          spacing: 8 * 2,
          children: reminders
              .map((r) => RemindersScheduleItem(
                    title: r.title,
                    iconSrc: r.reminderType.image,
                    datetime: r.date!,
                    statusType: ScheduleItemStatusType.missed,
                  ))
              .toList())
    ]);
  }
}
