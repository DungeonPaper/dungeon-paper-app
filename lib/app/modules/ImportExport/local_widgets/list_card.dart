import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/modules/ImportExport/controllers/import_export_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/custom_expansion_tile.dart';
import 'package:dungeon_paper/app/widgets/atoms/menu_button.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/dw_icons.dart';
import '../../../data/models/character.dart';
import '../../../data/models/character_class.dart';
import '../../../data/models/move.dart';
import '../../../data/models/race.dart';
import '../../../data/models/spell.dart';
import '../../../widgets/chips/primary_chip.dart';

enum ListCardType { import, export }

class ListCard<T extends WithMeta, C extends ImportExportSelectionData>
    extends StatelessWidget {
  const ListCard({
    super.key,
    required this.type,
  });

  final ListCardType type;
  List<T> list(BuildContext context) =>
      Provider.of<C>(context, listen: false).listByType<T>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<C>(
      builder: (context, controller, _) {
        final list = this.list(context);
        return Card(
          margin: const EdgeInsets.only(top: 16),
          child: CustomExpansionTile(
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
                    type == ListCardType.import
                        ? tr.entityPlural(tn(T))
                        : tr.generic.myEntity(tr.entityPlural(tn(T))),
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
                    label: Text(tr.generic.selectAll),
                    onSelect: () => controller.toggleAll<T>(true),
                  ),
                  MenuEntry<bool>(
                    value: false,
                    icon: const Icon(Icons.clear),
                    label: Text(tr.generic.selectNone),
                    onSelect: () => controller.toggleAll<T>(false),
                  ),
                ],
              ),
            ],
            children: [
              for (final item in list)
                Builder(builder: (context) {
                  final tags = tagsByType(item);
                  return ListTile(
                    onTap: () => controller.toggle<T>(
                        item, !controller.isSelected<T>(item)),
                    title: Text(item.displayName),
                    subtitle: tags.isNotEmpty
                        ? Wrap(
                            spacing: 8,
                            children: tags,
                          )
                        : null,
                    leading: Checkbox(
                      value: controller.isSelected<T>(item),
                      onChanged: (state) => controller.toggle<T>(item, state!),
                    ),
                  );
                }),
              if (list.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    tr.generic.noEntity(tr.entityPlural(tn(T))),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> tagsByType(T entity) {
    switch (entity.runtimeType) {
      case == Character:
        final char = entity as Character;
        return [
          PrimaryChip(
            icon: Icon(CharacterClass.genericIcon),
            label: char.characterClass.name,
          ),
          PrimaryChip(
            icon: const Icon(Icons.arrow_upward),
            label: tr.character.header.level(char.stats.level),
          ),
        ];
      case == CharacterClass:
        final cls = entity as CharacterClass;
        return [
          PrimaryChip(
            icon: const Icon(Icons.healing),
            // TODO intl?
            label: [tr.characterClass.baseHp, cls.hp].join(' '),
          ),
          PrimaryChip(
            icon: const Icon(DwIcons.dumbbell),
            // TODO intl?
            label: [tr.characterClass.baseLoad, cls.load].join(' '),
          ),
        ];
      case == Move:
        final move = entity as Move;
        return [
          PrimaryChip(
            icon: Icon(CharacterClass.genericIcon),
            label: move.classKeys.map((e) => e.name).join(', '),
          ),
          PrimaryChip(
            label: tr.moves.category.mediumName(move.category.name),
          ),
        ];
      case == Spell:
        final spell = entity as Spell;
        return [
          PrimaryChip(
            icon: Icon(CharacterClass.genericIcon),
            label: spell.classKeys.map((e) => e.name).join(', '),
          ),
          PrimaryChip(
            label: tr.spells.spellLevel(spell.level),
          ),
        ];
      case == Race:
        final race = entity as Race;
        return [
          PrimaryChip(
            icon: Icon(CharacterClass.genericIcon),
            label: race.classKeys.map((e) => e.name).join(', '),
          ),
        ];
      default:
        return [];
    }
  }
}
