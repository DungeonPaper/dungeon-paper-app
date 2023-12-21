import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/widgets/cards/race_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'filters/race_filters.dart';
import 'library_select_button.dart';

class RacesLibraryListView extends StatelessWidget
    with CharacterProviderMixin, RepositoryProviderMixin {
  const RacesLibraryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryListController<Race, RaceFilters>>(
      builder: (context, controller, _) => LibraryListView<Race, RaceFilters>(
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
          trailing: [
            if (controller.selectable)
              LibrarySelectButton<Race>.icon(
                selected: data.selected,
                onPressed: data.onToggle,
              )
          ],
          actions: [
            EntityEditMenu(
              onEdit: data.onUpdate != null
                  ? () => ModelPages.openRacePage(
                        context,
                        abilityScores: maybeChar?.abilityScores ??
                            AbilityScores.dungeonWorldAll(10),
                        race: data.item,
                        onSave: data.onUpdate!,
                      )
                  : null,
              onDelete: data.onDelete != null
                  ? () => data.onDelete!(data.item)
                  : null,
            ),
            if (controller.selectable)
              LibrarySelectButton<Race>(
                selected: data.selected,
                onPressed: data.onToggle,
              )
          ],
        ),
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
            FiltersGroup.playbook:
                RaceFilters(classKey: character?.characterClass.key),
            FiltersGroup.my:
                RaceFilters(classKey: character?.characterClass.key),
          },
          extraData: {
            'abilityScores': character?.abilityScores,
            'classKeys':
                character != null ? [character.characterClass.key] : null,
          },
          onSelected:
              onSelected != null ? (race) => onSelected.call(race.first) : null,
          multiple: false,
        );
}
