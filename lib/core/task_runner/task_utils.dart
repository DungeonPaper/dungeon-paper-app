import 'dart:io';
import 'package:path/path.dart';

final _pubspecFile = File(
  join(
    dirname(Platform.script.path),
    join('..', '..', '..', 'pubspec.yaml'),
  ),
);

String getVersionString() {
  final contents = _pubspecFile.readAsStringSync();
  final match = RegExp('version: (.+)').firstMatch(contents);
  return match!.group(1)!;
}

String getAppName() {
  final contents = _pubspecFile.readAsStringSync();
  final match = RegExp('name: (.+)').firstMatch(contents);
  return match!.group(1)!;
}

Map<K, List<V>> groupBy<K, V>(Iterable<V> list, K Function(V) predicate) {
  final out = <K, List<V>>{};
  for (final item in list) {
    final k = predicate(item);
    out[k] ??= <V>[];
    out[k]!.add(item);
  }
  return out;
}

String enumName(Object o) {
  var text = o.toString();
  return text.substring(text.indexOf('.') + 1);
}
