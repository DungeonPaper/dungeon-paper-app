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
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 6,
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return const ListCard<Character, ExportController>();
            case 1:
              return const ListCard<CharacterClass, ExportController>();
            case 2:
              return const ListCard<Move, ExportController>();
            case 3:
              return const ListCard<Spell, ExportController>();
            case 4:
              return const ListCard<Item, ExportController>();
            case 5:
              return const ListCard<Race, ExportController>();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
