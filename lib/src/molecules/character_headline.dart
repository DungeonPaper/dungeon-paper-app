import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/dialogs/dialogs.dart';
import 'package:dungeon_paper/src/pages/character_wizard/character_wizard_view.dart';
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
    var level = character.level;
    var alignment = capitalize(enumName(character.alignment));
    var mainClass = capitalize(character.mainClass.name);
    var displayName = capitalize(character.displayName);

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
                icon: Icon(Icons.edit),
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
        builder: (context) => CharacterWizardView(
          character: character,
          mode: DialogMode.Edit,
        ),
      ),
    );
  }
}
