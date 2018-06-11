import 'package:flutter/material.dart';
import 'user_badge.dart';
import 'basic_info.dart';

void main() => runApp(new DungeonPaper());

class DungeonPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Dungeon Paper',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Dungeon Paper'),
          actions: <Widget>[
            new UserBadge()
          ],
        ),
        body: new BasicInfo(),
      ),
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
    );
  }
}
