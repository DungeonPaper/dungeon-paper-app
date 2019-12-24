import 'dart:async';
import 'package:dungeon_paper/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:package_info/package_info.dart';
import 'package:pedantic/pedantic.dart';
import 'package:sentry/sentry.dart';

SentryClient sentry;

// Error reporting
Future<void> initErrorReporting() async {
  WidgetsFlutterBinding.ensureInitialized();
  var secrets = await loadSecrets();
  var packageInfo = await PackageInfo.fromPlatform();
  sentry = SentryClient(
    dsn: secrets['SENTRY_DSN'],
    environmentAttributes: Event(
      release: packageInfo.version,
    ),
  );

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
    unawaited(sentry.captureException(
      exception: error,
      stackTrace: stackTrace,
    ));
  }
}

registerUserContext(FirebaseUser user) {
  sentry.userContext = User(
    email: user.email,
    id: user.uid,
    username: user.displayName,
  );
}
