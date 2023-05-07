import 'package:flutter/material.dart';

class ColorUtils {
  static List<Color> generateRainbow(
    int length, {
    double saturation = 0.5,
    double lightness = 0.5,
  }) =>
      [
        for (double i = 0; i < 1; i += 1.0 / length.toDouble())
          HSLColor.fromAHSL(1, i * 256, saturation, lightness).toColor(),
      ];
}
