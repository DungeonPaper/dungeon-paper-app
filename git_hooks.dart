import 'package:git_hooks/git_hooks.dart';
import 'dart:io';

void main(List arguments) {
  final params = <Git, UserBackFun>{Git.commitMsg: commitMsg};
  change(arguments, params);
}

Future<bool> commitMsg() async {
  final rootDir = Directory.current;
  final myFile = File(uri('${rootDir.path}/.git/COMMIT_EDITMSG'));
  final commitMsg = myFile.readAsStringSync();
  final allowedPrefixes = <String>[
    'build',
    'ci',
    'chore',
    'docs',
    'feat',
    'fix',
    'perf',
    'refactor',
    'style',
    'test'
  ];
  if (allowedPrefixes.any(
    (pref) => commitMsg.startsWith(RegExp(
      '$pref(\\(.+\\))?: .+',
      caseSensitive: false,
    )),
  )) {
    return true;
  } else {
    print(
        'Commit message does not have one of the prefixes: $allowedPrefixes. Aborting.');
    return false;
  }
}
