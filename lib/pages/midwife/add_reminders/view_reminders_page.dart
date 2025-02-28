import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewRemindersPage extends StatelessWidget {
  const ViewRemindersPage({super.key, required this.data});

  final Map<String, dynamic> data;

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
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 8,
                    children: [
                      Image.asset(
                        data['icon'],
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      Text(data["title"],
                          softWrap: true,
                          style: TextStyle(fontSize: 8 * 4, fontWeight: FontWeight.w500))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Date: ",
                        softWrap: true,
                        style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              DateFormat("MMMM dd, yyyy").format(data["date"]),
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 8 * 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Time: ",
                        softWrap: true,
                        style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              DateFormat.jm().format(
                                  DateTime(2021, 1, 1, data["time"].hour, data["time"].minute)),
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 8 * 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Purpose: ",
                        softWrap: true,
                        style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              data["purpose"] + "adtgaukdtuaiytsdyiasdayh",
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 8 * 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
