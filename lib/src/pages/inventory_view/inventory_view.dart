import 'package:dungeon_paper/db/models/character.dart';
import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:dungeon_paper/src/atoms/armor_chip.dart';
import 'package:dungeon_paper/src/atoms/categorized_list.dart';
import 'package:dungeon_paper/src/atoms/coins_chip.dart';
import 'package:dungeon_paper/src/atoms/damage_chip.dart';
import 'package:dungeon_paper/src/atoms/empty_state.dart';
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
    final equipment = character.inventory;
    final emptyState = EmptyState(
      title: Text('Your inventory is empty'),
      subtitle: Text("Use the '+' button to add things to your possession."),
      assetName: 'bag.svg',
    );
    final isShort = MediaQuery.of(context).size.height < 420;

    if (equipment.isEmpty) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: InventoryInfoBar(character: character),
            ),
            SizedBox(height: 16),
            isShort
                ? emptyState
                : ConstrainedBox(
                    constraints: BoxConstraints(
                      // minHeight: 200,
                      maxHeight: MediaQuery.of(context).size.height - 300,
                    ),
                    child: emptyState,
                  ),
          ],
        ),
      );
    }

    return CategorizedList.builder(
      itemCount: (ctx, cat) => cat == 1 ? equipment.length : 1,
      titleBuilder: (ctx, cat, i) => EquipmentTitles[cat],
      itemBuilder: _itemBuilder,
      items: [
        EquipmentCats.Stats,
        EquipmentCats.Items,
      ],
      spacerCount: 1,
    );
  }

  Widget _itemBuilder(BuildContext ctx, EquipmentCats cat, num i, num catI) {
    var equipment = character.inventory;
    if (cat == EquipmentCats.Stats) {
      return InventoryInfoBar(character: character);
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

class InventoryInfoBar extends StatelessWidget {
  const InventoryInfoBar({
    Key key,
    @required this.character,
  }) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      // alignment: Alignment.centerLeft,
      spacing: 5,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        InventoryLoadChip(character: character),
        DamageChip(character: character),
        ArmorChip(character: character),
        CoinsChip(character: character),
      ],
    );
  }
}
