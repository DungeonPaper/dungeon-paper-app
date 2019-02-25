import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/notes_view/notes_view.dart';
import 'package:dungeon_paper/profile_view/basic_info.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({
    Key key,
    @required PageController pageController,
    @required this.character,
  })  : _pageController = pageController,
        super(key: key);

  final PageController _pageController;
  final DbCharacter character;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      children: [
        BasicInfo(character: character),
        NotesView(character: character),
      ],
    );
  }
}
