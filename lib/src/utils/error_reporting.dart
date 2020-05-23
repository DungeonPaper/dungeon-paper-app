import 'dart:async';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:pedantic/pedantic.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:sentry/sentry.dart';

// SentryClient sentry;

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

// Future<void> initSentry() async {
//   var secrets = await loadSecrets();
//   var packageInfo = await PackageInfo.fromPlatform();
//   sentry = SentryClient(
//     dsn: secrets['SENTRY_DSN'],
//     environmentAttributes: Event(
//       release: packageInfo.version,
//     ),
//   );

//   FlutterError.onError = (FlutterErrorDetails details) {
//     if (isInDebugMode) {
//       FlutterError.dumpErrorToConsole(details);
//     } else {
//       Zone.current.handleUncaughtError(details.exception, details.stack);
//     }
//   };
// }

Future<void> reportError(dynamic error, StackTrace stackTrace) async {
  print('Caught error: $error');
  if (isInDebugMode) {
    print(stackTrace);
    return;
  } else {
    // unawaited(sentry.captureException(
    //   exception: error,
    //   stackTrace: stackTrace,
    // ));
    unawaited(Crashlytics.instance.recordError(error, stackTrace));
  }
}

// registerUserContext(FirebaseUser user) {
//   sentry.userContext = User(
//     email: user.email,
//     id: user.uid,
//     username: user.displayName,
//   );
// }
