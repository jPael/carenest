import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:smartguide_app/fields/reminder_fields.dart';
import 'package:smartguide_app/models/reminder.dart';
import 'package:smartguide_app/services/laravel/api_url.dart';
import 'package:smartguide_app/utils/date_utils.dart';

class ReminderServices {
  Future<Reminder> setRemindersAsDone({required String token, required Reminder reminder}) async {
    final url = apiURIBase.replace(path: LaravelPaths.reminderMarkAsDone);

    final Map<String, dynamic> payload = {'id': reminder.id!};

    final res = await http.post(url,
        headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"},
        body: jsonEncode(payload));

    if (res.statusCode > HttpStatus.badRequest &&
        res.statusCode < HttpStatus.networkConnectTimeoutError) {
      log(url.toString());
      log(res.statusCode.toString());

      throw Exception("There was an error in the server. Please try again");
    }

    log(res.body);

    return Reminder.fromJson(jsonDecode(res.body)['data']);
  }

  Future<Map<String, List<Reminder>>> fetchAllSegregatedReminderByUserId(
      String laravelId, String token) async {
    final List<Reminder> reminders =
        await fetchAllReminderByMotherId(laravelId, token) as List<Reminder>;

    final List<Reminder> today = [];
    final List<Reminder> upcoming = [];
    final List<Reminder> done = [];
    final List<Reminder> missed = [];

    final DateTime now = DateTime.now();
    // final DateTime todayStart = DateTime(now.year, now.month, now.day);
    // final DateTime todayEnd = DateTime(now.year, now.month, now.day, 23, 59, 59);

    for (Reminder reminder in reminders) {
      if (reminder.isDone == true) {
        done.add(reminder);
        continue;
      }

      if (reminder.date == null) continue;

      if (isNow(reminder.date!)) {
        today.add(reminder);
      } else if (reminder.date!.toLocal().isAfter(now)) {
        upcoming.add(reminder);
      } else {
        missed.add(reminder);
      }
    }

    today.sort((a, b) => a.date!.compareTo(b.date!));

    upcoming.sort((a, b) => a.date!.compareTo(b.date!));

    missed.sort((a, b) => b.date!.compareTo(a.date!));

    final d = {
      'today': today,
      'upcoming': upcoming,
      'done': done,
      'missed': missed,
    };

    d.forEach(
      <String, object>(key, List<Reminder> value) =>
          // ignore: avoid_function_literals_in_foreach_calls
          value.forEach((v) => log("$key: ${v.toJson().toString()}")),
    );
    // d.forEach(
    //   <String, object>(key, List<Reminder> value) => value.forEach((v) => log(
    //       "$key: ${v.id!.toString()} ${v.isDone!.toString()} ${v.date!.toString()} ${DateTime.now().toString()}")),
    // );

    return d;
  }

  Future<List<Reminder>?>? fetchAllReminderByMotherId(String laravelId, String token) async {
    // log(laravelId);

    if (laravelId.isEmpty) return null;

    final url = apiURIBase.replace(path: LaravelPaths.allReminders);

    final res = await http
        .get(url, headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"});

    log(url.toString());

    final data = jsonDecode(res.body) as List<dynamic>;

    // log(data.length.toString());

    final cleanReminder = data.where((r) => r[ReminderFields.motherId].toString() == laravelId);

    // await Future.delayed(const Duration(seconds: 5));

    final List<Reminder> reminders = cleanReminder.map((r) {
      return Reminder.fromJson(r);
    }).toList();

    return reminders;
  }

  Future<List<Reminder>?>? fetchAllReminderByMidwifeId(String laravelId, String token) async {
    if (laravelId.isEmpty) return null;

    final url = apiURIBase.replace(path: LaravelPaths.allReminderByMidwifeId(int.parse(laravelId)));

    final res = await http
        .get(url, headers: {'Content-Type': 'application/json', 'Authorization': "Bearer $token"});

    // log(res.body);

    final data = jsonDecode(res.body) as List<dynamic>;

    // log(data.length.toString());

    final cleanReminder = data.where((r) => r[ReminderFields.midwifeId].toString() == laravelId);

    // await Future.delayed(const Duration(seconds: 5));

    final List<Reminder> reminders = cleanReminder.map((r) => Reminder.fromJson(r)).toList();

    return reminders;
  }

  Future<int> removeReminder(Reminder reminder, String token) async {
    if (reminder.id == null) throw Exception("Reminder ID is not provided");

    // log(LaravelPaths.specificReminder(reminder.id!));

    // await Future.delayed(const Duration(seconds: 5));

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

  Future<Reminder> updateReminder(
      {required int id,
      required String title,
      required ReminderTypeEnum type,
      required DateTime date,
      required String token,
      required int motherId,
      required bool isDone,
      required int midwifeId}) async {
    if (token.isEmpty) throw Exception("Error needs authentication");

    final url = apiURIBase.replace(path: LaravelPaths.specificReminder(id));

    final Map<String, dynamic> payload = {
      ReminderFields.name: title,
      ReminderFields.icon: type.code,
      ReminderFields.reminderDate: date.toString(),
      ReminderFields.motherId: motherId,
      ReminderFields.midwifeId: midwifeId,
      ReminderFields.isDone: isDone ? 1 : 0
    };

    // log(url.toString());
    // log(payload.toString());

    final res = await http.put(url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(payload));

    if (res.statusCode != HttpStatus.ok) {
      throw Exception("Error there was an error on the server. Please try again");
    }

    final json = jsonDecode(res.body);
    return Reminder.fromJson(json['data']);
  }

  Future<Map<String, dynamic>> storeReminder(Reminder reminder, String token) async {
    final url = apiURIBase.replace(path: LaravelPaths.reminder);
    final Map<String, dynamic> payload = {
      ReminderFields.name: reminder.title,
      ReminderFields.icon: reminder.reminderType.code,
      ReminderFields.reminderDate: reminder.date.toString(),
      ReminderFields.motherId: reminder.motherId,
      ReminderFields.midwifeId: reminder.midwifeId
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

    return {"success": true, "data": jsonDecode(res.body)['data']};
  }
}
