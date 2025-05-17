import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_schedule_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/reminder.dart';

class RemindersCompletedScheduleSection extends StatelessWidget {
  const RemindersCompletedScheduleSection({super.key, required this.reminders});

  final List<Reminder> reminders;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomSection(
              title: "Completed Schedule",
              emptyChildrenContent: const Padding(
                padding: EdgeInsets.all(8.0 * 4),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("No reminders...")],
                  ),
                ),
              ),
              children: [
                ...reminders.map((r) => RemindersScheduleItem(
                      title: r.title,
                      iconSrc: r.reminderType.image,
                      datetime: r.date!,
                      statusType: ScheduleItemStatusType.done,
                    )),
                SizedBox(
                  height: reminders.isEmpty ? 8 * 2 : 8 * 1,
                )
              ]

              // [
              //   RemindersScheduleItem(
              //     title: "Prenatal Check-up",
              //     datetime: DateTime(2025, 3, 15, 9, 0),
              //     iconSrc: "lib/assets/images/reminders_card_prenatal_checkup_icon.png",
              //     statusType: ScheduleItemStatusType.done,
              //   ),
              // ]
              )),
    );
  }
}
