import 'package:flutter/material.dart';

export 'package:smartguide_app/utils/const_utils.dart';
export 'package:smartguide_app/utils/date_utils.dart';

Color muteColor(Color color) {
  final hslColor = HSLColor.fromColor(color);

  final mutedColor = hslColor.withSaturation(hslColor.saturation * 0.4)
    ..withLightness(hslColor.lightness * 0.1);

  return mutedColor.toColor();
}

bool isFundalHeightNormal(DateTime? lastMenstrualPeriod, int? fundalHeightCm) {
  // log("$lastMenstrualPeriod $fundalHeightCm");
  // log((lastMenstrualPeriod == null || fundalHeightCm == null).toString());

  if (lastMenstrualPeriod == null || fundalHeightCm == null) return false;

  DateTime now = DateTime.now();
  Duration pregnancyDuration = now.difference(lastMenstrualPeriod);
  int gestationalAgeWeeks = (pregnancyDuration.inDays / 7).floor();

  // Fundal height is only reliable after 20 weeks
  if (gestationalAgeWeeks < 20) {
    return false; // Consider ultrasound for early pregnancy
  }

  int lowerBound = gestationalAgeWeeks - 2;
  int upperBound = gestationalAgeWeeks + 2;

  // log("$fundalHeightCm >= $lowerBound");
  // log("$fundalHeightCm <= $upperBound");
  // log("${fundalHeightCm >= lowerBound}");
  // log("${fundalHeightCm <= upperBound}");
  // log("returns ${(fundalHeightCm >= lowerBound && fundalHeightCm <= upperBound)}");
  return (fundalHeightCm >= lowerBound && fundalHeightCm <= upperBound);
}
