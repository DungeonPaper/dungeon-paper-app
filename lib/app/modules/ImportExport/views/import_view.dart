import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/ImportExport/controllers/import_controller.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../local_widgets/list_card.dart';

class ImportView extends StatelessWidget {
  ImportView({super.key});
  final pageStorageBucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return ListTileTheme.merge(
      contentPadding: EdgeInsets.zero,
      child: Consumer<ImportController>(
        builder: (context, controller, _) {
          final builder = controller.hasData
              ? ItemBuilder.lazyChildren(
                  children: [
                    () => ElevatedButton.icon(
                          onPressed: controller.clearFile,
                          icon: const Icon(Icons.clear),
                          label: Text(tr.backup.importing.file.clearFile),
                        ),
                    () => const ListCard<Character, ImportController>(
                        type: ListCardType.import),
                    () => const ListCard<CharacterClass, ImportController>(
                        type: ListCardType.import),
                    () => const ListCard<Move, ImportController>(
                        type: ListCardType.import),
                    () => const ListCard<Spell, ImportController>(
                        type: ListCardType.import),
                    () => const ListCard<Item, ImportController>(
                        type: ListCardType.import),
                    () => const ListCard<Race, ImportController>(
                        type: ListCardType.import),
                  ],
                )
              : ItemBuilder.lazyChildren(
                  children: [
                    () => Text(tr.backup.importing.file.info),
                    () => ElevatedButton.icon(
                          onPressed: () => controller.pickImportFile(context),
                          icon: const Icon(Icons.file_open),
                          label: Text(tr.backup.importing.file.browse),
                        )
                  ],
                );
          return PageStorage(
            bucket: pageStorageBucket,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: builder.itemCount,
              itemBuilder: builder.itemBuilder,
            ),
          );
        },
      ),
    );
  }
}
