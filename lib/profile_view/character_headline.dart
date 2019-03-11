import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/profile_view/basic_info/edit_character_dialog.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
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
    return DWStoreConnector(builder: (context, state) {
      num level = character.level;
      String alignment = capitalize(enumName(character.alignment));
      String mainClass = capitalize(character.mainClass.name);
      String displayName = capitalize(character.displayName);

      return Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: AlignmentDirectional.bottomCenter,
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(255, 150, 150, 150),
                ],
              )),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 32, 16, 12),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.white, shadows: [
                    Shadow(color: Colors.black, offset: Offset(1, 1))
                  ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
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
                      IconButton(
                        icon: Icon(Icons.mode_edit),
                        onPressed: () => onEdit(context),
                        splashColor: Colors.white,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  void onEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EditCharacterDialog(character: character),
      ),
    );
  }
}
