import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/export_controller.dart';
import '../local_widgets/list_card.dart';

class ExportView extends GetView<ExportController> {
  const ExportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme.merge(
      contentPadding: EdgeInsets.zero,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListCard<Character, ExportController>(),
          ListCard<CharacterClass, ExportController>(),
          ListCard<Move, ExportController>(),
          ListCard<Spell, ExportController>(),
          ListCard<Item, ExportController>(),
          ListCard<Race, ExportController>(),
        ],
      ),
    );
  }
}
