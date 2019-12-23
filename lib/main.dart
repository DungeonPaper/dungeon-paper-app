import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'views/main_view/main_view.dart';
import 'redux/actions.dart';
import 'redux/stores/stores.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:screen/screen.dart';
import 'error_reporting.dart';
import 'theme.dart';

void withInit(Function() cb) async {
  // general setup
  await initErrorReporting();
  Firestore firestore = Firestore.instance;
  await firestore.settings();
  await Screen.keepOn(true);
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   systemNavigationBarColor: theme.scaffoldBackgroundColor,
  // ));

  //
  runZoned(cb, onError: reportError);
}

void main() async {
  withInit(() {
    runApp(DungeonPaper());
    dwStore.dispatch(AppInit());
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
        theme: theme,
      ),
    );
  }
}
