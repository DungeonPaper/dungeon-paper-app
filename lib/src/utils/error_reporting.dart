import 'dart:async';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:pedantic/pedantic.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// Error reporting
Future<void> initErrorReporting() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initCrashalytics();
}

Future<void> initCrashalytics() async {
  FlutterError.onError = (details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Crashlytics.instance.recordFlutterError(details);
    }
  };
}

Future<void> reportError(dynamic error, StackTrace stackTrace) async {
  print('Caught error: $error');
  if (isInDebugMode) {
    print(stackTrace);
    return;
  } else {
    unawaited(Crashlytics.instance.recordError(error, stackTrace));
  }
}
