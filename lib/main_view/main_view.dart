import 'package:dungeon_paper/battle_view/battle_view.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/main_view/nav_bar.dart';
import 'package:dungeon_paper/notes_view/notes_view.dart';
import 'package:dungeon_paper/profile_view/basic_info/basic_info.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  MainView({
    Key key,
    @required PageController pageController,
    @required this.character,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final DbCharacter character;

  final Map<Pages, Widget Function(DbCharacter character)> pageMap = {
    Pages.Home: (character) => BasicInfo(character: character),
    Pages.Battle: (character) => BattleView(character: character),
    Pages.Profile: (character) => NotesView(character: character),
  };

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = Pages.values.map((page) {
      var map = pageMap[page];
      return map(character);
    }).toList();

    return PageView(
      controller: _pageController,
      children: pages,
    );
  }
}
