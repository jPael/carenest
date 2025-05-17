import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_card.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/reminder.dart';
import 'package:smartguide_app/models/user.dart';

class RemindersTodaysScheduleSection extends StatelessWidget {
  const RemindersTodaysScheduleSection({super.key, required this.reminders});

  final List<Reminder> reminders;

  @override
  Widget build(BuildContext context) {
    Future<void> markAsDone(Reminder r) async {
      final User user = context.read<User>();

      await r.markAsDone(user.token!);
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomSection(
          title: "Today's Schedule",
          alignment: CrossAxisAlignment.start,
          children: [
            if (reminders.isEmpty) ...[
              const Padding(
                padding: EdgeInsets.all(8.0 * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No reminders..."),
                  ],
                ),
              ),
            ] else ...[
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  spacing: 8,
                  children: [
                    ...reminders.map((r) => RemindersCard(
                          datetime: r.date!,
                          iconSrc: r.reminderType.image,
                          title: r.title,
                          markAsDone: () => markAsDone(r),
                        ))
                  ],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
