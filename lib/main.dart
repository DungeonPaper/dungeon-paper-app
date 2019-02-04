import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/nav_bar.dart';
import 'package:dungeon_paper/notes_view/notes_view.dart';
import 'package:dungeon_paper/profile_view/basic_info.dart';
import 'package:dungeon_paper/profile_view/user_badge.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:dungeon_paper/redux/stores/loading_reducer.dart';
import 'package:flutter/material.dart';

void main() {
  performSignIn();
  runApp(DungeonPaper());
}

class DungeonPaper extends StatelessWidget {
  final PageController _pageController = PageController();

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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.apps),
          onPressed: () => null,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        // bottomNavigationBar: BottomNavigationBar(
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.speaker_notes), title: Text('Notes')),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.speaker_notes), title: Text('Notes')),
        //   ],
        // ),
        bottomNavigationBar: NavBar(pageController: _pageController),
        body: DWStoreConnector(
            loaderKey: LoadingKeys.Character,
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
                  children: <Widget>[
                    Center(child: const Text('Please log in!'))
                  ],
                );
              }
              return PageView(
                controller: _pageController,
                children: [
                  BasicInfo(character: character),
                  NotesView(character: character),
                ],
              );
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
