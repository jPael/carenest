import 'package:flutter/material.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_calendar_section.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_completed_schedule_section.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_header_section.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_missed_schedule.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_todays_schedule_section.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_upcoming_schedule_section.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key, required this.label});

  final String label;

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: RemindersHeaderSection(
          label: widget.label,
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // separated the header section because the image has its own margin due to image's dimention

            Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0 * 2),
                child: Column(
                  children: [
                    RemindersCalendarSection(),
                    SizedBox(
                      height: 8 * 3,
                    ),
                    RemindersUpcomingScheduleSection(),
                    SizedBox(
                      height: 8 * 3,
                    ),
                    RemindersTodaysScheduleSection(),
                    SizedBox(
                      height: 8 * 3,
                    ),
                    RemindersCompletedScheduleSection(),
                    SizedBox(
                      height: 8 * 3,
                    ),
                    RemindersMissedSchedule(),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
