import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_repository_items_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/move_filters.dart';

class AddMovesView extends GetView<AddRepositoryItemsController<Move, MoveFilters>> {
  const AddMovesView({
    Key? key,
    required this.onAdd,
    required this.selections,
    required this.classKeys,
    required this.rollStats,
  }) : super(key: key);

  final void Function(Iterable<Move> moves) onAdd;
  final Iterable<Move> selections;
  final List<String> classKeys;
  final RollStats rollStats;

  RepositoryService get service => controller.repo.value;
  Character get char => controller.chars.value.current!;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<Move, MoveFilters>(
      storageKey: 'Moves',
      title: Text(S.current.addGeneric(S.current.entityPlural(Move))),
      extraData: {'classKeys': classKeys, 'rollStats': rollStats},
      filtersBuilder: (group, filters, onChange) => MoveFiltersView(
        group: group,
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      filterFn: (moves, filters) => filters.filter(moves),
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
                    rollStats: char.rollStats,
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
