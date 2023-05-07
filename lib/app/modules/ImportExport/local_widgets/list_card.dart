import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/modules/ImportExport/controllers/import_export_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_panel.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListCard<T extends WithMeta, C extends ImportExportSelectionData> extends GetView<C> {
  const ListCard({
    Key? key,
  }) : super(key: key);

  List<T> get list => controller.listByType<T>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Obx(
      () => Card(
        margin: const EdgeInsets.only(top: 16),
        child: CustomExpansionPanel(
          initiallyExpanded: true,
          title: Row(
            children: [
              Icon(
                Meta.genericIconFor(T),
                color: textTheme.titleLarge!.color,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  S.current.myGeneric(S.current.entityPlural(T)),
                  style: textTheme.titleLarge,
                ),
              ),
            ],
          ),
          trailing: [
            MenuButton<bool>(
              items: [
                MenuEntry<bool>(
                  value: true,
                  icon: const Icon(Icons.select_all),
                  label: Text(S.current.selectAll),
                  onSelect: () => controller.toggleAll<T>(true),
                ),
                MenuEntry<bool>(
                  value: false,
                  icon: const Icon(Icons.clear),
                  label: Text(S.current.selectNone),
                  onSelect: () => controller.toggleAll<T>(false),
                ),
              ],
            ),
          ],
          children: [
            for (final item in list)
              ListTile(
                onTap: () => controller.toggle<T>(item, !controller.isSelected<T>(item)),
                title: Text(item.displayName),
                leading: Checkbox(
                  value: controller.isSelected<T>(item),
                  onChanged: (state) => controller.toggle<T>(item, state!),
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
