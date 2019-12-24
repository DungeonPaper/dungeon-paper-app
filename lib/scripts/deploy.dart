import 'dart:io';
import 'package:pedantic/pedantic.dart';
import 'package:args/args.dart';
import 'package:path/path.dart';
import 'package:pub_semver/pub_semver.dart';

ArgParser parser = ArgParser();

void main(List<String> args) async {
  var build = true;
  var push = false;
  var install = false;
  Version version;
  var platforms = ['android-arm', 'android-arm64'];
  var apkPath = 'build/app/outputs/apk/release/app-arm64-v8a-release.apk';
  var outputPath;

  parser.addFlag('build', abbr: 'b', defaultsTo: build, callback: (val) {
    build = val;
  });
  parser.addFlag('push', abbr: 'p', defaultsTo: push, callback: (val) {
    push = val;
  });
  parser.addFlag('install', abbr: 'i', defaultsTo: install, callback: (val) {
    install = val;
  });
  parser.addOption('version', abbr: 'v', defaultsTo: await getVersionString(),
      callback: (val) {
    version = Version.parse(val);
  });

  parser.parse(args);

  if (![build, push, install].any((v) => v == true)) {
    print('Nothing to do! Quitting.');
    exit(1);
  }

  print('Build: $build');
  print('Push: $push');
  print('Install: $install');
  print('Version: $version');

  outputPath = '/sdcard/Download/dungeon-paper-$version.apk';

  if (build == true) {
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
    outs.forEach((out) {
      out.stdout.pipe(stdout);
    });
  }

  if (push == true) {
    print('Pushing $apkPath to $outputPath...');
    await Process.start('adb', ['push', apkPath, outputPath]);
  }

  if (install == true) {
    print('Installing $outputPath...');
    var result = await Process.start('adb', ['install', '-r', apkPath]);
    unawaited(result.stdout.pipe(stdout));
    if (await result.exitCode != 0) {
      print('Uninstalling old version...');
      var uninstall =
          await Process.start('adb', ['uninstall', 'app.dungeonpaper']);
      unawaited(uninstall.stdout.pipe(stdout));
      var install = await Process.start('adb', ['install', '-r', apkPath]);
      unawaited(install.stdout.pipe(stdout));
    }
  }

  print('Done!');
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
