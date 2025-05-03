import 'package:smartguide_app/models/new_user.dart';
import 'package:smartguide_app/models/reminder.dart';
import 'package:smartguide_app/models/trimester.dart';

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

String getUserStringFromUserTypeEnum(UserTypeEnum type) {
  switch (type) {
    case UserTypeEnum.mother:
      return "MOTHER";
    case UserTypeEnum.midwife:
      return "MIDWIFE";
  }
}

UserTypeEnum getUserEnumFromUserTypeString(String type) {
  switch (type) {
    case "MOTHER":
      return UserTypeEnum.mother;
    case "MIDWIFE":
      return UserTypeEnum.midwife;
    default:
      throw ArgumentError("Invalid user type: $type");
  }
}

int getIntegerFromUserTypeEnum(UserTypeEnum type) {
  switch (type) {
    case UserTypeEnum.mother:
      return 2;
    case UserTypeEnum.midwife:
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
    case "1ST_TRIMESTER":
      return TrimesterEnum.first;
    case "2ND_TRIMESTER":
      return TrimesterEnum.second;
    case "3RD_TRIMESTER":
      return TrimesterEnum.third;
    default:
      throw ArgumentError("Invalid trimester: $t");
  }
}

int? getIntegerTrimesterEnum(TrimesterEnum? t) {
  switch (t) {
    case TrimesterEnum.first:
      return 1;
    case TrimesterEnum.second:
      return 2;
    case TrimesterEnum.third:
      return 3;
    default:
      return null;
  }
}
