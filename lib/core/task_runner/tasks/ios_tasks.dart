import '../args.dart';
import '../task.dart';

// final installIOS = TaskGroup(
//   condition: (o) => o.install == true,
//   tasks: [
//     LogTask((o) => 'Installing ${o.version} ${o.devicePrefix('on ')}'),
//     ProcessTask(
//       (_) => 'adb',
//       args: (o) => [...o.deviceArgs, 'install', '-r', o.apkPath],
//       onError: (o, e, stack) async {
//         TaskGroup(
//           tasks: [
//             LogTask.staticArgs(
//                 'Failed to install. Uninstalling old version...'),
//             ProcessTask.staticArgs(
//               'adb',
//               args: [...o.deviceArgs, 'uninstall', 'app.dungeonpaper'],
//             ),
//             LogTask.staticArgs('Installing new version...'),
//             ProcessTask.staticArgs(
//               'adb',
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
//       (_) => 'adb',
//       args: (o) => [...o.deviceArgs, 'push', o.apkPath, o.outputPath],
//     ),
//   ],
// );

final buildIOS = TaskGroup(
  condition: (o) => o.build == true,
  tasks: [
    LogTask((o) => 'Building iOS (APP)'),
    ProcessTask.staticArgs(
      'flutter',
      args: ['build', 'ios'],
    ),
  ],
);
final bundleIOS = TaskGroup(
  condition: (o) => o.bundle == true,
  tasks: [
    LogTask((o) => 'Building iOS Bundle (IPA)'),
    ProcessTask.staticArgs(
      'flutter',
      args: ['build', 'ipa'],
    ),
  ],
);

final iOS = DeviceTaskGroup(
  device: Device.iOS,
  tasks: [
    buildIOS,
    bundleIOS,
    // pushIOS,
    // installIOS,
  ],
);
