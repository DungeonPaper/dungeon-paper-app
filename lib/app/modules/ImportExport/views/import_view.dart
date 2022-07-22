import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/ImportExport/controllers/import_controller.dart';
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
        () => ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.hasData ? 7 : 2,
          itemBuilder: (context, index) {
            if (controller.hasData) {
              // TODO use mapped type list instead of raw index
              // TODO use a lazy selector for index with support for leading/trailing
              switch (index) {
                case 0:
                  return ElevatedButton.icon(
                    onPressed: () => controller.toImport.value = null,
                    icon: const Icon(Icons.clear),
                    label: Text(S.current.importClearFile),
                  );
                case 1:
                  return const ListCard<Character, ImportController>();
                case 2:
                  return const ListCard<CharacterClass, ImportController>();
                case 3:
                  return const ListCard<Move, ImportController>();
                case 4:
                  return const ListCard<Spell, ImportController>();
                case 5:
                  return const ListCard<Item, ImportController>();
                case 6:
                  return const ListCard<Race, ImportController>();
              }
              return const SizedBox.shrink();
            }

            switch (index) {
              case 0:
                return Text(S.current.importBrowseHelp);
              case 1:
                return ElevatedButton.icon(
                  onPressed: controller.pickImportFile,
                  icon: const Icon(Icons.file_open),
                  label: Text(S.current.importBrowseFile),
                );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
