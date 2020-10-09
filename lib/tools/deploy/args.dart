import 'package:args/args.dart';
import 'package:pub_semver/pub_semver.dart';

import 'deploy_utils.dart';

enum Device {
  android,
  iOS,
  web,
  macos,
  windows,
  linux,
}

class ArgOptions {
  bool help = false;
  bool test = false;
  bool build = false;
  bool push = false;
  bool install = false;
  String device;
  Version version;
  Device platform = Device.android;

  String get outputPath => '/sdcard/Download/dungeon-paper-${version}.apk';
  String get apkPath =>
      'build/app/outputs/apk/release/app-arm64-v8a-release.apk';

  List<String> get deviceArgs => device != null ? ['-s', device] : [];

  Map<String, bool> get actionables => <String, bool>{
        for (var key in mapLabels.keys)
          if (mapLabels[key] == true) key: true,
      };

  bool get hasActionables => actionables.isNotEmpty;

  List<String> get deviceParams => device != null ? ['-s', device] : [];
  Map<String, bool> get mapLabels => {
        'Test': test,
        'Build': build,
        'Push': push,
        'Install': install,
      };

  ArgOptions.fromArgs(List<String> args) {
    final parser = ArgParser();
    parser.addFlag(
      'test',
      abbr: 't',
      defaultsTo: false,
      callback: (val) => test = val,
    );

    parser.addFlag(
      'build',
      abbr: 'b',
      defaultsTo: false,
      callback: (val) => build = val,
    );

    parser.addFlag(
      'push',
      abbr: 'p',
      defaultsTo: false,
      callback: (val) => push = val,
    );

    parser.addFlag(
      'install',
      abbr: 'i',
      defaultsTo: false,
      callback: (val) => install = val,
    );

    parser.addOption(
      'version',
      abbr: 'v',
      defaultsTo: getVersionString(),
      callback: (val) => version = Version.parse(val),
    );

    parser.addOption(
      'device',
      abbr: 'd',
      defaultsTo: null,
      callback: (val) => device = val,
    );

    parser.addFlag(
      'help',
      abbr: 'h',
      defaultsTo: false,
      callback: (val) => help = val,
    );

    parser.parse(args);
  }
}
