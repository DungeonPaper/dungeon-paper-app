import '../args.dart';
import '../task.dart';

// final installIOS = TaskGroup(
//   condition: (o) => o.install == true,
//   tasks: [
//     LogTask((o) => 'Installing ${o.version} ${o.devicePrefix('on ')}'),
//     ProcessTask(
//       process: (_) => 'adb',
//       args: (o) => [...o.deviceArgs, 'install', '-r', o.apkPath],
//       onError: (o, e, stack) async {
//         TaskGroup(
//           tasks: [
//             LogTask.staticArgs(
//                 'Failed to install. Uninstalling old version...'),
//             ProcessTask.staticArgs(
//               process: 'adb',
//               args: [...o.deviceArgs, 'uninstall', 'app.dungeonpaper'],
//             ),
//             LogTask.staticArgs('Installing new version...'),
//             ProcessTask.staticArgs(
//               process: 'adb',
//               args: [...o.deviceArgs, 'install', '-r', o.apkPath],
//             ),
//           ],
//         ).run(o);
//       },
//     ),
//   ],
// );

// final pushIOS = TaskGroup(
//   condition: (o) => o.push == true,
//   tasks: [
//     LogTask((o) => 'Pushing to ${o.outputPath}'),
//     ProcessTask(
//       process: (_) => 'adb',
//       args: (o) => [...o.deviceArgs, 'push', o.apkPath, o.outputPath],
//     ),
//   ],
// );

final buildIOS = TaskGroup(
  condition: (o) => o.build == true,
  tasks: [
    LogTask((o) => 'Building iOS'),
    ProcessTask.staticArgs(
      process: 'flutter',
      args: [
        'build',
        'ios',
        // '--release-name',
        // '--release-number',
      ],
    ),
  ],
);

final iOS = DeviceTaskGroup(
  device: Device.iOS,
  tasks: [
    buildIOS,
    // pushIOS,
    // installIOS,
  ],
);
