import 'package:dungeon_paper/battle_view/battle_view.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/user.dart';
import 'package:dungeon_paper/main_view/fab.dart';
import 'package:dungeon_paper/main_view/nav_bar.dart';
import 'package:dungeon_paper/main_view/sidebar.dart';
import 'package:dungeon_paper/main_view/welcome.dart';
import 'package:dungeon_paper/notes_view/notes_view.dart';
import 'package:dungeon_paper/profile_view/basic_info/basic_info.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:dungeon_paper/redux/stores/loading_reducer.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  MainView({
    Key key,
    @required this.appName,
    @required this.pageController,
  }) : super(key: key);

  final String appName;
  final PageController pageController;

  static Widget bottomSpacer = Container(height: 64);

  final Map<Pages, Widget Function(DbCharacter character)> pageMap = {
    Pages.Home: (character) => BasicInfo(character: character),
    Pages.Battle: (character) => BattleView(character: character),
    Pages.Profile: (character) => NotesView(character: character),
  };

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector(builder: (context, state) {
      DbCharacter character = state.characters.current;
      DbUser user = state.user.current;
      List<Widget> pages = Pages.values.map((page) {
        var map = pageMap[page];
        return map(character);
      }).toList();

      return Scaffold(
        appBar: AppBar(
          title: Text(appName),
        ),
        drawer: user != null ? Sidebar() : null,
        floatingActionButton:
            character != null ? FAB(pageController: pageController) : null,
        floatingActionButtonLocation:
            character != null ? FloatingActionButtonLocation.endFloat : null,
        bottomNavigationBar:
            character != null ? NavBar(pageController: pageController) : null,
        body: PageView(
          controller: pageController,
          children: character == null
              ? [
                  Welcome(
                    loading: state.loading[LoadingKeys.Character],
                    pageController: pageController,
                  )
                ]
              : pages,
        ),
      );
    });
  }
}
