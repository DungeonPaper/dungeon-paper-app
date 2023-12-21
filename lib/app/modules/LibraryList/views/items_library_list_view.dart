import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/model_utils/model_pages.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/library_list_view.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'filters/item_filters.dart';
import 'library_select_button.dart';

class ItemsLibraryListView extends StatelessWidget {
  const ItemsLibraryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LibraryListController<Item, ItemFilters>>(
      builder: (context, controller, _) => LibraryListView<Item, ItemFilters>(
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
          trailing: [
            if (controller.selectable)
              LibrarySelectButton<Item>.icon(
                selected: data.selected,
                onPressed: data.onToggle,
              )
          ],
          actions: [
            EntityEditMenu(
              onEdit: data.onUpdate != null
                  ? () => ModelPages.openItemPage(
                        context,
                        item: data.item,
                        onSave: data.onUpdate!,
                      )
                  : null,
              onDelete: data.onDelete != null
                  ? () => data.onDelete!(data.item)
                  : null,
            ),
            if (controller.selectable)
              LibrarySelectButton<Item>(
                selected: data.selected,
                onPressed: data.onToggle,
              )
          ],
        ),
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
