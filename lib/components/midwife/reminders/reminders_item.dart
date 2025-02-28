import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/pages/midwife/add_reminders/view_reminders_page.dart';

class RemindersItem extends StatelessWidget {
  const RemindersItem({super.key, required this.data, required this.handleDelete});

  final Map<String, dynamic> data;
  final Function(int code) handleDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => ViewRemindersPage(data: data))),
      child: Row(
        children: [
          Image.asset(
            data['icon'],
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data["title"],
                  style: TextStyle(fontSize: 8 * 3, fontWeight: FontWeight.w500),
                ),
                Text(
                  "${DateFormat("MMMM dd, yyyy").format(data["date"])} @ ${DateFormat.jm().format(DateTime(2021, 1, 1, data["time"].hour, data["time"].minute))}",
                  style: TextStyle(fontSize: 8 * 2),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton.link(context: context, label: "Edit", onPressed: () {}),
              IconButton(
                  onPressed: () => handleDelete(data["code"] ?? 0), icon: Icon(Ionicons.trash))
            ],
          )
        ],
      ),
    );
  }
}
