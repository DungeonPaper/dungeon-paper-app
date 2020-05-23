import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/pages/character_wizard/edit_character_view.dart';
import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:flutter/material.dart';

class CharacterHeadline extends StatelessWidget {
  final Character character;
  final bool editable;

  const CharacterHeadline({
    Key key,
    this.editable = true,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num level = character.level;
    String alignment = capitalize(enumName(character.alignment));
    String mainClass = capitalize(character.mainClass.name);
    String displayName = capitalize(character.displayName);

    return Container(
      child: DefaultTextStyle(
        style: TextStyle(
            color: Colors.white,
            shadows: [Shadow(color: Colors.black, offset: Offset(1, 1))]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Level $level $alignment $mainClass'),
                  Text(
                    '$displayName',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                ],
              ),
            ),
            if (editable == true)
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => onEdit(context),
                splashColor: Colors.white,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }

  void onEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EditCharacterView(character: character),
      ),
    );
  }
}
