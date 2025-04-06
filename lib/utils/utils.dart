import 'package:flutter/material.dart';
import 'package:smartguide_app/components/prenatal_records/form/prenatal_info_form.dart';
import 'package:smartguide_app/models/new_user.dart';
import 'package:smartguide_app/models/reminder.dart';

class Utils {
  static String formatDayLeft(Duration difference) {
    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays == 1) {
      return "1 day left";
    } else if (difference.inDays < 7) {
      return "${difference.inDays} days left";
    } else if (difference.inDays < 14) {
      return "1 week left";
    } else {
      return "${(difference.inDays / 7).floor()} weeks left";
    }
  }
}

ReminderTypeEnum? getReminderTypeEnumFromReminderInt(int i) {
  switch (i) {
    case 1:
      return ReminderTypeEnum.prenatalCheckup;
    case 2:
      return ReminderTypeEnum.nutritionSeminar;
    case 3:
      return ReminderTypeEnum.vaccinationDrive;
    default:
      return null;
  }
}

String getUserStringFromUserTypeEnum(UserType type) {
  switch (type) {
    case UserType.mother:
      return "MOTHER";
    case UserType.midwife:
      return "MIDWIFE";
  }
}

UserType getUserEnumFromUserTypeString(String type) {
  switch (type) {
    case "MOTHER":
      return UserType.mother;
    case "MIDWIFE":
      return UserType.midwife;
    default:
      throw ArgumentError("Invalid user type: $type");
  }
}

int getIntegerFromUserTypeEnum(UserType type) {
  switch (type) {
    case UserType.mother:
      return 2;
    case UserType.midwife:
      return 1;
  }
}

String getTrimesterStringFromTrimesterEnum(TrimesterEnum t) {
  switch (t) {
    case TrimesterEnum.first:
      return "FIRST";
    case TrimesterEnum.second:
      return "SECOND";
    case TrimesterEnum.third:
      return "THIRD";
  }
}

TrimesterEnum getTrimesterEnumFromTrimesterString(String t) {
  switch (t) {
    case "FIRST":
      return TrimesterEnum.first;
    case "SECOND":
      return TrimesterEnum.second;
    case "THIRD":
      return TrimesterEnum.third;
    default:
      throw ArgumentError("Invalid trimester: $t");
  }
}

int getIntegerTrimesterEnum(TrimesterEnum t) {
  switch (t) {
    case TrimesterEnum.first:
      return 1;
    case TrimesterEnum.second:
      return 2;
    case TrimesterEnum.third:
      return 3;
  }
}

Color muteColor(Color color) {
  final hslColor = HSLColor.fromColor(color);

  final mutedColor = hslColor.withSaturation(hslColor.saturation * 0.4)
    ..withLightness(hslColor.lightness * 0.1);

  return mutedColor.toColor();
}
