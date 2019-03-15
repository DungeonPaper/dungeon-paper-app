import 'package:dungeon_paper/db/base.dart';
import 'package:dungeon_paper/db/character.dart';
import 'package:dungeon_paper/redux/stores/stores.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:uuid/uuid.dart';

enum EquipmentKeys { key, item, amount }

class InventoryItem with Serializer<EquipmentKeys> {
  String key;
  Equipment item;
  num amount;

  InventoryItem([Map map]) {
    map ??= {};
    initSerializeMap({
      EquipmentKeys.key: map['key'],
      EquipmentKeys.item: map['item'],
      EquipmentKeys.amount: map['amount'],
    });
  }

  @override
  toJSON() {
    return {
      'key': key,
      'item': item.toJSON(),
      'amount': amount,
    };
  }

  @override
  initSerializeMap([Map map]) {
    serializeMap = {
      EquipmentKeys.key: (v) {
        key = v ?? Uuid().v4();
      },
      EquipmentKeys.item: (v) {
        Equipment nv = v is Equipment ? v : Equipment.fromJSON(v ?? {});
        item = nv;
      },
      EquipmentKeys.amount: (v) {
        amount = v ?? 1;
      },
    };
    return serializeAll(map);
  }
}

ReturnPredicate<InventoryItem> invItemMatcher = matcher(
    (InventoryItem i, InventoryItem o) =>
        i.key != null && i.key == o.key || i.item.key == o.item.key);

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
  character.inventory[index] = item;
  return await updateCharacter(character, [CharacterKeys.inventory]);
}
