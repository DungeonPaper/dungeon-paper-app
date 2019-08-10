import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main_view/main_view.dart';
import 'redux/actions.dart';
import 'redux/stores/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:screen/screen.dart';
import 'error_reporting.dart';

void main() async {
  // general setup
  await initErrorReporting();
  Firestore firestore = Firestore.instance;
  await firestore.settings(timestampsInSnapshotsEnabled: true);
  Screen.keepOn(true);

  runZoned(
    () async {
      runApp(DungeonPaper());
      dwStore.dispatch(AppInit());
    },
    onError: reportError,
  );
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
