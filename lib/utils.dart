import 'dart:math';

capitalize(String string, [String sep = ' ']) {
  return string
      .split(sep)
      .map((s) => s[0].toUpperCase() + s.substring(1))
      .join(sep);
}

T clamp<T extends num>(T number, T low, T high) => max(low, min(number, high));

Type typeOf<T>() => T;
