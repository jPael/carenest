import 'dart:developer';

import 'package:smartguide_app/fields/reminder_fields.dart';
import 'package:smartguide_app/services/laravel/reminder_services.dart';

class Reminder {
  final int? id;
  String title;
  String? purpose;
  ReminderTypeEnum reminderType;
  DateTime? date;
  // final TimeOfDay time;
  bool isFresh;
  final int userId;

  Reminder({
    this.id,
    required this.title,
    required this.userId,
    this.purpose,
    required this.reminderType,
    required this.date,
    // required this.time,
    this.isFresh = true,
  });

  final ReminderServices reminderServices = ReminderServices();

  Future<bool> storeReminder(String token) async {
    final bool res = await reminderServices.storeReminder(this, token);
    return res;
  }

  Future<int> removeReminder(String token) async {
    final int res = await reminderServices.removeReminder(this, token);

    return res;
  }

  void fromJson(Map<String, dynamic> json) {
    title = json[ReminderFields.name];
    reminderType = json[ReminderFields.type];
    date = json[ReminderFields.reminderDate];
  }

  Map<String, dynamic> toJson() => {
        ReminderFields.name: title,
        ReminderFields.icon: reminderType.code,
        ReminderFields.reminderDate: date.toString(),
        ReminderFields.userId: userId,
      };

  Reminder toCopy() {
    return Reminder(
      id: id,
      title: title,
      userId: userId,
      purpose: purpose,
      reminderType: reminderType,
      date: date,
      isFresh: isFresh,
    );
  }

  Future<Reminder> updateReminder({
    required String title,
    required ReminderTypeEnum type,
    required String userId,
    required DateTime date,
    required String token,
  }) async {
    final bool res = await reminderServices.updateReminder(id!, title, type, date, token, userId);

    if (res) {
      return Reminder(
          date: date,
          reminderType: type,
          title: title,
          userId: int.parse(userId),
          id: id,
          isFresh: isFresh,
          purpose: purpose);
    } else {
      throw Exception("There was an error updating your reminder");
    }
  }
}

final List<Map<String, dynamic>> imagePaths = [
  {
    "type": ReminderTypeEnum.prenatalCheckup,
    "code": ReminderTypeEnum.prenatalCheckup.code,
    "title": ReminderTypeEnum.prenatalCheckup.name,
    "image": ReminderTypeEnum.prenatalCheckup.image
  },
  {
    "type": ReminderTypeEnum.nutritionSeminar,
    "code": ReminderTypeEnum.nutritionSeminar.code,
    "title": ReminderTypeEnum.nutritionSeminar.name,
    "image": ReminderTypeEnum.nutritionSeminar.image
  },
  {
    "type": ReminderTypeEnum.vaccinationDrive,
    "code": ReminderTypeEnum.vaccinationDrive.code,
    "title": ReminderTypeEnum.vaccinationDrive.name,
    "image": ReminderTypeEnum.vaccinationDrive.image
  }
];

enum ReminderTypeEnum {
  prenatalCheckup,
  nutritionSeminar,
  vaccinationDrive,
}

extension ReminderTypeEnumExtension on ReminderTypeEnum {
  String get name {
    switch (this) {
      case ReminderTypeEnum.prenatalCheckup:
        return "Prenatal Checkup";
      case ReminderTypeEnum.nutritionSeminar:
        return "Nutrition Seminar";
      case ReminderTypeEnum.vaccinationDrive:
        return "Vaccination Drive";
    }
  }

  int get code {
    switch (this) {
      case ReminderTypeEnum.prenatalCheckup:
        return 1;
      case ReminderTypeEnum.nutritionSeminar:
        return 2;
      case ReminderTypeEnum.vaccinationDrive:
        return 3;
    }
  }

  String get image {
    switch (this) {
      case ReminderTypeEnum.prenatalCheckup:
        return "lib/assets/images/reminders_card_prenatal_checkup_icon.png";
      case ReminderTypeEnum.nutritionSeminar:
        return "lib/assets/images/reminders_card_nutrition_seminar_icon.png";
      case ReminderTypeEnum.vaccinationDrive:
        return "lib/assets/images/reminders_card_vaccination_drive_icon.png";
    }
  }
}
