import '../args.dart';
import '../task.dart';

final installAndroid = TaskGroup(
  condition: (o) => o.install == true,
  beforeAll: (o) => print('Installing: ${o.install}'),
  tasks: [
    LogTask((o) => 'Installing ${o.device}'),
    ProcessTask(
        process: (_) => 'adb',
        args: (o) => [...o.deviceArgs, 'install', '-r', o.apkPath],
        onError: (o, e, stack) async {
          await ProcessTask.syncArgs(
            process: 'adb',
            args: [...o.deviceArgs, 'uninstall', 'app.dungeonpaper'],
          ).run(o);
          await ProcessTask.syncArgs(
            process: 'adb',
            args: [...o.deviceArgs, 'install', 'app.dungeonpaper'],
          ).run(o);
        }),
  ],
);

final pushAndroid = TaskGroup(
  condition: (o) => o.push == true,
  beforeAll: (o) => print('Pushing: ${o.push}'),
  tasks: [
    LogTask((o) => 'Pushing ${o.outputPath}'),
    ProcessTask(
      process: (_) => 'adb',
      args: (o) => [...o.deviceArgs, 'push', o.apkPath, o.outputPath],
    ),
  ],
);

final buildAndroid = TaskGroup(
  condition: (o) => o.build == true,
  beforeAll: (o) => print('Building: ${o.build}'),
  tasks: [
    LogTask((o) => 'Building: ${o.build.toString()}'),
    ProcessTask.syncArgs(
      process: 'flutter',
      args: [
        'build',
        'appbundle',
        '--target-platform',
        'android-arm,android-arm64,android-x64'
      ],
    ),
    ProcessTask.syncArgs(
      process: 'flutter',
      args: ['build', 'apk', '--split-per-abi'],
    ),
  ],
);

final android = TaskGroup(
  condition: (o) => o.platform == Device.android,
  tasks: [
    buildAndroid,
    pushAndroid,
    installAndroid,
  ],
);
