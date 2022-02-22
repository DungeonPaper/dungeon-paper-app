import 'dart:math' as math;

T clamp<T extends num>(T value, T min, T max) {
  return math.min(math.max(value, min), max);
}
