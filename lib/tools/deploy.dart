import 'dart:io';
import 'package:pedantic/pedantic.dart';
import 'package:args/args.dart';
import 'package:path/path.dart';
import 'package:pub_semver/pub_semver.dart';

class ArgOptions {
  bool test = true;
  bool build = true;
  bool push = false;
  bool install = false;
  bool help = false;
  Version version;
  String device;
  List<String> platforms = ['android-arm', 'android-arm64'];

  Map<String, bool> get actionables => Map<String, bool>.fromEntries([
        for (var key in mapLabels.keys)
          if (mapLabels[key] == true) MapEntry(key, true),
      ]);
  bool get hasActionables => actionables.isNotEmpty;
  String get deviceTxt => device != null ? '(device $device)' : '';
  List<String> get deviceParams => device != null ? ['-s', device] : [];
  Map<String, bool> get mapLabels => {
        'Test': test,
        'Build': build,
        'Push': push,
        'Install': install,
      };

  static Future<ArgOptions> parseArgs(List<String> args) async {
    var parser = ArgParser();
    var options = ArgOptions();

    parser.addFlag('test', abbr: 't', defaultsTo: options.test,
        callback: (val) {
      options.test = val;
    });
    parser.addFlag('build', abbr: 'b', defaultsTo: options.build,
        callback: (val) {
      options.build = val;
    });
    parser.addFlag('push', abbr: 'p', defaultsTo: options.push,
        callback: (val) {
      options.push = val;
    });
    parser.addFlag('install', abbr: 'i', defaultsTo: options.install,
        callback: (val) {
      options.install = val;
    });
    parser.addOption('version', abbr: 'v', defaultsTo: await getVersionString(),
        callback: (val) {
      options.version = Version.parse(val);
    });
    parser.addOption('device', abbr: 'd', defaultsTo: options.device,
        callback: (val) {
      options.device = val;
    });
    parser.addFlag('help', abbr: 'h', defaultsTo: options.help,
        callback: (val) {
      options.help = val;
    });

    parser.parse(args);
    return options;
  }
}

void main(List<String> args) async {
  var apkPath = 'build/app/outputs/apk/release/app-arm64-v8a-release.apk';
  var outputPath;
  var options = await ArgOptions.parseArgs(args);

  if (!options.hasActionables) {
    print('Nothing to do! Quitting.');
    exit(1);
  }

  var lst = options.mapLabels.keys
      .where((k) => options.mapLabels[k] == true)
      .toList();
  print([lst.getRange(0, lst.length - 1).join(', '), lst.last]
      .where((i) => i != null && i.isNotEmpty)
      .join(' & '));
  print('Version: ${options.version}');

  outputPath = '/sdcard/Download/dungeon-paper-${options.version}.apk';

  if (options.test) {
    print('Running tests...');
    var testProc = Process.start('flutter', ['test']);
    var testRun = await testProc;
    await stdout.addStream(testRun.stdout);
    testRun.stderr.listen((event) {
      print('Build failed: $event');
      throw Exception('Build failed');
    });
  }

  if (options.build) {
    print('Building...');
    var results = [
      Process.start('flutter', [
        'build',
        'appbundle',
        '--target-platform',
        options.platforms.join(',')
      ]),
      Process.start('flutter', [
        'build',
        'apk',
        '--target-platform',
        options.platforms.join(','),
        '--split-per-abi'
      ]),
    ];
    var outs = await Future.wait(results);
    for (var out in await outs) {
      await stdout.addStream(out.stdout);
      await stdout.addStream(out.stderr);
    }
  }

  if (options.push == true) {
    print('Pushing $apkPath to $outputPath... ${options.deviceTxt}');
    await Process.start(
        'adb', [...options.deviceParams, 'push', apkPath, outputPath]);
  }

  if (options.install == true) {
    print('Installing $outputPath... ${options.deviceTxt}');
    var result = await Process.start(
        'adb', [...options.deviceParams, 'install', '-r', apkPath]);
    await stdout.addStream(result.stdout);
    if (await result.exitCode != 0) {
      print('Uninstalling old version...');
      var uninstall = await Process.start(
          'adb', [...options.deviceParams, 'uninstall', 'app.dungeonpaper']);
      await stdout.addStream(uninstall.stdout);
      var install = await Process.start('adb', ['install', '-r', apkPath]);
      await stdout.addStream(install.stdout);
    }
  }

  print('Done!');
  unawaited(stdout.close());
}

Future<String> getVersionString() async {
  var buildFile = File(
      join(dirname(Platform.script.path), '../../android/app/build.gradle'));

  var contents = await buildFile.readAsString();
  var match = RegExp('versionName "(.+)"').firstMatch(contents);
  if (match != null) {
    return match.group(1);
  }
  return null;
}
