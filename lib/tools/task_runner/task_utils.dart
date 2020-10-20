import 'dart:io';
import 'package:path/path.dart';

String getVersionString() {
  final buildFile = File(
    join(
      dirname(Platform.script.path),
      join('..', '..', '..', 'pubspec.yaml'),
    ),
  );
  final contents = buildFile.readAsStringSync();
  final match = RegExp('version: (.+)').firstMatch(contents);
  if (match != null) {
    return match.group(1);
  }
  return null;
}

Map<K, List<V>> groupBy<K, V>(Iterable<V> list, K Function(V) predicate) {
  final out = <K, List<V>>{};
  for (final item in list) {
    final k = predicate(item);
    out[k] ??= <V>[];
    out[k].add(item);
  }
  return out;
}

String enumName(Object o) {
  var text = o.toString();
  return text.substring(text.indexOf('.') + 1);
}
