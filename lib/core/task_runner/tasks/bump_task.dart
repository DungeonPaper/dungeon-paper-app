import 'dart:io';

import 'package:dungeon_paper/core/task_runner/task_utils.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:path/path.dart' as path;

import '../args.dart';
import '../task.dart';

final bumpTask = TaskGroup(
  tasks: [
    LogTask((o) => 'Bumping version'),
    Task(
      run: (o) {
        final pubspecPath = path.join(Directory.current.path, 'pubspec.yaml');
        final pubspec = File(pubspecPath).readAsStringSync();
        var version = o.version;
        switch (o.bump) {
          case BumpType.none:
            version = Version(
              o.version.major,
              o.version.minor,
              o.version.patch,
              pre: o.version.preRelease.isEmpty ? null : o.version.preRelease.join('.'),
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
        final newPubspec = pubspec.replaceFirst(
          RegExp('version: .+'),
          'version: $version',
        );
        File(pubspecPath).writeAsStringSync(newPubspec);
      },
      // condition: (o) => o.bump != BumpType.none,
    ),
  ],
);
