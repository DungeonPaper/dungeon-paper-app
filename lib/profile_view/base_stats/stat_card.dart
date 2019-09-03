import '../../db/character.dart';
import '../../db/character_utils.dart';
import '../../profile_view/edit_stat_dialog.dart';
import '../../redux/stores/connectors.dart';
import '../../utils.dart';
import 'package:flutter/material.dart';

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
      String name = enumName(stat);
      num value = getValue(character, stat);

      return Expanded(
        child: Card(
          margin: EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () => showDialog(
                  context: context,
                  builder: (context) =>
                      EditStatDialog(stat: stat, value: value),
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

  getValue(DbCharacter character, Stats key) {
    switch (enumName(key).toLowerCase()) {
      case 'int':
        return character.int;
      case 'dex':
        return character.dex;
      case 'wis':
        return character.wis;
      case 'cha':
        return character.cha;
      case 'str':
        return character.str;
      case 'con':
        return character.con;
    }
  }
}
