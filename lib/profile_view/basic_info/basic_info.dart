import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/profile_view/base_stats/base_stats.dart';
import 'package:dungeon_paper/profile_view/character_headline.dart';
import 'package:dungeon_paper/profile_view/status_bars.dart';
import 'package:flutter/material.dart';

class BasicInfo extends StatelessWidget {
  final DbCharacter character;

  BasicInfo({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      List<Widget> children = [
        CharacterHeader(character: character, orientation: orientation),
        StatusBars(character: character),
        BaseStats(character: character),
      ];
      var width = MediaQuery.of(context).size.width;
      // var height = MediaQuery.of(context).size.height;

      return StaggeredGridView.extentBuilder(
        // return StaggeredGridView.countBuilder(
        maxCrossAxisExtent:
            Orientation.portrait == orientation ? width : width / 2,
        // crossAxisCount: orientation == Orientation.portrait ? 1 : 2,
        itemCount: children.length,
        itemBuilder: (context, index) => Container(child: children[index]),
        staggeredTileBuilder: (index) => StaggeredTile.fit(1),
      );
      // return orientation == Orientation.portrait
      //     ? Column(children: children)
      //     : ListView(children: children);
    });
  }
}

class CharacterHeader extends StatelessWidget {
  const CharacterHeader({
    Key key,
    @required this.character,
    @required this.orientation,
  }) : super(key: key);

  final DbCharacter character;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    var image = Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          alignment: FractionalOffset.topCenter,
          image: NetworkImage(character.photoURL),
        ),
      ),
    );
    var imageContainer = character.photoURL != null &&
            character.photoURL.length > 0
        ? AspectRatio(
            aspectRatio:
                orientation == Orientation.portrait ? 2.0 / 1.0 : 14.0 / 9.0,
            child: image)
        : Container(height: 90.0, width: 0.0);
    return Stack(
      children: [
        imageContainer,
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CharacterHeadline(character: character),
          ),
        ),
      ],
    );
  }
}
