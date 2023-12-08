// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'args.dart';

class Task<T> {
  final bool Function(T)? condition;
  final T? options;
  final FutureOr<void> Function(T) _run;

  Task({
    this.condition,
    required FutureOr<void> Function(T) run,
    this.options,
  }) : _run = run;

  factory Task.staticArgs({
    bool? condition,
    required FutureOr<void> Function() run,
    required T options,
  }) =>
      Task(
        condition: condition != null ? (_) => condition : null,
        run: (_) => run(),
        options: options,
      );

  FutureOr<void> dispose() {}

  FutureOr<void> run([T? options]) async {
    assert(options != null || this.options != null,
        'Options must be passed either in constructor or to run options.');
    await _run(options ?? this.options!);
    dispose();
  }
}

class TaskGroup extends Task<ArgOptions> {
  final List<Task<ArgOptions>> tasks;

  TaskGroup({
    bool Function(ArgOptions)? condition,
    required this.tasks,
    ArgOptions? options,
  }) : super(
          condition: condition,
          run: _runTasks(tasks, options, condition),
          options: options,
        );

  TaskGroup.staticArgs({
    bool? condition,
    required this.tasks,
    required ArgOptions options,
  }) : super(
          condition: condition != null ? (_) => condition : null,
          run: _runTasks(
            tasks,
            options,
            condition != null ? (_) => condition : null,
          ),
          options: options,
        );

  @override
  FutureOr<void> run([ArgOptions? options]) {
    assert(options != null || this.options != null,
        'Options must be passed either in constructor or to run options.');
    return _runTasks(tasks, options ?? this.options!, condition)
        .call(options ?? this.options!);
  }

  static Future<void> Function(ArgOptions?) _runTasks(
    List<Task<ArgOptions>> tasks,
    ArgOptions? options,
    bool Function(ArgOptions)? condition,
  ) {
    return (overrideOptions) async {
      assert(options != null || overrideOptions != null,
          'Options must be passed either in constructor or to run options.');
      for (final task in tasks) {
        if (condition?.call(options ?? overrideOptions!) != false &&
            task.condition?.call(options ?? overrideOptions!) != false) {
          await task.run(options);
        }
      }
    };
  }

  @override
  void dispose() {
    for (final task in tasks) {
      if (task.condition?.call(options!) != false) {
        task.dispose();
      }
    }
    super.dispose();
  }
}

class DeviceTaskGroup extends TaskGroup {
  DeviceTaskGroup({
    required Device device,
    required List<Task<ArgOptions>> tasks,
    bool Function(ArgOptions)? condition,
    ArgOptions? options,
  }) : super(
          condition: condition != null
              ? (o) =>
                  condition.call(o) != false && _isDeviceIncluded(o, device)
              : (o) => _isDeviceIncluded(o, device),
          tasks: tasks,
          options: options,
        );

  DeviceTaskGroup.staticArgs({
    required Device device,
    required List<Task<ArgOptions>> tasks,
    bool? condition,
    ArgOptions? options,
  }) : super(
          condition: (o) => condition != false && _isDeviceIncluded(o, device),
          tasks: tasks,
          options: options,
        );

  static bool _isDeviceIncluded(ArgOptions o, Device device) =>
      o.platform == Device.all || o.platform == device;
}

class ProcessTask extends Task<ArgOptions> {
  ProcessTask(
    FutureOr<String> Function(ArgOptions) process, {
    FutureOr<List<String>> Function(ArgOptions)? args,
    bool Function(ArgOptions)? condition,
    ArgOptions? options,
    FutureOr<void> Function(ArgOptions)? beforeAll,
    FutureOr<void> Function(ArgOptions)? afterAll,
    FutureOr<void> Function(ArgOptions, Exception, StackTrace)? onError,
  }) : super(
          condition: condition,
          run: _runProcess(process, args, onError),
          options: options,
        );

  factory ProcessTask.staticArgs(
    String process, {
    List<String>? args,
    bool? condition,
    FutureOr<void> Function(ArgOptions)? beforeAll,
    FutureOr<void> Function(ArgOptions)? afterAll,
    FutureOr<void> Function(ArgOptions, Error, StackTrace)? onError,
    ArgOptions? options,
  }) =>
      ProcessTask(
        (_) => process,
        args: args != null ? (_) => args : null,
        condition: condition != null ? (_) => condition : null,
        beforeAll: beforeAll,
        afterAll: afterAll,
        options: options,
      );

  static FutureOr<void> Function(ArgOptions) _runProcess(
    FutureOr<String> Function(ArgOptions) process,
    FutureOr<List<String>> Function(ArgOptions)? args,
    FutureOr<void> Function(ArgOptions, Exception, StackTrace)? onError,
  ) =>
      (o) async {
        final _process = await process(o);
        final _args = await (args?.call(o) ?? <String>[]);
        final _argsStr =
            _args.map((a) => a.contains(' ') ? '"$a"' : a).join(' ');
        print('\n\nRunning process: $_process $_argsStr\n\n');
        try {
          final result = await Process.run(_process, _args);
          stdout.write(result.stdout);
          stdout.write(result.stderr);
          final exitCode = result.exitCode;
          if (exitCode != 0) {
            final stack = StackTrace.current;
            final e = ProcessException(_process, _args,
                'Process exited with error code: $exitCode', exitCode);
            _handleError(o, e, stack, onError);
          }
        } catch (e, stack) {
          _handleError(o, e as Exception, stack, onError);
        }
      };

  @override
  void dispose() async {
    await stdout.flush();
    await stderr.flush();
    super.dispose();
  }

  static void _handleError(
    ArgOptions o,
    Exception e,
    StackTrace stack,
    FutureOr<void> Function(ArgOptions, Exception, StackTrace)? onError,
  ) {
    if (onError != null) {
      onError(o, e, stack);
    } else {
      throw e;
    }
  }
}

class LogTask extends Task<ArgOptions> {
  LogTask(
    FutureOr<String> Function(ArgOptions) message, {
    bool Function(ArgOptions)? condition,
    ArgOptions? options,
  }) : super(
          condition: condition,
          run: _log(message),
          options: options,
        );

  LogTask.staticArgs(
    String message, {
    bool Function(ArgOptions)? condition,
    ArgOptions? options,
  }) : super(
          condition: condition,
          run: _log((o) => message),
          options: options,
        );

  FutureOr<void> log(String message) => _log((o) => message);

  static Future<void> Function(ArgOptions) _log(
    FutureOr<String> Function(ArgOptions) message,
  ) =>
      (o) async => print(await message(o));
}
