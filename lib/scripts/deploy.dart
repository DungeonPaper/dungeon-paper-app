import 'dart:io';

import 'package:args/args.dart';
import 'package:path/path.dart';
import 'package:pub_semver/pub_semver.dart';

ArgParser parser = ArgParser();

main(List<String> args) async {
  bool build = true;
  bool push = false;
  bool install = false;
  Version version;
  List<String> platforms = ['android-arm', 'android-arm64'];
  String apkPath = 'build/app/outputs/apk/release/app-arm64-v8a-release.apk';
  String outputPath;

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
    print("Nothing to do! Quitting.");
    exit(1);
  }

  print('Build: $build');
  print('Push: $push');
  print('Install: $install');
  print('Version: $version');

  outputPath = '/sdcard/Download/dungeon-paper-$version.apk';

  if (build == true) {
    print("Building...");
    List<Future<Process>> results = [
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
    print("Pushing $apkPath to $outputPath...");
    await Process.start('adb', ['push', apkPath, outputPath]);
  }

  if (install == true) {
    print("Installing $outputPath...");
    Process result = (await Process.start('adb', ['install', '-r', apkPath]))
      ..stdout.pipe(stdout);
    if (await result.exitCode != 0) {
      print("Uninstalling old version...");
      (await Process.start('adb', ['uninstall', 'app.dungeonpaper']))
        ..stdout.pipe(stdout);
      (await Process.start('adb', ['install', '-r', apkPath]))
        ..stdout.pipe(stdout);
    }
  }

  print("Done!");
}

Future<String> getVersionString() async {
  File buildFile = File(
      join(dirname(Platform.script.path), '../../android/app/build.gradle'));

  String contents = await buildFile.readAsString();
  RegExpMatch match = RegExp('versionName "(.+)"').firstMatch(contents);
  if (match != null) {
    return match.group(1);
  }
  return null;
}
