import 'dart:math' as math;

T clamp<T extends num>(T value, T min, T max) {
  return math.min(math.max(value, min), max);
}

double degToRad(double deg) => deg * (math.pi / 180.0);

Iterable<int> range(int start, [int? end]) {
  final min = end != null ? start : 0;
  final num _max = end ?? start;
  return Iterable.generate((_max - min).toInt(), (i) => min + i);
}

T avg<T extends num>(Iterable<T> values) =>
    values.reduce((a, b) => a + b as T) / values.length as T;

T sum<T extends num>(Iterable<T> values) => values.reduce((a, b) => a + b as T);

int factorial(int n) => range(1, n).fold(1, (a, b) => a * b);
