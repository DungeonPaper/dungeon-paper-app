import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/src/molecules/character_headline.dart';
import 'package:dungeon_paper/src/molecules/character_photo.dart';
import 'package:flutter/material.dart';

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
            ? AspectRatio(aspectRatio: 14.0 / 9, child: image)
            : Container(height: 100);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            Color.fromRGBO(0, 0, 0, 0.6),
                          ],
                        )
                      : null,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(15),
                  ),
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
      //     ),
      // ],
    );
  }
}
