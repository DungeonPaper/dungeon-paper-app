import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_utils.dart';
import 'package:flutter/material.dart';

class StatsSummary extends StatelessWidget {
  final DbCharacter character;

  const StatsSummary({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List<CharacterKeys>> rows = [
      ORDERED_STATS.sublist(0, 3),
      ORDERED_STATS.sublist(3)
    ];
    Radius round = Radius.circular(4);
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        for (var row in rows)
          Row(
            children: <Widget>[
              for (var stat in row)
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(0),
                    elevation: 0,
                    color: Theme.of(context).canvasColor.withOpacity(0.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 22.0),
                      child: DefaultTextStyle(
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.body1,
                        child: Column(
                          children: <Widget>[
                            Text(
                              '${CHARACTER_STAT_LABELS[stat]}: ${_getStat(stat)}',
                              style: TextStyle(fontSize: 11.0),
                            ),
                            Text(
                              '${CHARACTER_STAT_MODIFIER_LABELS[stat]} ' +
                                  DbCharacter.statModifierText(_getStat(stat)),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft:
                            rows[0].indexOf(stat) == 0 ? round : Radius.zero,
                        topRight:
                            rows[0].indexOf(stat) == 2 ? round : Radius.zero,
                        bottomRight:
                            rows[1].indexOf(stat) == 2 ? round : Radius.zero,
                        bottomLeft:
                            rows[1].indexOf(stat) == 0 ? round : Radius.zero,
                      ),
                    ),
                  ),
                ),
            ],
          )
      ],
    );
  }

  int _getStat(CharacterKeys stat) {
    switch (stat) {
      case (CharacterKeys.str):
        return character.str;
      case (CharacterKeys.dex):
        return character.dex;
      case (CharacterKeys.con):
        return character.con;
      case (CharacterKeys.int):
        return character.int;
      case (CharacterKeys.cha):
        return character.cha;
      case (CharacterKeys.wis):
        return character.wis;
      default:
        return null;
    }
  }
}
