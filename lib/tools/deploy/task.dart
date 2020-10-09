import 'dart:async';
import 'dart:io';
import 'args.dart';
import 'deployment_runner.dart';

class Task {
  final bool Function(ArgOptions) condition;
  final FutureOr<void> Function(ArgOptions) run;
  final FutureOr<void> Function(ArgOptions) beforeAll;
  final FutureOr<void> Function(ArgOptions) afterAll;

  Task({
    this.condition,
    this.run,
    this.beforeAll,
    this.afterAll,
  });
}

class TaskGroup extends Task {
  final List<Task> tasks;

  TaskGroup({
    bool Function(ArgOptions) condition,
    FutureOr<void> Function(ArgOptions) beforeAll,
    FutureOr<void> Function(ArgOptions) afterAll,
    this.tasks,
  }) : super(
          afterAll: afterAll,
          beforeAll: beforeAll,
          condition: condition,
          run: _runTasks(tasks),
        );

  static FutureOr<void> Function(ArgOptions) _runTasks(
    List<Task> tasks,
  ) {
    return (options) => _runner(options, tasks).runAll();
  }

  static DeploymentRunner _runner(
    ArgOptions options,
    List<Task> tasks,
  ) {
    return DeploymentRunner(
      options: options,
      tasks: tasks,
    );
  }
}

class ProcessTask extends Task {
  ProcessTask({
    FutureOr<String> Function(ArgOptions) process,
    FutureOr<List<String>> Function(ArgOptions) args,
    bool Function(ArgOptions) condition,
    FutureOr<void> Function(ArgOptions) beforeAll,
    FutureOr<void> Function(ArgOptions) afterAll,
    FutureOr<void> Function(ArgOptions, Error, StackTrace) onError,
  }) : super(
          condition: condition,
          beforeAll: beforeAll,
          afterAll: afterAll,
          run: _runProcess(process, args, onError),
        );

  factory ProcessTask.syncArgs({
    String process,
    List<String> args,
    bool Function(ArgOptions) condition,
    FutureOr<void> Function(ArgOptions) beforeAll,
    FutureOr<void> Function(ArgOptions) afterAll,
    FutureOr<void> Function(ArgOptions, Error, StackTrace) onError,
  }) =>
      ProcessTask(
        process: (_) => Future.value(process),
        args: (_) => Future.value(args),
        condition: condition,
        beforeAll: beforeAll,
        afterAll: afterAll,
      );

  static FutureOr<void> Function(ArgOptions) _runProcess(
    FutureOr<String> Function(ArgOptions) process,
    FutureOr<List<String>> Function(ArgOptions) args,
    FutureOr<void> Function(ArgOptions, Error, StackTrace) onError,
  ) =>
      (o) async {
        final _process = await process(o);
        final _args = await args(o);
        print('Running process: $_process "${_args.join('\" \"')}"');
        final result = await Process.start(_process, _args);
        await stdout.addStream(result.stdout);
        await stdout.addStream(result.stderr);
        var exitCode = await result.exitCode;
        if (exitCode != 0) {
          final stack = StackTrace.current;
          final e = StateError('Process exited with error code: $exitCode');
          if (onError != null) {
            onError(o, e, stack);
          } else {
            throw e;
          }
        }
      };
}

class LogTask extends Task {
  LogTask(
    FutureOr<String> Function(ArgOptions) message, {
    bool Function(ArgOptions) condition,
    FutureOr<void> Function(ArgOptions) beforeAll,
    FutureOr<void> Function(ArgOptions) afterAll,
  }) : super(
          condition: condition,
          beforeAll: beforeAll,
          afterAll: afterAll,
          run: _run(message),
        );

  static Future<void> Function(ArgOptions) _run(
    FutureOr<String> Function(ArgOptions) message,
  ) {
    return (o) async {
      print(await message(o));
    };
  }
}
