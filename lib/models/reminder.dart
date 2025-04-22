import 'package:smartguide_app/fields/reminder_fields.dart';
import 'package:smartguide_app/services/laravel/reminder_services.dart';
import 'package:smartguide_app/utils/utils.dart';

class Reminder {
  final int? id;
  String title;
  String? purpose;
  ReminderTypeEnum reminderType;
  DateTime? date;
  // final TimeOfDay time;
  bool isFresh;
  final int userId;
  bool? isDone;

  Reminder({
    this.isDone,
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

  static Reminder fromJson(Map<String, dynamic> json) => Reminder(
      isDone: json[ReminderFields.isDone] == 1 ? true : false,
      isFresh: false,
      id: json[ReminderFields.id],
      userId: json[ReminderFields.userId],
      date: DateTime.tryParse(json[ReminderFields.reminderDate]),
      title: json[ReminderFields.name],
      reminderType: getReminderTypeEnumFromReminderInt(json[ReminderFields.icon]) ??
          ReminderTypeEnum.prenatalCheckup);

  Map<String, dynamic> toJson() => {
        ReminderFields.id: id,
        ReminderFields.isDone: isDone,
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

  Future<void> markAsDone(String token) async {
    final bool res = await reminderServices.updateReminder(
        id: id!,
        title: title,
        type: reminderType,
        date: date!,
        token: token,
        userId: userId,
        isDone: true);
  }

  Future<Reminder> updateReminder({
    required String title,
    required ReminderTypeEnum type,
    required int userId,
    required DateTime date,
    required String token,
    bool isDone = false,
  }) async {
    final bool res = await reminderServices.updateReminder(
        id: id!,
        title: title,
        type: type,
        date: date,
        token: token,
        userId: userId,
        isDone: isDone);

    if (res) {
      return Reminder(
          date: date,
          reminderType: type,
          title: title,
          userId: userId,
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
