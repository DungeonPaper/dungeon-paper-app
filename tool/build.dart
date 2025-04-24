// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

late ArgResults args;
var dryRun = false;
var shouldTag = false;
late String repo;
late String name;
late String version;
late String tagName;
late String title;
late String basen;

Future<void> main(List<String> arguments) async {
  final parser = ArgParser();
  parser.addFlag('dry-run', negatable: false);
  parser.addFlag('tag', negatable: false);
  parser.addFlag('help', negatable: false, abbr: 'h');

  parser.addCommand('android')
    ..addFlag('build')
    ..addFlag('apk')
    ..addFlag('aab')
    ..addFlag('push')
    ..addFlag('install')
    ..addFlag('release')
    ..addFlag('symbols')
    ..addFlag('gh-release');

  parser.addCommand('ios')
    ..addFlag('build')
    ..addFlag('ipa')
    ..addFlag('release')
    ..addFlag('repo-update')
    ..addFlag('gh-release');

  parser.addCommand('macos')
    ..addFlag('build')
    ..addFlag('release')
    ..addFlag('repo-update')
    ..addFlag('gh-release');

  parser.addCommand('web')
    ..addFlag('build')
    ..addFlag('publish')
    ..addFlag('release');

  parser.addCommand('release-notes');

  final args = parser.parse(arguments);
  dryRun = args['dry-run'] == true;
  shouldTag = args['tag'] == true;
  final command = args.command;

  if (args['help'] == true || args.command == null) {
    printHelp();
    exit(0);
  }

  name = await getName();
  version = await getVersion();
  tagName = version.replaceAll(RegExp(r'\+\d+'), '');
  title = 'Dungeon Paper';
  basen = '$name-$version';
  repo = 'DungeonPaper/dungeon-paper-app';

  print('🔧 Build Summary');
  print('────────────────────────────────────────');
  print('📦 Package      : $name');
  print('🔖 Version      : $version');
  print('🏷️  Tag name     : v$tagName');
  print('📁 Basename     : $basen');
  print('📤 Repository   : $repo');
  print('🛠️  Command      : ${command!.name}');
  print('📦 Dry run      : $dryRun');
  print('🏷️  Should tag   : $shouldTag');

  final flags = command.options.where((opt) => command[opt] == true).toList();
  if (flags.isNotEmpty) {
    print('⚙️  Flags        : ${flags.join(', ')}');
  } else {
    print('⚙️  Flags        : (none)');
  }

  print('────────────────────────────────────────\n');

  if (shouldTag) {
    if (await ask('Create and push git tag v$tagName?')) {
      await tagRelease(tagName);
    } else {
      print('⚠️  Skipping git tagging');
    }
  }

  switch (command.name) {
    case 'android':
      print('🤖 Running android tasks...');
      await handleAndroid(command, basen);
      break;
    case 'ios':
      print('🍏 Running iOS tasks...');
      await handleIOS(command, basen, title);
      break;
    case 'macos':
      print('💻 Running macOS tasks...');
      await handleMacOS(command, basen, title);
      break;
    case 'web':
      print('🌐 Running web tasks...');
      await handleWeb(command);
      break;
    case 'release-notes':
      print('📝 Generating release notes...');
      print(await generateReleaseNotes(tagName));
      break;
    default:
      print('❓ Unknown command');
  }
}

void printHelp() {
  print('''
Dungeon Paper CLI Tool
────────────────────────────────────────
Usage:
  dart run tool/build.dart <command> [flags]

Global flags:
  --dry-run         Print commands without executing them
  --tag             Create and push git tag
  -h, --help        Show this help message

Commands:
  android           Android build pipeline
    --build         Run build steps
    --apk           Build APK
    --aab           Build AAB
    --push          Push APK to connected device
    --install       Install APK on connected device
    --release       Copy final APK/AAB to release directory
    --symbols       Zip and save native symbol files
    --gh-release    Upload APK and AAB to GitHub release

  ios               iOS build pipeline
    --build         Build IPA
    --ipa           Alias for --build
    --release       Copy IPA to release directory
    --repo-update   Run pod repo update & install
    --gh-release    Upload IPA to GitHub release

  macos             macOS packaging
    --build         Build macOS app
    --release          Create DMG
    --repo-update   Run pod repo update & install
    --gh-release    Upload DMG to GitHub release

  web               Web build and deploy
    --build         Build web assets
    --publish       Deploy to Firebase Hosting
    --release       Alias for --build + --publish

  release-notes     Print generated release notes
''');
}

