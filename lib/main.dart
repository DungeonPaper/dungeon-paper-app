import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/profile_view/basic_info.dart';
import 'package:dungeon_paper/profile_view/user_badge.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:flutter/material.dart';

void main() {
  performSignIn();
  runApp(DungeonPaper());
}

class DungeonPaper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const appName = 'Dungeon Paper';
    return MaterialApp(
      title: appName,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appName),
          actions: [UserBadge()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: const Text('Profile'),
            ),
            // BottomNavigationBarItem(
            //   icon: ImageIcon(AssetImage('assets/swords.png')),
            //   title: Text('Battle'),
            // )
            BottomNavigationBarItem(
              icon: Icon(Icons.speaker_notes),
              title: const Text('Notes'),
            )
          ],
        ),
        body: DWStoreConnector(
            loader: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Center(child: CircularProgressIndicator(value: null))],
            ),
            builder: (context, state) {
              DbCharacter character = state.characters.current;
              if (character == null) {
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[Center(child: const Text('Please log in!'))],
                );
              }
              return BasicInfo(character: character);
            }),
      ),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color.fromARGB(255, 225, 225, 225),
      ),
    );
  }
}
