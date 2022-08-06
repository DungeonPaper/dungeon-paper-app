import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/race_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/race_filters.dart';

class RacesLibraryListView extends GetView<LibraryListController<Race, RaceFilters>> {
  const RacesLibraryListView({
    Key? key,
  }) : super(key: key);

  RepositoryService get service => controller.repo.value;
  Character get char => controller.chars.value.current;

  @override
  Widget build(BuildContext context) {
    return LibraryListView<Race, RaceFilters>(
      filtersBuilder: (group, filters, onChange) => RaceFiltersView(
        group: group,
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      cardBuilder: (ctx, data) => RaceCard(
        race: data.item,
        showStar: false,
        showClasses: true,
        highlightWords: data.highlightWords,
        actions: [
          EntityEditMenu(
            onEdit: data.onUpdate != null
                ? () => ModelPages.openRacePage(
                      abilityScores: char.abilityScores,
                      race: data.item,
                      onSave: data.onUpdate!,
                    )
                : null,
            onDelete: data.onDelete != null ? () => data.onDelete!(data.item) : null,
          ),
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

class RaceLibraryListArguments extends LibraryListArguments<Race, RaceFilters> {
  RaceLibraryListArguments({
    required Character? character,
    required void Function(Race race)? onSelected,
    required super.preSelections,
    required super.initialTab,
  }) : super(
          sortFn: Race.sorter,
          filterFn: (race, filters) => filters.filter(race),
          filters: {
            FiltersGroup.playbook: RaceFilters(classKey: character?.characterClass.key),
            FiltersGroup.my: RaceFilters(classKey: character?.characterClass.key),
          },
          extraData: {
            'abilityScores': character?.abilityScores,
            'classKeys': character != null ? [character.characterClass.key] : null,
          },
          onSelected: onSelected != null ? (race) => onSelected.call(race.first) : null,
          multiple: false,
        );
}
