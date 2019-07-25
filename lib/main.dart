import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/main_view/main_view.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:screen/screen.dart';
import 'package:sentry/sentry.dart';

void main() async {
  // Error reporting
  var secrets = await loadSecrets();
  SentryClient _sentry = SentryClient(dsn: secrets['SENTRY_DSN']);

  FlutterError.onError = (FlutterErrorDetails details) {
    if (isInDebugMode) {
      FlutterError.dumpErrorToConsole(details);
    } else {
      Zone.current.handleUncaughtError(details.exception, details.stack);
    }
  };

  Future<void> reportError(dynamic error, dynamic stackTrace) async {
    print('Caught error: $error');
    if (isInDebugMode) {
      print(stackTrace);
      return;
    } else {
      _sentry.captureException(
        exception: error,
        stackTrace: stackTrace,
      );
    }
  }

  // general setup
  Firestore firestore = Firestore.instance;
  await firestore.settings(timestampsInSnapshotsEnabled: true);
  Screen.keepOn(true);

  runZoned(() async {
    runApp(DungeonPaper());
    dwStore.dispatch(AppInit());
  }, onError: (err, trace) {
    reportError(err, trace);
  });
}

class DungeonPaper extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    const appName = 'Dungeon Paper';

    return StoreProvider<DWStore>(
      store: dwStore,
      child: MaterialApp(
        title: appName,
        home: MainContainer(
          title: appName,
          pageController: _pageController,
        ),
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color.fromARGB(255, 225, 225, 225),
        ),
      ),
    );
  }
}
