import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/components/button/custom_button.dart';
import 'package:smartguide_app/models/reminder.dart';
import 'package:smartguide_app/models/user.dart';
import 'package:smartguide_app/pages/midwife/add_reminders/view_reminders_page.dart';

class RemindersItem extends StatefulWidget {
  const RemindersItem({super.key, required this.reminder, required this.handleDelete});

  final Reminder reminder;
  final Function(int code) handleDelete;

  @override
  State<RemindersItem> createState() => _RemindersItemState();
}

class _RemindersItemState extends State<RemindersItem> {
  late bool isFresh;
  late bool isSyncing;

  Future<void> syncFresh() async {
    final User user = context.read<User>();

    if (!isFresh) {
      setState(() {
        isSyncing = true;
      });

      try {
        final res = await widget.reminder.storeReminder(user.token!);
        if (res) {
          setState(() {
            isFresh = false;
          });
        } else {
          if (!mounted) return;
          showErrorMessage(context: context, message: "There was an error storing the reminder");
          setState(() {
            isFresh = true;
          });
        }
      } catch (e, stackTrace) {
        if (!mounted) return;
        showErrorMessage(context: context, message: "There was an error storing the reminder");
        log("There was an error storing the reminder: $e", stackTrace: stackTrace);
        setState(() {
          isFresh = true;
        });
      } finally {
        setState(() {
          isSyncing = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    isFresh = widget.reminder.isFresh;
    syncFresh();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ViewRemindersPage(reminder: widget.reminder))),
      child: Row(
        spacing: 4 * 2,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Image.asset(
              widget.reminder.reminderType.image,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      widget.reminder.title,
                      style: TextStyle(fontSize: 4 * 5, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    // if (isSyncing == true)
                    isSyncing
                        ? Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(4 * 2),
                            ),
                            padding: const EdgeInsets.all(4),
                            child: Row(
                              children: [
                                SizedBox.square(
                                  dimension: 4 * 4,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                                SizedBox(width: 4 * 2),
                                Text(
                                  "Syncing...",
                                  style:
                                      TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
                Text(
                  "${DateFormat("MMMM dd, yyyy").format(widget.reminder.date)} @ ${DateFormat.jm().format(DateTime(2021, 1, 1, widget.reminder.time.hour, widget.reminder.time.minute))}",
                  style: TextStyle(fontSize: 4 * 4),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton.link(context: context, label: "Edit", onPressed: () {}),
              IconButton(
                  onPressed: () => widget.handleDelete(widget.reminder.reminderType.code),
                  icon: Icon(Ionicons.trash))
            ],
          )
        ],
      ),
    );
  }
}
