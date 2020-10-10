import 'dart:async';
import 'dart:io';
import 'args.dart';
import 'task_runner.dart';

class Task {
  final bool Function(ArgOptions) condition;
  final FutureOr<void> Function(ArgOptions) run;

  Task({
    this.condition,
    this.run,
  });
}

class TaskGroup extends Task {
  final List<Task> tasks;

  TaskGroup({
    bool Function(ArgOptions) condition,
    this.tasks,
  }) : super(
          condition: condition,
          run: _runTasks(tasks),
        );

  TaskGroup.staticArgs({
    bool condition,
    this.tasks,
  }) : super(
          condition: (_) => condition,
          run: _runTasks(tasks),
        );

  static FutureOr<void> Function(ArgOptions) _runTasks(List<Task> tasks) =>
      (options) => _runner(options, tasks).runAll();

  static TaskRunner _runner(ArgOptions options, List<Task> tasks) => TaskRunner(
        options: options,
        tasks: tasks,
      );
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
          run: _runProcess(process, args, onError),
        );

  factory ProcessTask.staticArgs({
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
        final exitCode = await result.exitCode;
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
  }) : super(
          condition: condition,
          run: _run(message),
        );

  LogTask.staticArgs(
    String message, {
    bool Function(ArgOptions) condition,
  }) : super(
          condition: condition,
          run: _run((o) => message),
        );

  static Future<void> Function(ArgOptions) _run(
    FutureOr<String> Function(ArgOptions) message,
  ) {
    return (o) async {
      print(await message(o));
    };
  }
}