Future<void> _exec(String cmd, {String? workingDirectory}) async {
  if (dryRun) return print('[dry-run] $cmd');
  final parts = cmd.split(' ');
  final process = await Process.start(
    parts.first,
    parts.sublist(1),
    workingDirectory: workingDirectory,
  );
  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);
  final code = await process.exitCode;
  if (code != 0) throw Exception('❌ Command failed: $cmd');
}

Future<bool> ask(String question) async {
  stdout.write('❓ $question [Y/n]: ');
  final input = stdin.readLineSync()?.trim().toLowerCase();
  return input == null || input.isEmpty || input == 'y';
}

Future<String> getName() async {
  final result = await Process.run('dart', [
    'run',
    'btool',
    'get',
    'packageName',
  ]);
  return result.stdout.toString().trim();
}

Future<String> getVersion() async {
  final result = await Process.run('dart', [
    'run',
    'btool',
    'get',
    'packageVersion',
  ]);
  return result.stdout.toString().trim();
}

Future<String> generateReleaseNotes(String ver) async {
  print('📄 Generating release notes for version $ver...');
  final changelogPath = '../dungeon-paper-website/public/CHANGELOG.md';
  final lines = await File(changelogPath).readAsLines();
  final buffer = StringBuffer('## What\'s Changed\n');
  bool inSection = false;
  String? prevVersion;
  for (final line in lines) {
    if (!inSection && line.startsWith('## $ver')) {
      inSection = true;
      continue;
    }
    if (inSection && line.startsWith('## ') && prevVersion == null) {
      prevVersion = line.split(' ')[1];
      inSection = false;
      break;
    }
    if (inSection) buffer.writeln(line);
  }
  if (prevVersion == null) {
    throw Exception('❌ Previous version not found in changelog');
  }
  buffer.writeln(
    '**Full Changelog:** https://github.com/$repo/compare/v$prevVersion...v$ver',
  );
  print('✅ Release notes generated');
  return buffer.toString();
}

Future<void> tagRelease(String ver) async {
  print('🔍 Checking for existing git tag...');
  final result = await Process.run('git', ['tag', '-l', 'v$ver']);
  if ((result.stdout as String).trim().isEmpty) {
    print('🏷️  Creating git tag v$ver');
    await _exec('git tag v$ver');
    await _exec('git push --tags');
  } else {
    print('⚠️  Tag v$ver already exists');
  }
}

Future<void> openFolder(String path) async {
  if (await Directory(path).exists()) {
    if (Platform.isMacOS) {
      await _exec('open $path');
    } else if (Platform.isWindows) {
      await _exec('explorer $path');
    } else if (Platform.isLinux) {
      await _exec('xdg-open $path');
    }
  } else {
    print('❌ Directory does not exist: $path');
  }
}

Future<void> createAndroidSymbolsZip(String basen) async {
  print('🗜️  Creating Android symbols zip...');
  final outputDir = Directory('release/android');
  if (!await outputDir.exists()) await outputDir.create(recursive: true);
  final zipFile =
      '${Directory.current.path}/release/android/symbols-$basen.zip';
  final source =
      'build/app/intermediates/merged_native_libs/release/mergeReleaseNativeLibs/out/lib';
  if (await Directory(source).exists()) {
    await _exec('zip -r $zipFile ./*/*', workingDirectory: source);
    await openFolder('release/android');
  }
}

