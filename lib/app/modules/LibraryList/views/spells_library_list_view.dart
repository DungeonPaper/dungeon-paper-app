import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/spell_filters.dart';

class SpellsLibraryListView extends GetView<LibraryListController<Spell, SpellFilters>> {
  const SpellsLibraryListView({
    Key? key,
    required this.onAdd,
    required this.selections,
    required this.classKeys,
    required this.rollStats,
  }) : super(key: key);

  final void Function(Iterable<Spell> spells) onAdd;
  final Iterable<Spell> selections;
  final List<String> classKeys;
  final RollStats rollStats;

  Character get char => controller.chars.value.current!;

  @override
  Widget build(BuildContext context) {
    return LibraryListView<Spell, SpellFilters>(
      storageKey: 'Spells',
      title: Text(S.current.addGeneric(S.current.entityPlural(Spell))),
      filterFn: (spell, filters) => filters.filter(spell),
      sortFn: (filters) => Spell.sorter(filters),
      filtersBuilder: (group, filters, onChange) => SpellFiltersView(
        group: group,
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      extraData: {'classKeys': classKeys, 'rollStats': rollStats},
      cardBuilder: (
        ctx,
        spell, {
        required selected,
        required selectable,
        onToggle,
        onUpdate,
        onDelete,
        required label,
        required icon,
      }) =>
          SpellCard(
        spell: spell,
        showDice: false,
        showStar: false,
        actions: [
          EntityEditMenu(
            onEdit: onUpdate != null
                ? CharacterUtils.openSpellPage(
                    rollStats: char.rollStats,
                    classKeys: spell.classKeys,
                    spell: spell,
                    onSave: onUpdate,
                  )
                : null,
            onDelete: onDelete != null ? () => onDelete(spell) : null,
          ),
          ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: onToggle,
            label: label,
            icon: icon,
          )
        ],
      ),
      onAdd: onAdd,
      preSelections: selections,
    );
  }
}
