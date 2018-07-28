import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/profile_view/edit_stat_dialog.dart';
import 'package:dungeon_paper/redux/connectors/character_connector.dart';
import 'package:flutter/material.dart';

class BaseStats extends StatelessWidget {
  // const BaseStats({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CharacterConnector(builder: (context, character) {
      return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StatCard(name: 'str'),
                StatCard(name: 'dex'),
                StatCard(name: 'con'),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StatCard(name: 'int'),
                StatCard(name: 'wis'),
                StatCard(name: 'cha'),
              ],
            ),
          ],
        ),
      );
    });
  }
}

class StatCard extends StatelessWidget {
  StatCard({
    Key key,
    @required this.name,
  })  : fullName = DbCharacter.statNameMap[name],
        super(key: key);

  final String name;
  final String fullName;

  @override
  Widget build(BuildContext _context) {
    return CharacterConnector(builder: (context, character) {
      num value = character[name.toLowerCase()];

      return Expanded(
        child: GestureDetector(
          onTap: () => showDialog(
                context: context,
                builder: (context) => EditStatDialog(name: name, value: value),
              ),
          child: Card(
            margin: EdgeInsets.all(10.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('$fullName: $value', style: TextStyle(fontSize: 11.0)),
                  Text(
                    '${name.toUpperCase()}: ' +
                    DbCharacter.statModifierText(value),
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