Future<void> uploadAssetToGitHubRelease(
  String filePath,
  String assetName,
) async {
  if (!await ask('Upload $assetName to GitHub?')) {
    print('🚫 Skipped uploading $assetName');
    return;
  }
  print('ℹ️ Getting release info...');
  final token = Platform.environment['GITHUB_TOKEN'];
  if (token == null) throw Exception('GITHUB_TOKEN not set');
  final url = 'https://api.github.com/repos/$repo/releases';
  final response = await http.get(
    Uri.parse(url),
    headers: {'Authorization': 'Bearer $token'},
  );
  final releases = jsonDecode(response.body);
  late Map<String, dynamic> release;
  final Map<String, dynamic>? maybeRelease = releases.firstWhere(
    (r) => r['tag_name'] == 'v$tagName',
    orElse: () => null,
  );
  if (maybeRelease != null) {
    release = maybeRelease;
    print('ℹ️ Found existing release v$tagName');
  } else {
    print('ℹ️ No existing release found for v$tagName');
    if (!await ask('Create new release v$tagName?')) {
      print('Skipped creating release v$tagName');
      return;
    }
    final notes = await generateReleaseNotes(tagName);
    final createRes = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'tag_name': 'v$tagName',
        'name': 'v$tagName',
        'body': notes,
      }),
    );
    if (createRes.statusCode >= 300) {
      throw Exception('Failed to create release');
    }
    release = jsonDecode(createRes.body);
  }
  final existing = (release['assets'] as List).firstWhere(
    (a) => a['name'] == assetName,
    orElse: () => null,
  );
  if (existing != null && await ask('Delete existing asset $assetName?')) {
    await http.delete(
      Uri.parse(
        'https://api.github.com/repos/$repo/releases/assets/${existing['id']}',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );
  }
  print('☁️ Uploading $assetName to GitHub...');
  final uploadUrl = (release['upload_url'] as String).replaceAll(
    '{?name,label}',
    '?name=${Uri.encodeComponent(assetName)}',
  );
  final bytes = await File(filePath).readAsBytes();
  final uploadRes = await http.post(
    Uri.parse(uploadUrl),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/octet-stream',
    },
    body: bytes,
  );
  if (uploadRes.statusCode >= 300) {
    throw Exception('Upload failed: ${uploadRes.body}');
  }
  print('✅ Uploaded $assetName');
}

Future<void> handleMacOS(ArgResults args, String basen, String title) async {
  if (args['repo-update']) {
    await _exec('pod repo update', workingDirectory: 'macos');
    await _exec('pod install', workingDirectory: 'macos');
  }

  if (args['build']) {
    await _exec('flutter build macos');
  }

  if (args['release']) {
    await createMacOsDmg();
    if (args['gh-release']) {
      await uploadAssetToGitHubRelease(
        'release/macos/$basen.dmg',
        '$basen.dmg',
      );
    }
  } else if (args['gh-release']) {
    await uploadAssetToGitHubRelease('release/macos/$basen.dmg', '$basen.dmg');
  }
}

Future<void> createMacOsDmg() async {
  final appPath = 'build/macos/Build/Products/Release/$title.app';
  final outDir = '${Directory.current.path}/release/macos';
  final tmpDmg = '$outDir/pack.temp.dmg';
  final sourceDir = '${Directory.current.path}/macos/build/dmg';

  print('📦 Packing macOS .app into DMG...');

  await Directory(
    sourceDir,
  ).delete(recursive: true).catchError((_) => Directory(sourceDir));
  await Directory(sourceDir).create(recursive: true);
  await Directory('$sourceDir/.background').create(recursive: true);

  await Process.run('cp', ['-r', appPath, sourceDir]);
  await Process.run('cp', [
    '${Directory.current.path}/assets/images/dmg_bg.png',
    '$sourceDir/.background/background.png',
  ]);
  await Process.run('ln', ['-s', '/Applications', '$sourceDir/Applications']);

  // Calculate DMG size with buffer
  final sizeOut = await Process.run('du', ['-sk', sourceDir]);
  final sizeKb =
      int.tryParse((sizeOut.stdout as String).split('\t').first.trim()) ??
      150000;
  final paddedSize = sizeKb + 10240; // add 10MB

  print('📄 Creating temporary DMG...');
  await Process.run('hdiutil', [
    'create',
    '-srcfolder',
    sourceDir,
    '-volname',
    title,
    '-fs',
    'HFS+',
    '-fsargs',
    '-c c=64,a=16,e=16',
    '-format',
    'UDRW',
    '-size',
    '${paddedSize}k',
    tmpDmg,
  ]);

  print('🔗 Attaching DMG...');
  final attachOutput = await Process.run('hdiutil', [
    'attach',
    '-readwrite',
    '-noverify',
    '-noautoopen',
    tmpDmg,
  ]);
  final lines = (attachOutput.stdout as String).split('\n');
  if ((attachOutput.stdout as String).trim().isEmpty) {
    print('⚠️ hdiutil stdout was empty');
    print('stderr: ${attachOutput.stderr}');
  }
  final device =
      lines
          .firstWhere((line) => line.startsWith('/dev/'))
          .split('\t')
          .first
          .trim();

  print('🖼️  Customizing DMG layout with AppleScript...');
  final osaScript = '''
      tell application "Finder"
        tell disk "$title"
          open
          set current view of container window to icon view
          set toolbar visible of container window to false
          set statusbar visible of container window to false
          set the bounds of container window to {400, 200, 900, 520}
          set theViewOptions to the icon view options of container window
          set arrangement of theViewOptions to not arranged
          set icon size of theViewOptions to 112
          set background picture of theViewOptions to file ".background:background.png"
          set position of item "$title" of container window to {112, 112}
          set position of item "Applications" of container window to {387, 112}
          close
          open
          update without registering applications
          delay 5
          close
        end tell
      end tell
    ''';
  final process = await Process.start('osascript', []);
  process.stdin.write(osaScript);
  await process.stdin.close();

  await stdout.addStream(process.stdout);
  await stderr.addStream(process.stderr);

  final exitCode = await process.exitCode;
  if (exitCode != 0) {
    throw Exception('❌ osascript failed with exit code $exitCode');
  }

  await Process.run('chmod', ['-Rf', 'go-w', '/Volumes/$title']);
  await _exec('sync');
  await _exec('sync');

  print('🔌 Detaching disk $device');
  await Process.run('hdiutil', ['detach', device]);

  print('🗜️  Converting DMG to compressed UDZO format...');
  final finalDmg = '${Directory.current.path}/release/macos/$basen.dmg';
  await File(finalDmg).delete().catchError((_) => File(finalDmg));
  await Process.run('hdiutil', [
    'convert',
    tmpDmg,
    '-format',
    'UDZO',
    '-imagekey',
    'zlib-level=9',
    '-o',
    finalDmg,
  ]);
  await File(tmpDmg).delete().catchError((_) => File(tmpDmg));

  // print('📁 Copying DMG to web directory...');
  // final webDir = '../dungeon-paper-website/public/downloads/macos';
  // await Directory(webDir).create(recursive: true);
  // await Process.run('cp', [finalDmg, webDir]);

  await openFolder(outDir);

  print('🎉 DMG created at $finalDmg');
}

