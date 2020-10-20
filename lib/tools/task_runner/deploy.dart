import 'args.dart';
import 'task.dart';
import 'task_runner.dart';
import 'tasks/android_tasks.dart';
import 'tasks/ios_tasks.dart';
import 'tasks/test_task.dart';

void main(List<String> args) {
  TaskRunner(
    options: ArgOptions.fromArgs(args),
    tasks: [
      LogTask((o) {
        if (!o.hasActionables) {
          throw Exception('No actions to perform');
        }
        final lst =
            o.mapLabels.keys.where((k) => o.mapLabels[k] == true).toList();
        final msg = [
          [lst.getRange(0, lst.length - 1).join(', '), lst.last]
                  .where((i) => i != null && i.isNotEmpty)
                  .join(' & ') +
              (lst.length == 1 ? ' Only' : ''),
          'Version: ${o.version}',
        ];
        return msg.join('\n');
      }),
      testTask,
      android,
      iOS,
    ],
  ).runAll();
}
