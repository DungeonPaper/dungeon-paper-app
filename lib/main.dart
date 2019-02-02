import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
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
  PageController _pageController = PageController();
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

class NavBar extends StatelessWidget {
  final PageController pageController;

  const NavBar({
    Key key,
    @required this.pageController,
  }) : super(key: key);

  Widget _item(Widget label, IconData icon, [void Function() onTap]) =>
      Expanded(
        child: Material(
          color: Colors.transparent,
          child: SizedBox(
            height: 70,
            child: InkWell(
              onTap: onTap,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Icon(icon), label],
              ),
            ),
          ),
        ),
      );
  // IconButton(icon: Icon(icon), onPressed: onTap);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 6,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _item(Text('Profile'), Icons.person, () {
            pageController.animateToPage(0,
                duration: Duration(milliseconds: 500), curve: Curves.easeOut);
          }),
          _item(Text('Notes'), Icons.speaker_notes, () {
            pageController.animateToPage(1,
                duration: Duration(milliseconds: 500), curve: Curves.easeOut);
          }),
        ],
      ),
    );
  }
}
