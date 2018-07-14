import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/profile_view/edit_stat_dialog.dart';
import 'package:flutter/material.dart';

class BaseStats extends StatelessWidget {
  final DbCharacter character;
  const BaseStats({Key key, @required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StatCard(name: 'STR', value: character.str),
              StatCard(name: 'DEX', value: character.dex),
              StatCard(name: 'CON', value: character.con),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              StatCard(name: 'INT', value: character.int),
              StatCard(name: 'WIS', value: character.wis),
              StatCard(name: 'CHA', value: character.cha),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatefulWidget {
  final String name;
  final int value;

  @override
  State<StatefulWidget> createState() =>
      StatCardState(key: key, name: name, value: value);

  StatCard({Key key, @required this.name, @required this.value})
      : super(key: key);
}

class StatCardState extends State {
  StatCardState({
    Key key,
    @required this.name,
    @required this.value,
  }) : super();

  final String name;
  int value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => showDialog(
              context: context,
              builder: (context) => editDialog(),
            ),
        child: Card(
          margin: EdgeInsets.all(10.0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('$name: $value'),
                Text(
                  DbCharacter.statModifierText(value),
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  editDialog() {
    return EditStatDialog(name: name, value: value);
  }
}

