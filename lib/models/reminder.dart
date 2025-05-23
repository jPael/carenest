import 'dart:developer';

import 'package:smartguide_app/components/alert/alert.dart';
import 'package:smartguide_app/fields/reminder_fields.dart';
import 'package:smartguide_app/models/person.dart';
import 'package:smartguide_app/services/laravel/reminder_services.dart';
import 'package:smartguide_app/utils/utils.dart';

class Reminder {
  int? id;
  String title;
  String? purpose;
  ReminderTypeEnum reminderType;
  final int midwifeId;
  DateTime? date;
  // final TimeOfDay time;
  bool isFresh;
  final int motherId;
  bool? isDone;
  Person? mother;
  Person? midwife;

  DateTime? createdAt;
  DateTime? updatedAt;

  Reminder({
    required this.midwifeId,
    this.isDone,
    this.id,
    required this.title,
    required this.motherId,
    this.purpose,
    required this.reminderType,
    required this.date,
    // required this.time,
    this.isFresh = true,
    this.mother,
    this.midwife,
    this.createdAt,
    this.updatedAt,
  });

  final ReminderServices reminderServices = ReminderServices();

  Future<Map<String, dynamic>> storeReminder(String token) async {
    final Map<String, dynamic> res = await reminderServices.storeReminder(this, token);

    return res;
  }

  Future<int> removeReminder(String token) async {
    final int res = await reminderServices.removeReminder(this, token);

    return res;
  }

  static Reminder fromJson(Map<String, dynamic> json) => Reminder(
        isDone: json[ReminderFields.isDone] == true || json[ReminderFields.isDone] == 1,
        isFresh: false,
        id: json[ReminderFields.id],
        motherId: json[ReminderFields.motherId],
        date: DateTime.tryParse(json[ReminderFields.reminderDate]),
        title: json[ReminderFields.name],
        midwifeId: json[ReminderFields.midwifeId],
        reminderType: getReminderTypeEnumFromReminderInt(json[ReminderFields.icon]) ??
            ReminderTypeEnum.prenatalCheckup,
        mother: Person.fromJsonStatic(json[ReminderFields.mother]),
        midwife: Person.fromJsonStatic(json[ReminderFields.midwife]),
        createdAt: DateTime.parse(json[ReminderFields.createdAt]).toLocal(),
        updatedAt: DateTime.parse(json[ReminderFields.updatedAt]).toLocal(),
      );

  Map<String, dynamic> toJson() => {
        ReminderFields.id: id,
        ReminderFields.isDone: isDone,
        ReminderFields.name: title,
        ReminderFields.icon: reminderType.code,
        ReminderFields.reminderDate: date.toString(),
        ReminderFields.motherId: motherId,
      };

  Reminder toCopy() {
    return Reminder(
      midwifeId: midwifeId,
      id: id,
      title: title,
      motherId: motherId,
      purpose: purpose,
      reminderType: reminderType,
      date: date,
      isFresh: isFresh,
    );
  }

  Future<Reminder> markAsDone(String token) async {
    try {
      final Reminder newReminder =
          await reminderServices.setRemindersAsDone(token: token, reminder: this);

      log(newReminder.isDone!.toString());

      Alert.showSuccessMessage(message: "Reminder has been set to done succesfully");
      return newReminder;
    } catch (e, stackTrace) {
      log("Error: $e", stackTrace: stackTrace);
      Alert.showErrorMessage(message: e.toString());
      rethrow;
    }
  }

  Future<Reminder> updateReminder({
    required String title,
    required ReminderTypeEnum type,
    required int motherId,
    required DateTime date,
    required String token,
    required DateTime createdAt,
    bool isDone = false,
    required int midwifeId,
  }) async {
    return await reminderServices.updateReminder(
        id: id!,
        title: title,
        type: type,
        date: date,
        token: token,
        motherId: motherId,
        isDone: isDone,
        midwifeId: midwifeId);
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
