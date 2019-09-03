import '../../db/character.dart';
import '../../db/character_utils.dart';
import '../../profile_view/base_stats/stat_card.dart';
import 'package:flutter/material.dart';

class BaseStats extends StatelessWidget {
  final DbCharacter character;

  const BaseStats({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
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
  }
}
