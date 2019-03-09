import 'package:dungeon_paper/db/character_types.dart';
import 'package:dungeon_paper/profile_view/base_stats/stat_card.dart';
import 'package:dungeon_paper/redux/stores/connectors.dart';
import 'package:flutter/material.dart';

class BaseStats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DWStoreConnector(builder: (context, state) {
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
    });
  }
}

