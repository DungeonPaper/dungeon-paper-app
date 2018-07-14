import 'package:dungeon_paper/profile_view/basic_info.dart';
import 'package:dungeon_paper/profile_view/user_badge.dart';
import 'package:dungeon_paper/redux/connectors/character_connector.dart';
import 'package:flutter/material.dart';

void main() => runApp(DungeonPaper());

class DungeonPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dungeon Paper',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Dungeon Paper'),
          actions: <Widget>[UserBadge()],
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
        body: CharacterConnector(
            loader: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(child: CircularProgressIndicator(value: null))
              ],
            ),
            builder: (context, character) {
              if (character == null) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Center(child: Text('Please log in!'))],
                );
              }
              return BasicInfo(character: character);
            }),
      ),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color.fromARGB(255, 225, 225, 225),
      ),
    );
  }
}
