import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/fields/reminder_fields.dart';
import 'package:smartguide_app/models/reminder.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:smartguide_app/utils/utils.dart';

class ReminderServices {
  Future<List<Reminder>?>? fetchAllReminderByUserId(String laravelId, String token) async {
    if (laravelId.isEmpty) return null;

    final url = apiURIBase.replace(path: LaravelPaths.allReminders);

    final res = await http
        .get(url, headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"});

    final data = jsonDecode(res.body) as List<dynamic>;

    final cleanReminder = data.where((r) => r[ReminderFields.userId].toString() == laravelId);

    await Future.delayed(const Duration(seconds: 5));

    final List<Reminder> reminders = cleanReminder
        .map((r) => Reminder(
            isFresh: false,
            id: r[ReminderFields.id],
            userId: r[ReminderFields.userId],
            date: DateTime.tryParse(r[ReminderFields.reminderDate]),
            title: r[ReminderFields.name],
            reminderType: getReminderTypeEnumFromReminderInt(r[ReminderFields.icon]) ??
                ReminderTypeEnum.prenatalCheckup))
        .toList();

    return reminders;
  }

  Future<int> removeReminder(Reminder reminder, String token) async {
    if (reminder.id == null) throw Exception("Reminder ID is not provided");

    log(LaravelPaths.specificReminder(reminder.id!));

    await Future.delayed(const Duration(seconds: 5));

    final url = apiURIBase.replace(path: LaravelPaths.specificReminder(reminder.id!));

    final res = await http.delete(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode != HttpStatus.ok) {
      throw Exception("Unabled to delete reminder");
      
    }

    return reminder.id!;
  }

  Future<bool> updateReminder(int id, String title, ReminderTypeEnum type, DateTime date,
      String token, String userId) async {
    if (token.isEmpty) return false;

    final url = apiURIBase.replace(path: LaravelPaths.specificReminder(id));

    final res = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          ReminderFields.name: title,
          ReminderFields.icon: type.code,
          ReminderFields.reminderDate: date.toString(),
          ReminderFields.userId: userId,
          ReminderFields.isDone: 0
        }));

    if (res.statusCode != HttpStatus.ok) {
      log("service error: ${res.body}");

      return false;
    }

    return true;
  }

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
