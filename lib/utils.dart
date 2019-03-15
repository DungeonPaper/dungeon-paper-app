import 'dart:math';

capitalize(String string, [String sep = ' ']) {
  return string.splitMapJoin(RegExp(sep),
      onMatch: (s) =>
          s.input[s.start].toUpperCase() +
          s.input.substring(s.start + 1, s.end),
      onNonMatch: (s) => s[0].toUpperCase() + s.substring(1));
}

double clamp<T extends num>(T number, T low, T high) =>
    max(low * 1.0, min(number * 1.0, high * 1.0));

double lerp(num t, num minA, num maxA, num minB, num maxB) =>
    (t - minA) / (maxA - minA) * (maxB - minB) + minB;

bool isNumeric(String s) {
  if (s == null) {
    return false;
  }
  return (double.tryParse(s.toString()) ?? null) != null;
}

Type typeOf<T>() => T;

String enumName(Object o) {
  var text = o.toString();
  return text.substring(text.indexOf(".") + 1);
}

E Function(String k) stringToEnum<E>(Map<String, E> enumValue) {
  return (k) => enumValue.containsKey(k)
      ? enumValue[k]
      : throw ('No corresponding enum value');
}

typedef Function(T obj) ReturnPredicate<T>(T obj);
typedef bool InputPredicate<T>(T obj, T obj2);

ReturnPredicate<T> matcher<T>(InputPredicate<T> predicate) => (T orig) => (T i) => predicate(i, orig);

// (Note note) => (Note n) => n.key != null && n.key == note.key || n.title == note.title;
