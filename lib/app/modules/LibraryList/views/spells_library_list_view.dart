import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/spell_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'filters/spell_filters.dart';

class SpellsLibraryListView extends GetView<LibraryListController<Spell, SpellFilters>> {
  const SpellsLibraryListView({
    Key? key,
  }) : super(key: key);

  Character get character => controller.chars.value.current;

  @override
  Widget build(BuildContext context) {
    return LibraryListView<Spell, SpellFilters>(
      filtersBuilder: (group, filters, onChange) => SpellFiltersView(
        group: group,
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      cardBuilder: (ctx, data) => SpellCard(
        spell: data.item,
        showDice: false,
        showStar: false,
        highlightWords: data.highlightWords,
        actions: [
          EntityEditMenu(
            onEdit: data.onUpdate != null
                ? () => ModelPages.openSpellPage(
                      abilityScores: character.abilityScores,
                      classKeys: data.item.classKeys,
                      spell: data.item,
                      onSave: data.onUpdate!,
                    )
                : null,
            onDelete: data.onDelete != null ? () => data.onDelete!(data.item) : null,
          ),
          /*
          if (data.selectable)
            ElevatedButton.icon(
              style: ButtonThemes.primaryElevated(context),
              onPressed: data.onToggle,
              label: data.label,
              icon: data.icon,
            ),
        ],
      ),
    );
  }
}

class SpellLibraryListArguments extends LibraryListArguments<Spell, SpellFilters> {
  SpellLibraryListArguments({
    required Character? character,
    required super.onSelected,
    required super.preSelections,
    super.initialTab,
    AbilityScores? abilityScores,
    List<dw.EntityReference>? classKeys,
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
            'abilityScores': abilityScores ?? character?.abilityScores,
            'classKeys': (classKeys?.isNotEmpty ?? false)
                ? classKeys
                : (character != null ? [character.characterClass.key] : null),
          },
        );
}
