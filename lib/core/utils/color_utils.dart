import 'package:flutter/material.dart';

import 'math_utils.dart';

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

  static Color fromHex6Int(int hex, [int alpha = 0xff]) {
    return Color(alpha << 24 | hex);
  }

  static Color fromHex6String(String hex, [int alpha = 0xff]) {
    hex = hex.replaceAll('#', '');
    return fromHex6Int(int.parse(hex, radix: 16), alpha);
  }

  static Color lighten(Color original, double amount) {
    assert(amount >= -1 && amount <= 1);
    final hsl = HSLColor.fromColor(original);
    final lightness = clamp(hsl.lightness + amount, 0.0, 1.0);
    return hsl.withLightness(lightness).toColor();
  }

  static Color darken(Color original, double amount) {
    return lighten(original, -amount);
  }
}
