import 'package:smartguide_app/models/new_user.dart';

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

String getUserType(UserType type) {
  switch (type) {
    case UserType.mother:
      return "MOTHER";
    case UserType.midwife:
      return "MIDWIFE";
  }
}

UserType getEnumUserType(String type) {
  switch (type) {
    case "MOTHER":
      return UserType.mother;
    case "MIDWIFE":
      return UserType.midwife;
    default:
      throw ArgumentError("Invalid user type: $type");
  }
}
