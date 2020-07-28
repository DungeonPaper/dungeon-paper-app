import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/lists/stat_card_grid.dart';
import 'package:dungeon_paper/src/molecules/armor_and_dmg_dice.dart';
import 'package:dungeon_paper/src/molecules/status_bars.dart';
import 'package:dungeon_paper/src/pages/home_view/photo_and_summary.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final Character character;

  ProfileView({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      var children = <Widget>[
        PhotoAndSummary(character: character),
        ArmorAndDmgDice(character: character),
        Padding(
          padding: const EdgeInsets.all(16).copyWith(top: 8),
          child: StatusBars(character: character),
        ),
        Padding(
          padding: const EdgeInsets.all(16).copyWith(top: 0),
          child: BaseStats(character: character),
        ),
      ];
      var width = MediaQuery.of(context).size.width;
      // var height = MediaQuery.of(context).size.height;

      return StaggeredGridView.extentBuilder(
        // return StaggeredGridView.countBuilder(
        maxCrossAxisExtent:
            Orientation.portrait == orientation ? width : width / 2,
        // crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      );
      // return orientation == Orientation.portrait
      //     ? Column(children: children)
      //     : ListView(children: children);
    });
  }
}
