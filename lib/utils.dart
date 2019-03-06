import 'dart:math';

capitalize(String string, [String sep = ' ']) {
  return string.splitMapJoin(RegExp(sep),
      onMatch: (s) =>
          s.input[s.start].toUpperCase() +
          s.input.substring(s.start + 1, s.end),
      onNonMatch: (s) => s[0].toUpperCase() + s.substring(1));
}

T clamp<T extends num>(T number, T low, T high) => max(low, min(number, high));

Type typeOf<T>() => T;

String enumName(Object o) {
  var text = o.toString();
  return text.substring(text.indexOf(".") + 1);
}

E Function(String k) stringToEnum<E>(Map<String, E> enumValue) {
  return (k) => enumValue.containsKey(k) ? enumValue[k] : throw ('No corresponding enum value');
}
