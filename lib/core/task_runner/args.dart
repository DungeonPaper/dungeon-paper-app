import 'package:args/args.dart';
import 'package:pub_semver/pub_semver.dart';

import 'task_utils.dart';

enum Device {
  all,
  android,
  iOS,
  web,
  macos,
  windows,
  linux,
}

class ArgOptions {
  ArgOptions({
    this.help = false,
    this.test = true,
    this.build = true,
    this.push = true,
    this.install = true,
    required this.device,
    Version? version,
    this.platform = Device.all,
    String? outputFilePrefix,
  })  : version = version ?? Version.parse(getVersionString()),
        outputFilePrefix = outputFilePrefix ?? getAppName();

  final parser = argParser;

  factory ArgOptions.fromArgs(List<String> args) {
    final res = argParser.parse(args);
    return ArgOptions(
      device: res['device'],
      version: Version.parse(res['version']),
      help: res['help'],
      test: res['test'],
      build: res['build'],
      push: res['push'],
      install: res['install'],
      platform: Device.values.firstWhere(
        (device) => enumName(device).toLowerCase() == res['platform'].toString().toLowerCase(),
        orElse: () => Device.android,
      ),
      outputFilePrefix: getAppName(),
    );
  }

  bool help;
  bool test;
  bool build;
  bool push;
  bool install;
  String? device;
  String outputFilePrefix;
  Version version;
  Device platform = Device.android;

  String get deviceFilePath => '/sdcard/Download/$outputFilePrefix-$version.apk';

  String get localOutputPath => 'build/app/outputs/apk/release/app-arm64-v8a-release.apk';

  List<String> get deviceArgs => device != null ? ['-s', device!] : [];

  String devicePrefix(String prefix) => device != null ? '$prefix $device' : '';

  Map<String, bool> get actionables => <String, bool>{
        for (var key in mapLabels.keys)
          if (mapLabels[key] == true) key: true,
      };

  bool get hasActionables => actionables.isNotEmpty;

  List<String> get deviceParams => device != null ? ['-s', device!] : [];
  Map<String, bool> get mapLabels => {
        'Test': test,
        'Build': build,
        'Push': push,
        'Install': install,
      };
}

final argParser = ArgParser()
  ..addFlag(
    'test',
    abbr: 't',
    defaultsTo: false,
  )
  ..addFlag(
    'build',
    abbr: 'b',
    defaultsTo: false,
  )
  ..addFlag(
    'push',
    abbr: 'p',
    defaultsTo: false,
  )
  ..addFlag(
    'install',
    abbr: 'i',
    defaultsTo: false,
  )
  ..addOption(
    'version',
    abbr: 'v',
    defaultsTo: getVersionString(),
  )
  ..addOption(
    'output-filename',
    abbr: 'f',
    defaultsTo: getAppName(),
  )
  ..addOption(
    'device',
    abbr: 'd',
    defaultsTo: null,
  )
  ..addOption(
    'platform',
    abbr: 'l',
    defaultsTo: enumName(Device.android),
    allowed: Device.values.map((d) => enumName(d).toLowerCase()),
  )
  ..addFlag(
    'help',
    abbr: 'h',
    defaultsTo: false,
  );
