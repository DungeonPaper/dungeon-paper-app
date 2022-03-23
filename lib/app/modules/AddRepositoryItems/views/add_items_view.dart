import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_repository_items_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/item_filters.dart';

class AddItemsView extends GetView<AddRepositoryItemsController<Item, ItemFilters>> {
  const AddItemsView({
    Key? key,
    required this.onAdd,
    required this.selections,
  }) : super(key: key);

  final void Function(Iterable<Item> items) onAdd;
  final Iterable<Item> selections;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<Item, ItemFilters>(
      storageKey: 'Items',
      title: Text(S.current.addGeneric(S.current.entityPlural(Item))),
      filterFn: (item, filters) => filters.filter(item),
      filtersBuilder: (filters, update) => ItemFiltersView(
        filters: filters,
        onChange: controller.setFilters,
        searchController: controller.search,
      ),
      cardBuilder: (ctx, item, {required onSelect, required selected, required selectable}) =>
          ItemCard(
        item: item,
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
          )
        ],
      ),
      onAdd: onAdd,
      selections: selections,
    );
  }
}
