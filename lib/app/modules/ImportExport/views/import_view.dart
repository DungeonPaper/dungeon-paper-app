import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/ImportExport/controllers/import_controller.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../local_widgets/list_card.dart';

class ImportView extends GetView<ImportController> {
  const ImportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme.merge(
      contentPadding: EdgeInsets.zero,
      child: Obx(
        () {
          final builder = controller.hasData
              ? ItemBuilder.lazyChildren(
                  children: [
                    () => ElevatedButton.icon(
                          onPressed: () => controller.toImport.value = null,
                          icon: const Icon(Icons.clear),
                          label: Text(S.current.importClearFile),
                        ),
                    () => const ListCard<Character, ImportController>(),
                    () => const ListCard<CharacterClass, ImportController>(),
                    () => const ListCard<Move, ImportController>(),
                    () => const ListCard<Spell, ImportController>(),
                    () => const ListCard<Item, ImportController>(),
                    () => const ListCard<Race, ImportController>(),
                  ],
                )
              : ItemBuilder.lazyChildren(
                  children: [
                    () => Text(S.current.importBrowseHelp),
                    () => ElevatedButton.icon(
                          onPressed: controller.pickImportFile,
                          icon: const Icon(Icons.file_open),
                          label: Text(S.current.importBrowseFile),
                        )
                  ],
                );
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: builder.itemCount,
            itemBuilder: builder.itemBuilder,
          );
        },
      ),
    );
  }
}
