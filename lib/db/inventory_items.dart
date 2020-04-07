import 'package:dungeon_paper/refactor/character.dart';
import 'package:dungeon_paper/utils.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:uuid/uuid.dart';

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

  @override
  InventoryItem copy() {
    return InventoryItem.fromJSON(toJSON());
  }
}

ReturnPredicate<InventoryItem> invItemMatcher = matcher(
    (InventoryItem i, InventoryItem o) => i.key != null && i.key == o.key);

Future updateInventoryItem(Character character, InventoryItem item) async {
  await character.update(json: {
    'inventory': findAndReplaceInList(character.inventory, item),
  });
}

Future deleteInventoryItem(Character character, InventoryItem item) async {
  return character
      .update(json: {'inventory': removeFromList(character.inventory, item)});
}

Future createInventoryItem(Character character, InventoryItem item) async {
  character.inventory.add(item);
  return character
      .update(json: {'inventory': addToList(character.inventory, item)});
}

Future incrItemAmount(
    Character character, InventoryItem item, num amount) async {
  return await character.update(json: {
    'inventory': findAndReplaceInList(
      character.inventory,
      item..amount = clamp(amount, 0, double.infinity).toInt(),
    ),
  });
}
