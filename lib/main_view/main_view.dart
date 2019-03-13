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
import 'package:dungeon_paper/redux/stores/loading_store.dart';
import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  MainContainer({
    Key key,
    @required this.title,
    this.pageController,
  }) : super(key: key);

  final String title;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector(builder: (ctx, state) {
      DbCharacter character = state.characters.current;
      DbUser user = state.user.current;
      return MainView(
        character: character,
        user: user,
        title: title,
        loading: state.loading[LoadingKeys.Character],
        pageController: pageController,
      );
    });
  }
}

class MainView extends StatelessWidget {
  final DbCharacter character;
  final DbUser user;
  final String title;
  final bool loading;
  final PageController pageController;

  MainView({
    Key key,
    @required this.character,
    @required this.user,
    @required this.title,
    @required this.loading,
    @required this.pageController,
  }) : super(key: key);

  static Widget bottomSpacer = Container(height: 64);

  final Map<Pages, Widget Function(DbCharacter character)> pageMap = {
    Pages.Home: (character) => BasicInfo(character: character),
    Pages.Battle: (character) => BattleView(character: character),
    Pages.Notes: (character) => NotesView(character: character),
  };

  @override
  Widget build(BuildContext context) {
    PageView homeWidget = PageView.builder(
      controller: pageController,
      itemBuilder: (context, idx) => character == null
          ? Welcome(
              loading: loading,
              pageController: pageController,
            )
          : pages[idx],
      itemCount: character == null ? 1 : pages.length,
    );
    return Scaffold(
      appBar: appBar,
      drawer: drawer,
      floatingActionButton: fab,
      floatingActionButtonLocation: fabLocation,
      bottomNavigationBar: navBar,
      body: homeWidget,
    );
  }

  PreferredSizeWidget get appBar => AppBar(title: Text(title));
  Widget get fab =>
      character != null ? FAB(pageController: pageController) : null;
  FloatingActionButtonLocation get fabLocation =>
      character != null ? FloatingActionButtonLocation.endFloat : null;
  Widget get drawer => user != null ? Sidebar() : null;
  List<Widget> get pages => Pages.values.map((page) {
        var map = pageMap[page];
        if (map != null) {
          return map(character);
        }
        return Container();
      }).toList();
  Widget get navBar =>
      character != null ? NavBar(pageController: pageController) : null;
}
