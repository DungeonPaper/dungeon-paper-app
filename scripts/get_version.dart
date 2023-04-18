import 'dart:io';

void main() {
  // get version from pubspec.yaml
  final pubspecFile = File('pubspec.yaml');
  final version = pubspecFile
      .readAsStringSync()
      .split('\n')
      .firstWhere((x) => x.startsWith('version:'))
      .split(':')
      .last
      .trim();
  // ignore: avoid_print
  print(version);
}
