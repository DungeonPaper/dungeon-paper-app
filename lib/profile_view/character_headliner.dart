import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';

class CharacterHeadline extends StatelessWidget {
  final DbCharacter character;

  const CharacterHeadline({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Material(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Level ${character.level} ' +
                          '${capitalize(character.alignment + ' ' + character.mainClass)}' // +
                      // ', XP: ${character.currentXP.toString()}'
                      ),
                  Text('${character.displayName}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
