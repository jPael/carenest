import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:smartguide_app/services/laravel/reminder_services.dart';

class Reminder {
  final String title;
  final String purpose;
  final ReminderTypeEnum reminderType;
  final DateTime date;
  final TimeOfDay time;
  bool isFresh;
  final int userId;

  Reminder({
    required this.title,
    required this.userId,
    required this.purpose,
    required this.reminderType,
    required this.date,
    required this.time,
    this.isFresh = false,
  });

  final ReminderServices reminderServices = ReminderServices();

  Future<bool> storeReminder(String token) async {
    final bool res = await reminderServices.storeReminder(this, token);
    return res;
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
