import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/add_repository_items_view.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/cards/item_card.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

typedef ItemFilters = dynamic;

class AddItemsView extends GetView<AddRepositoryItemsController<Item, ItemFilters>> {
  const AddItemsView({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  final void Function(Iterable<Item> items) onAdd;

  @override
  Widget build(BuildContext context) {
    return AddRepositoryItemsView<Item, ItemFilters>(
      title: Text(S.current.addItems),
      cardBuilder: (ctx, item, {required onSelect, required selected}) => ItemCard(
        item: item,
        showStar: false,
        actions: [
          ElevatedButton.icon(
            style: ButtonThemes.primaryElevated(context),
            onPressed: () => onSelect(!selected),
            label: Text(!selected ? S.current.select : S.current.remove),
            icon: Icon(!selected ? Icons.add : Icons.remove),
          )
        ],
      ),
      onAdd: onAdd,
    );
  }
}
