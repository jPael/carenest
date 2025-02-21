import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RemindersTodaysScheduleItem extends StatelessWidget {
  const RemindersTodaysScheduleItem({
    super.key,
    required this.title,
    required this.iconSrc,
    required this.datetime,
  });

  final DateTime datetime;
  final String title;
  final String iconSrc;

  @override
  Widget build(BuildContext context) {
    final String date = DateFormat("MMMM d, y").format(datetime);
    final String time = DateFormat("hh:mm a").format(datetime);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
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
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 8 * 2),
              ),
              Text(date),
              Text(time)
            ],
          )
        ],
      ),
    );
  }
}
