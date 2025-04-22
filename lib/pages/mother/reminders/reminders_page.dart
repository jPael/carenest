import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_card.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_completed_schedule_section.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_header_section.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_missed_schedule.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_schedule_item.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_todays_schedule_section.dart';
import 'package:smartguide_app/components/mother/home/reminders/reminders_upcoming_schedule_section.dart';
import 'package:smartguide_app/components/section/custom_section.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/services/laravel/reminder_services.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key, required this.label});

  final String label;

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  bool isLoading = true;

  final ReminderServices reminderServices = ReminderServices();
  late Map<String, dynamic> reminder;

  Future<void> fetchReminders() async {
    final User user = context.read<User>();

    Map<String, dynamic> data = await reminderServices.fetchAllSegregatedReminderByUserId(
        user.laravelId.toString(), user.token!);

    setState(() {
      reminder = data;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchReminders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: RemindersHeaderSection(
          label: widget.label,
        ),
      ),
      body: SingleChildScrollView(
          child: CustomSection(
        isLoading: isLoading,
        isLoadingWidget: loadingSkeleton(),
        children: [
          isLoading
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0 * 2),
                  child: Column(
                    spacing: 8 * 3,
                    children: [
                      // RemindersCalendarSection(),
                      // SizedBox(
                      //   height: 8 * 3,
                      // ),
                      RemindersTodaysScheduleSection(
                        reminders: reminder['today'],
                      ),

                      RemindersUpcomingScheduleSection(
                        reminder: reminder['upcoming'],
                      ),

                      RemindersCompletedScheduleSection(
                        reminders: reminder['done'],
                      ),
                      RemindersMissedSchedule(
                        reminders: reminder['missed'],
                      ),
                    ],
                  )),
        ],
      )),
    );
  }

  Padding loadingSkeleton() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0 * 2),
        child: Column(
          children: [
            CustomSection(
              title: "Today's Schedule",
              children: [
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
                        title: "Prenatal Check-up",
                        datetime: DateTime(2025, 3, 15, 9, 0),
                        iconSrc: "lib/assets/images/reminders_card_prenatal_checkup_icon.png",
                      ),
                      RemindersCard(
                        title: "Prenatal Check-up",
                        datetime: DateTime(2025, 3, 15, 9, 0),
                        iconSrc: "lib/assets/images/reminders_card_prenatal_checkup_icon.png",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8 * 3,
            ),
            CustomSection(
              title: "Upcoming Schedule",
              children: [
                RemindersScheduleItem(
                  title: "Prenatal Check-up",
                  datetime: DateTime(2025, 3, 15, 9, 0),
                  iconSrc: "lib/assets/images/reminders_card_prenatal_checkup_icon.png",
                ),
              ],
            ),
            // RemindersUpcomingScheduleSection(),
            const SizedBox(
              height: 8 * 3,
            ),

            CustomSection(
              title: "Upcoming Schedule",
              children: [
                RemindersScheduleItem(
                  title: "Prenatal Check-up",
                  datetime: DateTime(2025, 3, 15, 9, 0),
                  iconSrc: "lib/assets/images/reminders_card_prenatal_checkup_icon.png",
                ),
              ],
            ),
            const SizedBox(
              height: 8 * 3,
            ),

            CustomSection(
              title: "Upcoming Schedule",
              children: [
                RemindersScheduleItem(
                  title: "Prenatal Check-up",
                  datetime: DateTime(2025, 3, 15, 9, 0),
                  iconSrc: "lib/assets/images/reminders_card_prenatal_checkup_icon.png",
                ),
              ],
            ),
          ],
        ));
  }
}
