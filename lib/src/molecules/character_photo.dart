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
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.primaryColorLight,
        image: DecorationImage(
          fit: BoxFit.fitWidth,
          alignment: character.settings.photoAlignment,
          image: NetworkImage(character.photoURL),
        ),
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}
