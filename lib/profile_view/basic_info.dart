import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/profile_view/base_stats/base_stats.dart';
import 'package:dungeon_paper/profile_view/character_headline.dart';
import 'package:dungeon_paper/profile_view/status_bars.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatelessWidget {
  final DbCharacter character;
  BasicInfo({Key key, @required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      List<Widget> children = [
        ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            CharacterHeadline(),
            character.photoURL != null && character.photoURL.length > 0
                ? AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          alignment: FractionalOffset.topCenter,
                          image: NetworkImage(character.photoURL),
                        ),
                      ),
                    ),
                  )
                : Container(height: 0.0, width: 0.0),
            StatusBars(),
          ],
        ),
        BaseStats(),
      ];

      return StaggeredGridView.countBuilder(
        crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
        itemCount: children.length,
        itemBuilder: (context, index) => Container(child: children[index]),
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      );
    });
  }
}
