import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/move_filters.dart';

class MovesLibraryListView extends GetView<LibraryListController<Move, MoveFilters>> {
  const MovesLibraryListView({
    Key? key,
    required this.onAdd,
    required this.selections,
    required this.classKeys,
    required this.abilityScores,
  }) : super(key: key);

  final void Function(Iterable<Move> moves) onAdd;
  final Iterable<Move> selections;
  final List<String> classKeys;
  final AbilityScores abilityScores;

  RepositoryService get service => controller.repo.value;
  Character get char => controller.chars.value.current!;

  @override
  Widget build(BuildContext context) {
    return LibraryListView<Move, MoveFilters>(
      storageKey: 'Moves',
      title: Text(S.current.addGeneric(S.current.entityPlural(Move))),
      extraData: {'classKeys': classKeys, 'abilityScores': abilityScores},
      filtersBuilder: (group, filters, onChange) => MoveFiltersView(
        group: group,
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      filterFn: (move, filters) => filters.filter(move),
      sortFn: (filters) => Move.sorter(filters),
      cardBuilder: (
        ctx,
        move, {
        required selected,
        required selectable,
        onToggle,
        onUpdate,
        onDelete,
        required label,
        required icon,
      }) =>
          MoveCard(
        move: move,
        showDice: false,
        showStar: false,
        actions: [
          EntityEditMenu(
            onEdit: onUpdate != null
                ? CharacterUtils.openMovePage(
                    abilityScores: char.abilityScores,
                    classKeys: move.classKeys,
                    move: move,
                    onSave: onUpdate,
                  )
                : null,
            onDelete: onDelete != null ? () => onDelete(move) : null,
          ),
          ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: onToggle,
            label: label,
            icon: icon,
          ),
        ],
      ),
      onAdd: onAdd,
      preSelections: selections,
    );
  }
}
