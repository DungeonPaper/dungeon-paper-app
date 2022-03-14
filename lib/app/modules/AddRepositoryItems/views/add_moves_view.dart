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
  }) : super(key: key);

  final void Function(Iterable<Move> moves) onAdd;

  RepositoryService get service => controller.repo;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<Move, MoveFilters>(
      title: Text(S.current.addMoves),
      filtersBuilder: (filters, update) => MoveFiltersView(
        filters: filters,
        onChange: update,
        searchController: controller.search,
      ),
      filterFn: (moves, filters) => filters.filter(moves),
      cardBuilder: (ctx, move, {required onSelect, required selected}) => MoveCard(
        move: move,
        showDice: false,
        showStar: false,
        actions: [
          ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: () => onSelect(!selected),
            label: Text(!selected ? S.current.select : S.current.remove),
            icon: Icon(!selected ? Icons.add : Icons.remove),
          ),
        ],
      ),
      onAdd: onAdd,
    );
  }
}