Future<void> handleIOS(ArgResults args, String basen, String title) async {
  if (args['repo-update']) {
    await _exec('pod repo update', workingDirectory: 'ios');
    await _exec('pod install', workingDirectory: 'ios');
  }
  if (args['build'] || args['ipa']) {
    await _exec('flutter build ipa');
  }
  if (args['release']) {
    final ipa = 'build/ios/ipa/$title.ipa';
    final dest = 'release/ios';
    await Directory(dest).create(recursive: true);
    await File(ipa).copy(p.join(dest, '$basen.ipa'));
    await openFolder(dest);
  }
  if (args['gh-release']) {
    await uploadAssetToGitHubRelease('build/ios/ipa/$title.ipa', '$basen.ipa');
  }
}

Future<void> handleAndroid(ArgResults args, String basen) async {
  if (args['build'] || args['apk'] || args['aab']) {
    if (args['build'] || args['apk']) await _exec('flutter build apk');
    if (args['build'] || args['aab']) await _exec('flutter build appbundle');
  }
  if (args['release']) {
    final bundle = 'build/app/outputs/bundle/release/app-release.aab';
    final apk = 'build/app/outputs/flutter-apk/app-release.apk';
    final dest = 'release/android';
    await Directory(dest).create(recursive: true);
    await File(bundle).copy(p.join(dest, '$basen.aab'));
    await File(apk).copy(p.join(dest, '$basen.apk'));
    await openFolder(dest);
  }
  if (args['symbols']) await createAndroidSymbolsZip(basen);
  if (args['push']) {
    await _exec(
      'adb push build/app/outputs/flutter-apk/app-release.apk /sdcard/Download/$basen.apk',
    );
  }
  if (args['install']) {
    await _exec('adb uninstall app.dungeonpaper');
    await _exec('adb install -r build/app/outputs/flutter-apk/app-release.apk');
  }
  if (args['gh-release']) {
    await uploadAssetToGitHubRelease(
      'build/app/outputs/flutter-apk/app-release.apk',
      '$basen.apk',
    );
    await uploadAssetToGitHubRelease(
      'build/app/outputs/bundle/release/app-release.aab',
      '$basen.aab',
    );
  }
}

Future<void> handleWeb(ArgResults args) async {
  if (args['build']) {
    await _exec('flutter build web');
    print('🌐 Built web assets');
  }
  if (args['publish']) {
    await _exec('firebase deploy --only hosting');
    print('📡 Deployed to Firebase Hosting');
  }
}
