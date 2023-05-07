import '../args.dart';
import '../task.dart';

final buildMacOS = TaskGroup(
  condition: (o) => o.build == true,
  tasks: [
    LogTask((o) => 'Building macOS (APP)'),
    ProcessTask.staticArgs(
      'flutter',
      args: ['build', 'macos'],
    ),
  ],
);

final macOS = DeviceTaskGroup(
  device: Device.macos,
  tasks: [
    buildMacOS,
    // pushIOS,
    // installIOS,
  ],
);
