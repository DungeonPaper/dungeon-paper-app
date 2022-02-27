import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_moves_spells_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CharacterMovesSpellsView extends GetView<CharacterMovesSpellsController> {
  final void Function(bool valid, CharacterMovesSpells? movesSpells) onValidate;

  const CharacterMovesSpellsView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text('Moves & Spells');
  }
}
