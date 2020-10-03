import 'package:dungeon_paper/db/helpers/character_utils.dart';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/atoms/stat_card.dart';
import 'package:flutter/material.dart';

class BaseStats extends StatelessWidget {
  final Character character;

  const BaseStats({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StatCard(character: character, stat: CharacterKeys.str),
              StatCard(character: character, stat: CharacterKeys.dex),
              StatCard(character: character, stat: CharacterKeys.con),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StatCard(character: character, stat: CharacterKeys.int),
              StatCard(character: character, stat: CharacterKeys.wis),
              StatCard(character: character, stat: CharacterKeys.cha),
            ],
          ),
        ],
      ),
    );
  }
}
