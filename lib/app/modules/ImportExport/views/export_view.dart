import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../widgets/dialogs/export_class_dialog.dart';
import '../controllers/export_controller.dart';
import '../local_widgets/list_card.dart';

class ExportView extends GetView<ExportController> {
  const ExportView({super.key});

  @override
  Widget build(BuildContext context) {
    final builder = ItemBuilder.lazyChildren(
      children: [
        () => Wrap(
              children: [
                ElevatedButton.icon(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => const ExportClassDialog(),
                  ),
                  icon: const Icon(Icons.upload),
                  label:
                      Text(tr.backup.exporting.bundles.characterClass.button),
                ),
              ],
            ),
        () => const ListCard<Character, ExportController>(),
        () => const ListCard<CharacterClass, ExportController>(),
        () => const ListCard<Move, ExportController>(),
        () => const ListCard<Spell, ExportController>(),
        () => const ListCard<Item, ExportController>(),
        () => const ListCard<Race, ExportController>(),
      ],
    );
    return ListTileTheme.merge(
      contentPadding: EdgeInsets.zero,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: builder.itemCount,
        itemBuilder: builder.itemBuilder,
      ),
    );
  }
}

