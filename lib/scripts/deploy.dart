import 'dart:io';
import 'package:pedantic/pedantic.dart';
import 'package:args/args.dart';
import 'package:path/path.dart';
import 'package:pub_semver/pub_semver.dart';

ArgParser parser = ArgParser();

void main(List<String> args) async {
  var doTest = true;
  var doBuild = true;
  var doPush = false;
  var doInstall = false;
  String device;
  Version version;
  var platforms = ['android-arm', 'android-arm64'];
  var apkPath = 'build/app/outputs/apk/release/app-arm64-v8a-release.apk';
  var outputPath;

  parser.addFlag('test', abbr: 't', defaultsTo: doTest, callback: (val) {
    doTest = val;
  });
  parser.addFlag('build', abbr: 'b', defaultsTo: doBuild, callback: (val) {
    doBuild = val;
  });
  parser.addFlag('push', abbr: 'p', defaultsTo: doPush, callback: (val) {
    doPush = val;
  });
  parser.addFlag('install', abbr: 'i', defaultsTo: doInstall, callback: (val) {
    doInstall = val;
  });
  parser.addOption('version', abbr: 'v', defaultsTo: await getVersionString(),
      callback: (val) {
    version = Version.parse(val);
  });
  parser.addOption('device', abbr: 'd', defaultsTo: null, callback: (val) {
    device = val;
  });

  parser.parse(args);

  if (![doBuild, doPush, doInstall].any((v) => v == true)) {
    print('Nothing to do! Quitting.');
    exit(1);
  }

  var strs = {
    'Test': doTest,
    'Build': doBuild,
    'Push': doPush,
    'Install': doInstall,
  };

  var deviceTxt = device != null ? '(device $device)' : '';
  var deviceParams = device != null ? ['-s', device] : [];

  var lst = strs.keys.where((k) => strs[k] == true).toList();
  print([lst.getRange(0, lst.length - 1).join(', '), lst.last]
      .where((i) => i != null && i.isNotEmpty)
      .join(' & '));
  print('Version: $version');

  outputPath = '/sdcard/Download/dungeon-paper-$version.apk';

  if (doTest == true) {
    print('Running tests...');
    var testProc = Process.start('flutter', ['test']);
    var testRun = await testProc;
    await stdout.addStream(testRun.stdout);
    await stdout.addStream(testRun.stderr);
  }

  if (doBuild == true) {
    print('Building...');
    var results = [
      Process.start('flutter',
          ['build', 'appbundle', '--target-platform', platforms.join(',')]),
      Process.start('flutter', [
        'build',
        'apk',
        '--target-platform',
        platforms.join(','),
        '--split-per-abi'
      ]),
    ];
    var outs = await Future.wait(results);
    for (var out in await outs) {
      await stdout.addStream(out.stdout);
      await stdout.addStream(out.stderr);
    }
  }

  if (doPush == true) {
    print('Pushing $apkPath to $outputPath... $deviceTxt');
    await Process.start('adb', [...deviceParams, 'push', apkPath, outputPath]);
  }

  if (doInstall == true) {
    print('Installing $outputPath... $deviceTxt');
    var result =
        await Process.start('adb', [...deviceParams, 'install', '-r', apkPath]);
    await stdout.addStream(result.stdout);
    if (await result.exitCode != 0) {
      print('Uninstalling old version...');
      var uninstall = await Process.start(
          'adb', [...deviceParams, 'uninstall', 'app.dungeonpaper']);
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
