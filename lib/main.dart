import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/main_view/main_view.dart';
import 'package:dungeon_paper/redux/actions.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:flutter/material.dart';

void main() async {
  Firestore firestore = Firestore.instance;
  await firestore.settings(timestampsInSnapshotsEnabled: true);
  runApp(DungeonPaper());
  dwStore.dispatch(AppInit());
}

class DungeonPaper extends StatelessWidget {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    const appName = 'Dungeon Paper';

    return MaterialApp(
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
    );
  }
}
