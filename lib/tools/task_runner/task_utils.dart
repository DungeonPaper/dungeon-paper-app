import 'dart:io';
import 'package:path/path.dart';

String getVersionString() {
  final buildFile = File(
    join(
      dirname(Platform.script.path),
      join('..', '..', '..', 'android', 'app', 'build.gradle'),
    ),
  );
  final contents = buildFile.readAsStringSync();
  final match = RegExp('versionName "(.+)"').firstMatch(contents);
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
