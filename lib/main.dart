import 'package:dungeon_paper/profile_view/basic_info.dart';
import 'package:dungeon_paper/profile_view/user_badge.dart';
import 'package:flutter/material.dart';

void main() => runApp(new DungeonPaper());

class DungeonPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Dungeon Paper',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Dungeon Paper'),
          actions: <Widget>[new UserBadge()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
            // BottomNavigationBarItem(
            //   icon: ImageIcon(AssetImage('assets/swords.png')),
            //   title: Text('Battle'),
            // )
            BottomNavigationBarItem(
              icon: Icon(Icons.speaker_notes),
              title: Text('Notes'),
            )
          ],
        ),
        body: new BasicInfo(),
      ),
      theme: new ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.light,
        scaffoldBackgroundColor: new Color.fromARGB(255, 225, 225, 225),
      ),
    );
  }
}
