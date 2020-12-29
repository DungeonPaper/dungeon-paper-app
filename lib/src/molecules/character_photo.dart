import 'package:cached_network_image/cached_network_image.dart';
import 'package:dungeon_paper/db/models/character.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CharacterPhoto extends StatelessWidget {
  const CharacterPhoto({
    Key key,
    @required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: character.photoURL,
      placeholder: (context, url) => Container(
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      imageBuilder: (context, image) => Container(
        decoration: BoxDecoration(
          color: Get.theme.primaryColorLight,
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            alignment: character.settings.photoAlignment,
            image: image,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
