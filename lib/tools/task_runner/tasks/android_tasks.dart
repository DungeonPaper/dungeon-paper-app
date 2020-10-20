import '../args.dart';
import '../task.dart';

final installAndroid = TaskGroup(
  condition: (o) => o.install == true,
  tasks: [
    LogTask((o) => 'Installing ${o.version} ${o.devicePrefix('on ')}'),
    ProcessTask(
      process: (_) => 'adb',
      args: (o) => [...o.deviceArgs, 'install', '-r', o.apkPath],
      onError: (o, e, stack) async {
        TaskGroup(
          tasks: [
            LogTask.staticArgs(
                'Failed to install. Uninstalling old version...'),
            ProcessTask.staticArgs(
              process: 'adb',
              args: [...o.deviceArgs, 'uninstall', 'app.dungeonpaper'],
            ),
            LogTask.staticArgs('Installing new version...'),
            ProcessTask.staticArgs(
              process: 'adb',
              args: [...o.deviceArgs, 'install', '-r', o.apkPath],
            ),
          ],
        ).run(o);
      },
    ),
  ],
);

final pushAndroid = TaskGroup(
  condition: (o) => o.push == true,
  tasks: [
    LogTask((o) => 'Pushing to ${o.outputPath}'),
    ProcessTask(
      process: (_) => 'adb',
      args: (o) => [...o.deviceArgs, 'push', o.apkPath, o.outputPath],
    ),
  ],
);

final buildAndroid = TaskGroup(
  condition: (o) => o.build == true,
  tasks: [
    LogTask((o) => 'Building App Bundle'),
    ProcessTask.staticArgs(
      process: 'flutter',
      args: [
        'build',
        'appbundle',
        '--target-platform',
        'android-arm,android-arm64,android-x64'
      ],
    ),
    LogTask((o) => 'Building APK'),
    ProcessTask.staticArgs(
      process: 'flutter',
      args: ['build', 'apk', '--split-per-abi'],
    ),
  ],
);

final android = DeviceTaskGroup(
  device: Device.android,
  tasks: [
    buildAndroid,
    pushAndroid,
    installAndroid,
  ],
);
