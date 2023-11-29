import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'filters/item_filters.dart';

class ItemsLibraryListView extends GetView<LibraryListController<Item, ItemFilters>> {
  const ItemsLibraryListView({
    Key? key,
  }) : super(key: key);

  Character get char => controller.chars.value.current;

  @override
  Widget build(BuildContext context) {
    return LibraryListView<Item, ItemFilters>(
      filtersBuilder: (group, filters, onChange) => ItemFiltersView(
        filters: filters,
        onChange: (f) => onChange(group, f),
        searchController: controller.search[group]!,
      ),
      cardBuilder: (ctx, data) => ItemCard(
        item: data.item,
        showStar: false,
        highlightWords: data.highlightWords,
        hideCount: true,
        actions: [
          EntityEditMenu(
            onEdit: data.onUpdate != null
                ? () => ModelPages.openItemPage(
                      item: data.item,
                      onSave: data.onUpdate!,
                    )
                : null,
            onDelete: data.onDelete != null ? () => data.onDelete!(data.item) : null,
          ),
          /*
          if (data.selectable)
            ElevatedButton.icon(
              style: ButtonThemes.primaryElevated(context),
              onPressed: data.onToggle,
              label: data.label,
              icon: data.icon,
            )
            */
        ],
      ),
    );
  }
}

class ItemLibraryListArguments extends LibraryListArguments<Item, ItemFilters> {
  ItemLibraryListArguments({
    required super.onSelected,
    required super.preSelections,
    super.initialTab,
  }) : super(
          sortFn: Item.sorter,
          filterFn: (item, filters) => filters.filter(item),
          filters: {
            FiltersGroup.playbook: ItemFilters(),
            FiltersGroup.my: ItemFilters(),
          },
          extraData: const {},
        );
}
