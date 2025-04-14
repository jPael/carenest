import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smartguide_app/models/reminder.dart';

class ViewRemindersPage extends StatelessWidget {
  const ViewRemindersPage({super.key, required this.reminder});

  final Reminder reminder;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(2 * 8.0),
        child: Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(2 * 8.0),
              child: Column(
                spacing: 8 * 2,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset(reminder.reminderType.image),
                      ),
                      Flexible(
                        child: Text(reminder.title,
                            softWrap: true,
                            style: const TextStyle(fontSize: 8 * 4, fontWeight: FontWeight.w500)),
                      )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Date: ",
                        softWrap: true,
                        style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              reminder.date != null
                                  ? DateFormat("MMMM dd, yyyy").format(reminder.date!)
                                  : "Date is not set",
                              softWrap: true,
                              style: const TextStyle(
                                fontSize: 8 * 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   "Time: ",
                      //   softWrap: true,
                      //   style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                      // ),
                      // Row(
                      //   children: [
                      //     Flexible(
                      //       child: Text(
                      //         DateFormat.jm().format(
                      //             DateTime(2021, 1, 1, reminder.time.hour, reminder.time.minute)),
                      //         softWrap: true,
                      //         style: TextStyle(
                      //           fontSize: 8 * 3,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "Purpose: ",
                  //       softWrap: true,
                  //       style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                  //     ),
                  //     Row(
                  //       children: [
                  //         Flexible(
                  //           child: Text(
                  //             reminder.purpose ?? "",
                  //             softWrap: true,
                  //             style: TextStyle(
                  //               fontSize: 8 * 3,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
