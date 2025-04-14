import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ScheduleItemStatusType { done, missed }

class RemindersScheduleItem extends StatelessWidget {
  const RemindersScheduleItem({
    super.key,
    required this.title,
    required this.iconSrc,
    required this.datetime,
    this.statusType,
  });

  final DateTime datetime;
  final String title;
  final String iconSrc;

  final ScheduleItemStatusType? statusType;

  @override
  Widget build(BuildContext context) {
    final String date = DateFormat("MMMM d, y").format(datetime);
    final String time = DateFormat("hh:mm a").format(datetime);

    Map<ScheduleItemStatusType, Widget> statusIcon = {
      ScheduleItemStatusType.done: const Icon(
        Icons.check,
        color: Colors.green,
      ),
      ScheduleItemStatusType.missed: const Text(
        "Missed",
        style: TextStyle(color: Colors.red),
      )
    };

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            spacing: 8 * 2,
            children: [
              SizedBox(
                width: 40,
                child: Image.asset(
                  iconSrc,
                  scale: 1.5,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 8 * 2),
                  ),
                  Text(date),
                  Text(time)
                ],
              )
            ],
          ),
          if (statusType != null) ...[statusIcon[statusType]!]
        ],
      ),
    );
  }
}
