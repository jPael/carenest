import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:smartguide_app/fields/reminder_fields.dart';
import 'package:smartguide_app/models/reminder.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';

class ReminderServices {
  Future<bool> storeReminder(Reminder reminder, String token) async {
    final url = apiURIBase.replace(path: LaravelPaths.reminder);
    final Map<String, dynamic> payload = {
      ReminderFields.name: reminder.title,
      ReminderFields.icon: reminder.reminderType.code,
      ReminderFields.reminderDate: reminder.date.toString(),
      ReminderFields.userId: reminder.userId,
    };

    final res = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload));

    if (res.statusCode != 200) {
      log("Error storing reminder: ${res.body}");
      throw Exception("There was an error syncing your reminder");
    }

    return true;
  }
}
