import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
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
  }) : super(key: key);

  Character get character => controller.chars.value.current;

  @override
  Widget build(BuildContext context) {
    return LibraryListView<Spell, SpellFilters>(
      title: Text(S.current.addGeneric(S.current.entityPlural(Spell))),
      filtersBuilder: (group, filters, onChange) => SpellFiltersView(
        group: group,
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
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
                ? () => ModelPages.openSpellPage(
                      abilityScores: character.abilityScores,
                      classKeys: spell.classKeys,
                      spell: spell,
                      onSave: onUpdate,
                    )
                : null,
            onDelete: onDelete != null ? () => onDelete(spell) : null,
          ),
          if (selectable)
            ElevatedButton.icon(
              style: ButtonThemes.primaryElevated(context),
              onPressed: onToggle,
              label: label,
              icon: icon,
            ),
        ],
      ),
    );
  }
}

class SpellLibraryListArguments extends LibraryListArguments<Spell, SpellFilters> {
  SpellLibraryListArguments({
    required Character? character,
    required super.onAdd,
    required super.preSelections,
  }) : super(
          sortFn: Spell.sorter,
          filterFn: (spell, filters) => filters.filter(spell),
          filters: {
            FiltersGroup.playbook: SpellFilters(
              classKey: character?.characterClass.key,
              level: null,
            ),
            FiltersGroup.my: SpellFilters(
              classKey: character?.characterClass.key,
              level: null,
            ),
          },
          extraData: {
            'abilityScores': character?.abilityScores,
            'classKeys': character != null ? [character.characterClass.key] : null,
          },
        );
}
