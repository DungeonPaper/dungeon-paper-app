import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/atoms/coins_chip.dart';
import 'package:dungeon_paper/src/atoms/inventory_load_chip.dart';
import 'package:dungeon_paper/src/molecules/inventory_item_card.dart';
import 'package:flutter/material.dart';

enum EquipmentCats {
  Stats,
  Items,
}

const EquipmentTitles = {
  EquipmentCats.Stats: null,
  EquipmentCats.Items: Text('Posessions'),
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
      itemCount: (ctx, cat) => cat == 0 ? 1 : equipment.length,
      titleBuilder: (ctx, cat, i) => EquipmentTitles[cat],
      itemBuilder: childBuilderDelegator,
      items: [EquipmentCats.Stats, EquipmentCats.Items],
      spacerCount: 1,
    );
  }

  Widget childBuilderDelegator(BuildContext ctx, dynamic cat, num i, num catI) {
    var equipment = character.inventory;
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

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: InventoryItemCard(
        key: PageStorageKey(equipment[i].key),
        item: equipment[i],
        mode: InventoryItemCardMode.Editable,
        onSave: (item) => updateInventoryItem(character, item),
        onDelete: () => deleteInventoryItem(character, equipment[i]),
      ),
    );
  }
}
