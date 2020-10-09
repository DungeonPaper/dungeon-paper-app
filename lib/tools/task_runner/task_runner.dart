import 'args.dart';
import 'task.dart';

class TaskRunner {
  final List<Task> tasks;
  final ArgOptions options;

  TaskRunner({
    this.tasks,
    this.options,
  });

  Future<void> runAll() async {
    await _runTasksMain();
  }

  Future<void> _runTasksMain() async {
    for (final task in tasks) {
      if (task.condition == null || task.condition(options)) {
        await task.run(options);
      }
    }
  }
}
