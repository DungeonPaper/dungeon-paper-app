import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/equipment_view/coins_display.dart';
import 'package:dungeon_paper/equipment_view/inventory_item_card.dart';
import 'package:flutter/material.dart';

class InventoryView extends StatelessWidget {
  final DbCharacter character;

  const InventoryView({
    Key key,
    @required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var equipment = character.inventory;
    return CategorizedList.builder(
      itemCount: (ctx, cat) => cat == 0 ? 1 : equipment.length,
      titleBuilder: (ctx, cat, i) => cat == 'Coins' ? null : Text(cat),
      itemBuilder: childBuilderDelegator,
      categories: ['Coins', 'Posessions'],
      addSpacer: true,
    );
  }

  Widget childBuilderDelegator(BuildContext ctx, dynamic cat, num i) {
    var equipment = character.inventory;
    if (cat == 'Coins') {
      return Wrap(
          // alignment: Alignment.centerLeft,
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [CoinsDisplay(character: character)]);
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: InventoryItemCard(
        key: PageStorageKey(equipment[i].key),
        item: equipment[i],
        mode: InventoryItemCardMode.Editable,
      ),
    );
  }
}
