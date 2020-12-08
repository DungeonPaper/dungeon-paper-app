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
    this.device,
    Version version,
    this.platform = Device.all,
    String outputFilePrefix,
  })  : version = version ?? Version.parse(getVersionString()),
        outputFilePrefix = outputFilePrefix ?? getAppName() ?? 'flutter_app';

  ArgOptions.fromArgs(List<String> args) {
    parser.parse(args);
  }

  bool help;
  bool test;
  bool build;
  bool push;
  bool install;
  String device;
  String outputFilePrefix;
  Version version;
  Device platform = Device.android;

  String get deviceFilePath =>
      '/sdcard/Download/$outputFilePrefix-$version.apk';

  String get localOutputPath =>
      'build/app/outputs/apk/release/app-arm64-v8a-release.apk';

  List<String> get deviceArgs => device != null ? ['-s', device] : [];

  String devicePrefix(String prefix) => device != null ? '$prefix $device' : '';

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

  ArgParser _parser;
  ArgParser get parser {
    // ignore: unnecessary_null_comparison
    if (_parser != null) {
      return _parser;
    }
    _parser = _createArgParser();
    return _parser;
  }

  ArgParser _createArgParser() => ArgParser()
    ..addFlag(
      'test',
      abbr: 't',
      defaultsTo: false,
      callback: (val) => test = val,
    )
    ..addFlag(
      'build',
      abbr: 'b',
      defaultsTo: false,
      callback: (val) => build = val,
    )
    ..addFlag(
      'push',
      abbr: 'p',
      defaultsTo: false,
      callback: (val) => push = val,
    )
    ..addFlag(
      'install',
      abbr: 'i',
      defaultsTo: false,
      callback: (val) => install = val,
    )
    ..addOption(
      'version',
      abbr: 'v',
      defaultsTo: getVersionString(),
      callback: (val) => version = Version.parse(val),
    )
    ..addOption(
      'output-filename',
      abbr: 'f',
      defaultsTo: getAppName(),
      callback: (val) => outputFilePrefix = val,
    )
    ..addOption(
      'device',
      abbr: 'd',
      defaultsTo: null,
      callback: (val) => device = val,
    )
    ..addOption(
      'platform',
      abbr: 'l',
      defaultsTo: enumName(Device.android),
      allowed: Device.values.map((d) => enumName(d).toLowerCase()),
      callback: (val) => platform = Device.values.firstWhere(
        (device) =>
            enumName(device).toLowerCase() == val.toString().toLowerCase(),
        orElse: () => Device.android,
      ),
    )
    ..addFlag(
      'help',
      abbr: 'h',
      defaultsTo: false,
      callback: (val) => help = val,
    );
}
