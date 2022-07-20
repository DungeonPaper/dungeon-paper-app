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

enum BumpType {
  pre,
  // build,
  patch,
  minor,
  major,
  none,
}

class ArgOptions {
  ArgOptions({
    this.help = false,
    this.test = false,
    this.build = false,
    this.bundle = false,
    this.push = false,
    this.install = false,
    this.bump = BumpType.none,
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
      bundle: res['bundle'],
      push: res['push'],
      bump: BumpType.values.firstWhere(
        (t) => t.name == res['bump'],
        orElse: () => BumpType.none,
      ),
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
  bool bundle;
  bool push;
  bool install;
  BumpType bump;
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
        'Bundle': bundle,
        'Push': push,
        'Install': install,
        'Bump': bump != BumpType.none,
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
    'bundle',
    abbr: 'u',
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
    'bump',
    abbr: 'm',
    defaultsTo: 'none',
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
