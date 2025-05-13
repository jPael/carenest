import 'package:intl/intl.dart';

String formatDayLeft(Duration difference) {
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

int calculateAge(DateTime birthday) {
  final now = DateTime.now();

  // Check if birthday is in the future
  if (birthday.isAfter(now)) {
    throw ArgumentError("Birthday cannot be in the future");
  }

  int age = now.year - birthday.year;

  // Adjust if birthday hasn't occurred yet this year
  if (now.month < birthday.month || (now.month == birthday.month && now.day < birthday.day)) {
    age--;
  }

  return age;
}

// Helper function to parse date from string (optional)
DateTime parseBirthday(String dateString) {
  try {
    return DateTime.parse(dateString).toLocal();
  } catch (e) {
    // Alternative parsing with intl package if needed
    final format = DateFormat('yyyy-MM-dd');
    return format.parse(dateString);
  }
}

// final diff = widget.reminder.date!.toLocal().difference(DateTime.now().toLocal());
// final bool isNow = diff.inHours.abs() <= 24;  // Past or future 24 hours

bool isNow(DateTime date) {
  final now = DateTime.now().toLocal();
  final localDate = date.toLocal();

  return now.year == localDate.year && now.month == localDate.month && now.day == localDate.day;
}

bool hasPassed(DateTime date) {
  final now = DateTime.now().toLocal();
  final localDate = date.toLocal();

  return DateTime(now.year, now.month, now.day).isAfter(localDate);
}

String getOrdinalSuffix(int day) {
  if (day >= 11 && day <= 13) return 'th';
  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}

String getGreeting() {
  final hour = DateTime.now().hour;

  if (hour < 12) {
    return 'Good morning';
  } else if (hour < 17) {
    return 'Good afternoon';
  } else {
    return 'Good evening';
  }
}
