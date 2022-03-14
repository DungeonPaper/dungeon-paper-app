import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_repository_items_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AddMovesView extends GetView<AddRepositoryItemsController<Move, MoveFilters>> {
  const AddMovesView({
    Key? key,
    required this.onAdd,
    this.defaultFilters,
  }) : super(key: key);

  final void Function(Iterable<Move> moves) onAdd;
  final MoveFilters? defaultFilters;

  RepositoryService get service => controller.repo;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<Move, MoveFilters>(
      title: Text(S.current.addMoves),
      initialFilters: defaultFilters,
      filtersBuilder: (filters, update) => Row(
        children: [
          DropdownButton<MoveCategory?>(
            value: filters?.category,
            items: [
              DropdownMenuItem<MoveCategory?>(
                child: Text(S.current.all),
                value: null,
              ),
              ...MoveCategory.values.map(
                (cat) => DropdownMenuItem<MoveCategory?>(
                  child: Text(S.current.moveCategory(cat)),
                  value: cat,
                ),
              ),
            ],
            onChanged: (cat) => update((filters ?? MoveFilters())..category = cat),
          ),
          DropdownButton<String>(
            value: filters?.classKey,
            items: [
              DropdownMenuItem<String>(
                child: Text(S.current.all),
                value: null,
              ),
              ...service.classes.values.map(
                (cls) => DropdownMenuItem<String>(
                  child: Text(cls.name),
                  value: cls.key,
                ),
              ),
            ],
            onChanged: (key) => update((filters ?? MoveFilters())..classKey = key),
          ),
        ],
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

class MoveFilters {
  MoveCategory? category;
  String? search;
  String? classKey;

  MoveFilters({
    this.category,
    this.search,
    this.classKey,
  });

  bool filter(Move move) {
    String clean(String str) => str.toLowerCase().trim();
    if (category != null) {
      if (move.category != category) {
        return false;
      }
    }

    if (search != null && search!.isNotEmpty) {
      if (![
        move.name,
        move.description,
        move.explanation,
        ...move.tags.map((t) => t.name),
        ...move.tags.map((t) => t.value),
      ].any((el) => clean(el).contains(clean(search!)))) {
        return false;
      }
    }

    if (classKey != null) {
      if (!move.classKeys.map(clean).contains(clean(classKey!))) {
        return false;
      }
    }
    return true;
  }
}
