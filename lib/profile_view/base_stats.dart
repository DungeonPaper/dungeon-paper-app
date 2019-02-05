import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/db/character_types.dart';
import 'package:dungeon_paper/profile_view/edit_stat_dialog.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:flutter/material.dart';

class BaseStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DWStoreConnector(builder: (context, state) {
      return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StatCard(stat: Stats.str),
                StatCard(stat: Stats.dex),
                StatCard(stat: Stats.con),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StatCard(stat: Stats.int),
                StatCard(stat: Stats.wis),
                StatCard(stat: Stats.cha),
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
    @required this.stat,
  })  : fullName = StatNameMap[stat],
        super(key: key);

  final Stats stat;
  final String fullName;

  @override
  Widget build(BuildContext _context) {
    return DWStoreConnector(builder: (context, state) {
      DbCharacter character = state.characters.current;
      String name = stat.toString().split('.')[1];
      num value = character[name.toLowerCase()];

      return Expanded(
        child: Card(
          margin: EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => showDialog(
                  context: context,
                  builder: (context) => EditStatDialog(stat: stat, value: value),
                ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('$fullName: $value', style: TextStyle(fontSize: 11.0)),
                  Text(
                    '${name.toUpperCase()} ' +
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
