import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_paper/db/inventory.dart';
import 'package:dungeon_paper/equipment_view/inventory_item_card.dart';
import 'package:dungeon_world_data/dw_data.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:flutter/material.dart';

class AddInventoryItem extends StatelessWidget {
  AddInventoryItem({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Map<String, List<Equipment>> items = {};
    dungeonWorld.equipment.values.forEach((item) {
      String key =
          item.name.isNotEmpty ? item.name.trim()[0].toUpperCase() : '#';
      items[key] ??= [];
      items[key].add(item);
    });
    return CategorizedList.builder(
      categories: items.keys.toList()..sort(),
      itemCount: (key, idx) => items[key].length,
      titleBuilder: (ctx, key, idx) => Text(key),
      itemBuilder: (ctx, key, idx) {
        var item = items[key][idx];
        return Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: InventoryItemCard(
            item: InventoryItem({'item': item.toJSON(), 'amount': 1}),
            index: idx,
            mode: InventoryItemCardMode.Addable,
          ),
        );
      },
    );
  }
}
