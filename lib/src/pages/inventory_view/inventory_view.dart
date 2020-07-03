import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/atoms/coins_chip.dart';
import 'package:dungeon_paper/src/atoms/empty_state.dart';
import 'package:dungeon_paper/src/atoms/inventory_load_chip.dart';
import 'package:dungeon_paper/src/molecules/inventory_item_card.dart';
import 'package:flutter/material.dart';

enum EquipmentCats {
  Stats,
  Items,
  EmptyState,
}

const EquipmentTitles = {
  EquipmentCats.Stats: null,
  EquipmentCats.Items: Text('Posessions'),
  EquipmentCats.EmptyState: null,
};

class InventoryView extends StatelessWidget {
  final Character character;

  const InventoryView({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var equipment = character.inventory;
    return CategorizedList.builder(
      itemCount: (ctx, cat) => cat == 1 ? equipment.length : 1,
      titleBuilder: (ctx, cat, i) => EquipmentTitles[cat],
      itemBuilder: _itemBuilder,
      items: [
        EquipmentCats.Stats,
        EquipmentCats.Items,
        if (equipment.isEmpty) EquipmentCats.EmptyState,
      ],
      spacerCount: 1,
    );
  }

  Widget _itemBuilder(BuildContext ctx, EquipmentCats cat, num i, num catI) {
    var equipment = character.inventory;

    if (cat == EquipmentCats.EmptyState) {
      return EmptyState(
        title: Text('Your inventory is empty'),
        subtitle: Text("Use the '+' button to add things to your possession."),
        assetName: 'bag.svg',
      );
    }

    if (cat == EquipmentCats.Stats) {
      return Wrap(
          // alignment: Alignment.centerLeft,
          spacing: 10.0,
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            InventoryLoadChip(character: character),
            CoinsChip(character: character),
          ]);
    }
    var item = equipment[i];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: InventoryItemCard(
        key: PageStorageKey(item.key),
        item: item,
        mode: InventoryItemCardMode.Editable,
        onSave: (item) => updateInventoryItem(character, item),
        onDelete: () => deleteInventoryItem(character, item),
      ),
    );
  }
}
