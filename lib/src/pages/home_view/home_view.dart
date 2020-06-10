import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/lists/stat_card_grid.dart';
import 'package:dungeon_paper/src/molecules/armor_and_dmg_dice.dart';
import 'package:dungeon_paper/src/molecules/character_headline.dart';
import 'package:dungeon_paper/src/molecules/character_photo.dart';
import 'package:dungeon_paper/src/molecules/status_bars.dart';
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
        ArmorAndHitDice(character: character),
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

class PhotoAndSummary extends StatelessWidget {
  final bool editable;

  const PhotoAndSummary({
    Key key,
    this.editable = true,
    @required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    var image = CharacterPhoto(character: character);
    var imageContainer =
        character.photoURL != null && character.photoURL.isNotEmpty
            ? AspectRatio(aspectRatio: 14.0 / 9.0, child: image)
            : Container(height: 90.0);
    return Stack(
      children: <Widget>[
        Container(
          height: 150.0,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
          child: Stack(
            children: [
              imageContainer,
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: character.photoURL != null &&
                              character.photoURL.isNotEmpty
                          ? LinearGradient(
                              begin: AlignmentDirectional.topCenter,
                              end: AlignmentDirectional.bottomCenter,
                              colors: [
                                Color.fromRGBO(0, 0, 0, 0),
                                Color.fromRGBO(150, 150, 150, 1),
                              ],
                            )
                          : null,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 32, 16, 12),
                      child: CharacterHeadline(
                        character: character,
                        editable: editable,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
