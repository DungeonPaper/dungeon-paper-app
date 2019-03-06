import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:flutter/material.dart';

class CharacterHeadline extends StatelessWidget {
  const CharacterHeadline({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector(builder: (context, state) {
      DbCharacter character = state.characters.current;
      num level = character.level;
      String alignment = capitalize(enumName(character.alignment));
      String mainClass = capitalize(character.mainClass.name);
      String displayName = capitalize(character.displayName);

      return Row(
        children: [
          Expanded(
            child: Material(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
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
