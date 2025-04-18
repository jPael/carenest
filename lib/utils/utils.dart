import 'package:flutter/material.dart';

export 'package:smartguide_app/utils/date_utils.dart';
export 'package:smartguide_app/utils/const_utils.dart';

Color muteColor(Color color) {
  final hslColor = HSLColor.fromColor(color);

  final mutedColor = hslColor.withSaturation(hslColor.saturation * 0.4)
    ..withLightness(hslColor.lightness * 0.1);

  return mutedColor.toColor();
}
