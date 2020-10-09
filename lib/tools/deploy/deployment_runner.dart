import 'args.dart';
import 'task.dart';

class DeploymentRunner {
  final List<Task> tasks;
  final ArgOptions options;

  DeploymentRunner({
    this.tasks,
    this.options,
  });

  Future<void> runAll() async {
    await _runBeforeAll();
    await _runTasksMain();
    await _runAfterAll();
  }

  Future<void> _runTasksMain() async {
    for (final task in tasks) {
      if (task.condition == null || task.condition(options)) {
        await task.run(options);
      }
    }
  }

  Future<void> _runAfterAll() async {
    for (final task in tasks) {
      if (task.condition == null || task.condition(options)) {
        await task.afterAll?.call(options);
      }
    }
  }

  Future<void> _runBeforeAll() async {
    for (final task in tasks) {
      if (task.condition == null || task.condition(options)) {
        await task.beforeAll?.call(options);
      }
    }
  }
}
