import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/profile_view/base_stats.dart';
import 'package:dungeon_paper/profile_view/character_headliner.dart';
import 'package:dungeon_paper/profile_view/status_bars.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatelessWidget {
  final DbCharacter character;
  BasicInfo({Key key, @required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      CharacterHeadline(),
      character.photoURL.length > 0
          ? Container(
              height: MediaQuery.of(context).size.height / 4.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  alignment: FractionalOffset.topCenter,
                  image: NetworkImage(character.photoURL),
                ),
              ),
            )
          : Container(height: 0.0, width: 0.0),
      StatusBars(),
      BaseStats(),
    ];

    return ListView(
      children: children,
    );
  }
}
