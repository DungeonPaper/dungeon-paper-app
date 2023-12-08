import 'dart:io';
import 'package:dungeon_paper/core/task_runner/args.dart';
import 'package:path/path.dart';
import 'package:pub_semver/pub_semver.dart';

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

Version getBumpedVersion(ArgOptions o) {
  Version version = o.version;
  switch (o.bump) {
    case BumpType.none:
      version = Version(
        o.version.major,
        o.version.minor,
        o.version.patch,
        pre: o.version.preRelease.isEmpty
            ? null
            : o.version.preRelease.join('.'),
        build: o.version.build.isEmpty
            ? null
            : o.version.build
                .map((part) => part is String ? part : (part as num) + 1)
                .join('.'),
      );
      break;
    case BumpType.major:
      version = version.nextMajor;
      break;
    case BumpType.minor:
      version = version.nextMinor;
      break;
    case BumpType.patch:
      version = version.nextPatch;
      break;
    case BumpType.pre:
      version = Version(
        o.version.major,
        o.version.minor,
        o.version.patch,
        pre: o.version.preRelease.isEmpty
            ? null
            : o.version.preRelease
                .map((part) => part is String ? part : (part as num) + 1)
                .join('-'),
        build: o.version.build.isEmpty
            ? null
            : o.version.build
                .map((part) => part is String ? part : (part as num) + 1)
                .join('-'),
      );
      break;
  }
  return version;
}
