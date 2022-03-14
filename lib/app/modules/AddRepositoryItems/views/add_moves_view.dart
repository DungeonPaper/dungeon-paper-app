import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_repository_items_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/move_card.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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

class MoveFiltersView extends StatelessWidget {
  MoveFiltersView(
      {Key? key, required this.filters, required this.onChange, required this.searchController})
      : super(key: key);

  final MoveFilters? filters;
  final service = Get.find<RepositoryService>();
  final void Function(MoveFilters) onChange;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: S.current.searchPlaceholderEntity(S.current.entity(Move)),
          ),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            DropdownButton<MoveCategory?>(
              value: filters?.category,
              items: [
                DropdownMenuItem<MoveCategory?>(
                  child: Text(S.current.allEntity(S.current.entityPlural(MoveCategory))),
                  value: null,
                ),
                ...MoveCategory.values.map(
                  (cat) => DropdownMenuItem<MoveCategory?>(
                    child: Text(S.current.moveCategory(cat)),
                    value: cat,
                  ),
                ),
              ],
              onChanged: (cat) => onChange((filters ?? MoveFilters())..category = cat),
            ),
            const SizedBox(width: 8),
            DropdownButton<String>(
              value: filters?.classKey,
              items: [
                DropdownMenuItem<String>(
                  child: Text(S.current.allEntity(S.current.entityPlural(CharacterClass))),
                  value: null,
                ),
                ...service.classes.values.map(
                  (cls) => DropdownMenuItem<String>(
                    child: Text(cls.name),
                    value: cls.key,
                  ),
                ),
              ],
              onChanged: (key) => onChange((filters ?? MoveFilters())..classKey = key),
            ),
          ],
        ),
      ],
    );
  }
}

class MoveFilters extends EntityFilters<Move> {
  MoveCategory? category;
  String? search;
  String? classKey;

  MoveFilters({
    this.category,
    this.search,
    this.classKey,
  });

  @override
  // ignore: avoid_renaming_method_parameters
  bool filter(Move move) {
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
      ].any((el) => cleanStr(el).contains(cleanStr(search!)))) {
        return false;
      }
    }

    if (classKey != null) {
      if (!move.classKeys.map(cleanStr).contains(cleanStr(classKey!))) {
        return false;
      }
    }
    return true;
  }

  @override
  void setSearch(String search) {
    this.search = search;
  }
}
