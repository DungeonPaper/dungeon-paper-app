import 'package:dungeon_paper/db/auth.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/fab.dart';
import 'package:dungeon_paper/main_view.dart';
import 'package:dungeon_paper/nav_bar.dart';
import 'package:dungeon_paper/login_button.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:dungeon_paper/redux/stores/loading_reducer.dart';
import 'package:dungeon_paper/sidebar.dart';
import 'package:dungeon_paper/welcome.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(DungeonPaper());
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
            ? Welcome(loading: state.loading[LoadingKeys.Character])
            : MainView(pageController: _pageController, character: character);
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
          floatingActionButton:
              character != null ? FAB(pageController: _pageController) : null,
          floatingActionButtonLocation:
              character != null ? FloatingActionButtonLocation.endFloat : null,
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
