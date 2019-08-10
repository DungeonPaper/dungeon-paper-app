import 'dart:async';

import 'package:dungeon_paper/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:sentry/sentry.dart';

SentryClient sentry;

// Error reporting
Future<void> initErrorReporting() async {
  var secrets = await loadSecrets();
  sentry = SentryClient(dsn: secrets['SENTRY_DSN']);

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };
}

Future<void> reportError(dynamic error, dynamic stackTrace) async {
  print('Caught error: $error');
  if (isInDebugMode) {
    print(stackTrace);
    return;
  } else {
    sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    );
  }
}
