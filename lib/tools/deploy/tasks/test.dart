import 'dart:io';
import '../task.dart';

final testTask = TaskGroup(
  condition: (o) => o.test == true,
  tasks: [
    LogTask((o) => 'Testing: ${o.test.toString()}'),
    Task(
      run: (o) async {
        print('Running tests...');
        var testProc = Process.start('flutter', ['test']);
        var testRun = await testProc;
        await stdout.addStream(testRun.stdout);
        testRun.stderr.listen((event) {
          throw Exception('Test failed');
        });
      },
    ),
  ],
);
