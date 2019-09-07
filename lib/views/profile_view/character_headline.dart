import '../../db/character.dart';
import '../edit_character/edit_character_view.dart';
import '../../redux/stores/connectors.dart';
import '../../utils.dart';
import 'package:flutter/material.dart';

class CharacterHeadline extends StatelessWidget {
  final DbCharacter character;
  final bool editable;

  const CharacterHeadline({
    Key key,
    this.editable = true,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DWStoreConnector(builder: (context, state) {
      num level = character.level;
      String alignment = capitalize(enumName(character.alignment));
      String mainClass = capitalize(character.mainClass.name);
      String displayName = capitalize(character.displayName);

      return Container(
        decoration: BoxDecoration(
          gradient: character.photoURL != null && character.photoURL.isNotEmpty
              ? LinearGradient(
                  begin: AlignmentDirectional.topCenter,
                  end: AlignmentDirectional.bottomCenter,
                  colors: [
                    Color.fromRGBO(0, 0, 0, 0),
                    Color.fromRGBO(150, 150, 150, 1),
                  ],
                )
              : null,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(5)),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 12),
          child: DefaultTextStyle(
            style: TextStyle(
                color: Colors.white,
                shadows: [Shadow(color: Colors.black, offset: Offset(1, 1))]),
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
        ),
      );
    });
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