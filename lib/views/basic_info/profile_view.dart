import '../../db/character.dart';
import '../profile_view/base_stats/base_stats.dart';
import '../profile_view/character_headline.dart';
import '../profile_view/status_bars.dart';
import 'armor_and_hit_dice.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';

import 'character_photo.dart';

class ProfileView extends StatelessWidget {
  final DbCharacter character;

  ProfileView({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      List<Widget> children = [
        CharacterHeader(character: character),
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

class CharacterHeader extends StatelessWidget {
  final bool editable;

  const CharacterHeader({
    Key key,
    this.editable = true,
    @required this.character,
  }) : super(key: key);

  final DbCharacter character;

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
