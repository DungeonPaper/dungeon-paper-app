// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dungeon_paper/core/task_runner/tasks/macos_tasks.dart';

import 'args.dart';
import 'task.dart';
import 'task_utils.dart';
import 'tasks/android_tasks.dart';
import 'tasks/bump_task.dart';
import 'tasks/ios_tasks.dart';
import 'tasks/test_task.dart';
import 'tasks/web_tasks.dart';

void main(List<String> args) {
  final options = ArgOptions.fromArgs(args);

  final logTask = LogTask(
    options: options,
    (o) {
      if (!o.hasActionables) {
        if (o.help) {
          print(o.parser.usage);
          exit(0);
        }
        throw Exception('No actions to perform');
      }
      final lst = o.mapLabels.keys.where((k) => o.mapLabels[k] == true).toList();
      final msg = [
        [lst.getRange(0, lst.length - 1).join(', '), lst.last].where((i) => i.isNotEmpty).join(' & ') +
            (lst.length == 1 ? ' Only' : ''),
        if (o.build == true) 'Platform: ${enumName(o.platform)}',
        'Version: ${o.version}',
      ];
      return msg.join('\n');
    },
  );

  TaskGroup(
    options: options,
    tasks: [
      logTask,
      bumpTask,
      testTask,
      android,
      iOS,
      macOS,
      web,
    ],
  ).run();
}
