import 'package:dungeon_paper/redux/connectors/character_connector.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';

class CharacterHeadline extends StatelessWidget {
  const CharacterHeadline({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CharacterConnector(builder: (context, character) {
      num level = character.level;
      String alignment = capitalize(character.alignment);
      String mainClass = capitalize(character.mainClass);
      String displayName = capitalize(character.displayName);

      return Row(
        children: <Widget>[
          Expanded(
            child: Material(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text('Level $level $alignment $mainClass'),
                    Text(
                      '$displayName',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24.0),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
