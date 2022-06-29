import '../args.dart';
import '../task.dart';

final installAndroid = TaskGroup(
  condition: (o) => o.install == true,
  tasks: [
    LogTask((o) => 'Installing ${o.version} ${o.devicePrefix('on ')}'),
    ProcessTask(
      (_) => 'adb',
      args: (o) => [...o.deviceArgs, 'install', '-r', o.localOutputPath],
      onError: (o, e, stack) async {
        TaskGroup(
          tasks: [
            LogTask.staticArgs('Failed to install. Uninstalling old version...'),
            ProcessTask.staticArgs(
              'adb',
              args: [...o.deviceArgs, 'uninstall', 'app.dungeonpaper'],
            ),
            LogTask.staticArgs('Installing new version...'),
            ProcessTask.staticArgs(
              'adb',
              args: [...o.deviceArgs, 'install', '-r', o.localOutputPath],
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
    LogTask((o) => 'Pushing to ${o.deviceFilePath}'),
    ProcessTask(
      (_) => 'adb',
      args: (o) => [...o.deviceArgs, 'push', o.localOutputPath, o.deviceFilePath],
    ),
  ],
);

final bundleAndroid = TaskGroup(
  condition: (o) => o.bundle == true,
  tasks: [
    LogTask((o) => 'Building App Bundle'),
    ProcessTask.staticArgs(
      'flutter',
      args: ['build', 'appbundle', '--target-platform', 'android-arm,android-arm64,android-x64'],
    ),
  ],
);

final buildAndroid = TaskGroup(
  condition: (o) => o.build == true,
  tasks: [
    LogTask((o) => 'Building APK'),
    ProcessTask.staticArgs(
      'flutter',
      args: ['build', 'apk', '--split-per-abi'],
    ),
  ],
);

final android = DeviceTaskGroup(
  device: Device.android,
  tasks: [
    buildAndroid,
    bundleAndroid,
    pushAndroid,
    installAndroid,
  ],
);
