import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:uuid/uuid.dart';

import 'character_db.dart';
import 'character_utils.dart';

enum EquipmentKeys { key, item, amount }

class InventoryItem extends Equipment {
  num amount;

  InventoryItem({
    String key,
    String name,
    String pluralName,
    String description,
    List<Tag> tags,
    this.amount,
  }) : super(
          key: key ?? Uuid().v4(),
          name: name,
          pluralName: pluralName,
          description: description,
          tags: tags,
        );

  static InventoryItem fromEquipment(Equipment equipment, {int amount = 1}) {
    return InventoryItem(
      key: equipment.key ?? Uuid().v4(),
      name: equipment.name,
      description: equipment.description,
      pluralName: equipment.pluralName,
      tags: equipment.tags,
      amount: amount,
    );
  }

  static fromJSON(Map map) {
    var orig = Equipment.fromJSON(_getItem(map));
    return InventoryItem.fromEquipment(orig, amount: map['amount']);
  }

  static R _getItem<R>(Map map) {
    return map.containsKey('item') && map['item'] != null ? map['item'] : map;
  }

  @override
  Map toJSON() {
    Map map = super.toJSON();
    map['amount'] = amount;
    return map;
  }
}

ReturnPredicate<InventoryItem> invItemMatcher = matcher(
    (InventoryItem i, InventoryItem o) => i.key != null && i.key == o.key);

Future updateInventoryItem(InventoryItem item) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  num index = character.inventory.indexWhere(invItemMatcher(item));
  character.inventory[index] = item;
  await updateCharacter(character, [CharacterKeys.inventory]);
}

Future deleteInventoryItem(InventoryItem item) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  num index = character.inventory.indexWhere(invItemMatcher(item));
  character.inventory.removeAt(index);
  return updateCharacter(character, [CharacterKeys.inventory]);
}

Future createInventoryItem(InventoryItem item) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  character.inventory.add(item);
  return updateCharacter(character, [CharacterKeys.inventory]);
}

Future incrItemAmount(InventoryItem item, num amount) async {
  if (dwStore.state.characters.current == null) {
    throw ('No character loaded.');
  }

  DbCharacter character = dwStore.state.characters.current;
  item.amount += amount;
  item.amount = clamp(item.amount, 0, double.infinity).toInt();
  num index = character.inventory.indexWhere(invItemMatcher(item));
  print(item);
  print("matching: ${item.key}");
  character.inventory[index] = item;
  return await updateCharacter(character, [CharacterKeys.inventory]);
}
