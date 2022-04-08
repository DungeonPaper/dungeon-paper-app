import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/modules/ImportExport/controllers/import_export_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/expansion_row.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class ExportView extends GetView<ImportExportController> {
  const ExportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTileTheme.merge(
      contentPadding: EdgeInsets.zero,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _ExportCard<Character>(),
          _ExportCard<CharacterClass>(),
          _ExportCard<Move>(),
          _ExportCard<Spell>(),
          _ExportCard<Item>(),
        ],
      ),
    );
  }
}

class _ExportCard<T> extends GetView<ImportExportController> {
  const _ExportCard({
    Key? key,
  }) : super(key: key);

  List<T> get list => controller.listByType<T>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Obx(
      () => Card(
        margin: const EdgeInsets.only(top: 16),
        child: ExpansionRow(
          initiallyExpanded: true,
          title: Text(
            S.current.myGeneric(S.current.entityPlural(T)),
            style: textTheme.titleLarge,
          ),
          trailing: [
            PopupMenuButton<bool>(
              onSelected: (state) => controller.toggleAllExport<T>(state),
              itemBuilder: (context) => [
                PopupMenuItem<bool>(
                  value: true,
                  child: Row(
                    children: [
                      const Icon(Icons.select_all),
                      const SizedBox(width: 8),
                      Text(S.current.selectAll)
                    ],
                  ),
                ),
                PopupMenuItem<bool>(
                  value: false,
                  child: Row(
                    children: [
                      const Icon(Icons.clear),
                      const SizedBox(width: 8),
                      Text(S.current.selectNone)
                    ],
                  ),
                ),
              ],
            )
          ],
          children: [
            for (final item in list)
              ListTile(
                onTap: () => controller.toggleExport<T>(item, !controller.isSelected<T>(item)),
                title: Text(nameFor(item)),
                leading: Checkbox(
                  value: controller.isSelected<T>(item),
                  onChanged: (state) => controller.toggleExport<T>(item, state!),
                ),
              ),
            if (list.isEmpty)
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  S.current.noGeneric(S.current.entityPlural(T)),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
