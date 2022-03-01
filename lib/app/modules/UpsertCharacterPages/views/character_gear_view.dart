import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_gear_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CharacterGearView extends GetView<CharacterGearController> {
  final void Function(bool valid, CharGear? info) onValidate;

  const CharacterGearView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'CharacterGearView is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}
