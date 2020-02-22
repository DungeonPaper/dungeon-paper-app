import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:screen/screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/error_reporting.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/theme.dart';
import 'package:dungeon_paper/views/main_view/main_view.dart';

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
