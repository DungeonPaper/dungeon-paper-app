import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_repository_items_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
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
  Character get char => controller.chars.value.current!;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<Item, ItemFilters>(
      storageKey: 'Items',
      title: Text(S.current.addGeneric(S.current.entityPlural(Item))),
      filterFn: (item, filters) => filters.filter(item),
      filtersBuilder: (group, filters, onChange) => ItemFiltersView(
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      cardBuilder: (
        ctx,
        item, {
        required selected,
        required selectable,
        onToggle,
        onUpdate,
        onDelete,
        required label,
        required icon,
      }) =>
          ItemCard(
        item: item,
        showStar: false,
        actions: [
          EntityEditMenu(
            onEdit: onUpdate != null
                ? CharacterUtils.openItemPage(
                    item: item,
                    onSave: onUpdate,
                  )
                : null,
            onDelete: onDelete != null ? () => onDelete(item) : null,
          ),
          ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: onToggle,
            label: label,
            icon: icon,
          )
        ],
      ),
      onAdd: onAdd,
      selections: selections,
    );
  }
}
