import 'dart:io';

import 'package:dungeon_paper/core/task_runner/task_utils.dart';
import 'package:path/path.dart' as path;

import '../task.dart';

final bumpTask = TaskGroup(
  tasks: [
    LogTask((o) => 'Bumping version'),
    Task(
      run: (o) {
        final pubspecPath = path.join(Directory.current.path, 'pubspec.yaml');
        final pubspec = File(pubspecPath).readAsStringSync();
        final version = o.version;
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
