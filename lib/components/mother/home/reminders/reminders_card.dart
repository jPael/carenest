import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/utils/utils.dart';

class RemindersCard extends StatefulWidget {
  const RemindersCard(
      {super.key, required this.title, required this.datetime, required this.iconSrc});

  final String title;
  final String iconSrc;
  final DateTime datetime;

  @override
  State<RemindersCard> createState() => _RemindersCardState();
}

class _RemindersCardState extends State<RemindersCard> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final String date = DateFormat("MMMM d, y").format(widget.datetime);
    final String time = DateFormat("hh:mm a").format(widget.datetime);

    final DateTime monthOfConception = DateTime(2024, 12, 1);

    final Duration totalDuration = widget.datetime.difference(monthOfConception);

    final Duration difference = DateTime.now().difference(monthOfConception);

    final int percentage = ((difference.inDays / totalDuration.inDays) * 100).clamp(0, 100).toInt();

    String dayLeftReadable = formatDayLeft(difference);

    final AnimationController progressController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300), value: percentage / 100)
      ..addListener(() {
        setState(() {});
      });

    return Card(
      elevation: 2,
      child: SizedBox(
        width: 150,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8 * 3, horizontal: 8.0 * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 8 * 8,
                child: Image.asset(
                  widget.iconSrc,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 8 * 1.5,
              ),
              Text(
                widget.title,
                style: const TextStyle(fontSize: 8 * 2, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(date),
              Text(time),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    dayLeftReadable,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text("$percentage%",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.right),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 150 - 8 * 4,
                    child: LinearProgressIndicator(
                      color: Theme.of(context).colorScheme.primary,
                      value: progressController.value,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
