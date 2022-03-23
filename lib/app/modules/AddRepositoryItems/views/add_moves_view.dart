import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_repository_items_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/move_filters.dart';

class AddMovesView extends GetView<AddRepositoryItemsController<Move, MoveFilters>> {
  const AddMovesView({
    Key? key,
    required this.onAdd,
    required this.selections,
  }) : super(key: key);

  final void Function(Iterable<Move> moves) onAdd;
  final Iterable<Move> selections;

  RepositoryService get service => controller.repo;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<Move, MoveFilters>(
      storageKey: 'Moves',
      title: Text(S.current.addGeneric(S.current.entityPlural(Move))),
      filtersBuilder: (filters, update) => MoveFiltersView(
        filters: filters,
        onChange: update,
        searchController: controller.search,
      ),
      filterFn: (moves, filters) => filters.filter(moves),
      cardBuilder: (ctx, move, {required onSelect, required selected, required selectable}) =>
          MoveCard(
        move: move,
        showDice: false,
        showStar: false,
        actions: [
          ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: selectable ? () => onSelect(!selected) : null,
            label: Text(selectable
                ? !selected
                    ? S.current.select
                    : S.current.remove
                : S.current.alreadyAdded),
            icon: Icon(!selected ? Icons.add : Icons.remove),
          ),
        ],
      ),
      onAdd: onAdd,
      selections: selections,
    );
  }
}
