import 'package:dungeon_paper/components/categorized_list.dart';
import 'package:dungeon_paper/db/character.dart';
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
      itemCount: (ctx, cat) => equipment.length,
      titleBuilder: (ctx, cat, i) => Text('Posessions'),
      itemBuilder: (ctx, cat, i) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: InventoryItemCard(
              index: i,
              item: equipment[i],
              mode: InventoryItemCardMode.Editable,
            ),
          ),
      categories: ['equipment'],
    );
  }
}
