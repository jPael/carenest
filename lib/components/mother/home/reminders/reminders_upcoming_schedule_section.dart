import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_schedule_item.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/reminder.dart';

class RemindersUpcomingScheduleSection extends StatefulWidget {
  const RemindersUpcomingScheduleSection({super.key, required this.reminder});
  final List<Reminder> reminder;
  @override
  RemindersUpcomingScheduleSectionState createState() => RemindersUpcomingScheduleSectionState();
}

class RemindersUpcomingScheduleSectionState extends State<RemindersUpcomingScheduleSection> {
  @override
  Widget build(BuildContext context) {
    return CustomSection(
        title: "Upcoming Schedule",
        children: widget.reminder
            .map((r) => RemindersScheduleItem(
                title: r.title, iconSrc: r.reminderType.image, datetime: r.date!))
            .toList());
  }
}
