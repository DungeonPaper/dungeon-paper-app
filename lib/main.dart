import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/nav_bar.dart';
import 'package:dungeon_paper/notes_view/notes_view.dart';
import 'package:dungeon_paper/profile_view/basic_info.dart';
import 'package:dungeon_paper/profile_view/login_button.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:dungeon_paper/redux/stores/loading_reducer.dart';
import 'package:dungeon_paper/sidebar.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(DungeonPaper());
  // await Future.delayed(Duration(seconds: 2));
  performSignIn();
}

class DungeonPaper extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    const appName = 'Dungeon Paper';

    return MaterialApp(
      title: appName,
      home: DWStoreConnector(builder: (context, state) {
        DbCharacter character = state.characters.current;
        DbUser user = state.user.current;
        Widget body = character == null
            ? Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor),
                child: Center(
                  child: state.loading[LoadingKeys.Character]
                      ? CircularProgressIndicator(value: null)
                      : Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text('Welcome to Dungeon Paper!',
                                  style: TextStyle(fontSize: 24)),
                            ),
                            Text('Please log in at the rop right corner.')
                          ],
                        ),
                ),
              )
            : PageView(
                controller: _pageController,
                children: [
                  BasicInfo(character: character),
                  NotesView(character: character),
                ],
              );
        return Scaffold(
          appBar: AppBar(
            title: const Text(appName),
            actions: [
              LoginButton(onUserChange: () {
                _pageController.jumpToPage(0);
              })
            ],
          ),
          drawer: user != null ? Sidebar() : null,
          floatingActionButton: character != null
              ? ActionButtons(pageController: _pageController)
              : null,
          floatingActionButtonLocation: character != null
              ? FloatingActionButtonLocation.centerDocked
              : null,
          bottomNavigationBar: character != null
              ? NavBar(pageController: _pageController)
              : null,
          body: body,
        );
      }),
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color.fromARGB(255, 225, 225, 225),
      ),
    );
  }
}
