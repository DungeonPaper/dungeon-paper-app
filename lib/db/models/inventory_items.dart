import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:uuid/uuid.dart';

import 'character.dart';

enum EquipmentKeys { key, item, amount }

class InventoryItem extends Equipment {
  num amount;
  bool equipped;

  InventoryItem({
    String key,
    String name,
    String pluralName,
    String description,
    List<Tag> tags,
    this.amount,
    this.equipped = false,
  }) : super(
          key: key ?? Uuid().v4(),
          name: name,
          pluralName: pluralName,
          description: description,
          tags: tags,
        );

  static InventoryItem fromEquipment(
    Equipment equipment, {
    int amount = 1,
    bool equipped = false,
  }) {
    return InventoryItem(
      key: equipment.key ?? Uuid().v4(),
      name: equipment.name,
      description: equipment.description,
      pluralName: equipment.pluralName,
      tags: equipment.tags,
      amount: amount,
      equipped: equipped,
    );
  }

  factory InventoryItem.fromJSON(Map map) {
    var orig = Equipment.fromJSON(_getItem(map));
    return InventoryItem.fromEquipment(
      orig,
      amount: map['amount'],
      equipped: map['equipped'],
    );
  }

  static R _getItem<R>(Map map) {
    return map.containsKey('item') && map['item'] != null ? map['item'] : map;
  }

  @override
  Map toJSON() => {
        ...super.toJSON(),
        'amount': amount,
        'equipped': equipped,
      };

  @override
  InventoryItem copy({bool regenerateKey = false}) {
    return InventoryItem.fromJSON({
      ...toJSON(),
      if (regenerateKey == true) 'key': Uuid().v4(),
    });
  }
}

ReturnPredicate<InventoryItem> invItemMatcher = matcher(
    (InventoryItem i, InventoryItem o) => i.key != null && i.key == o.key);

Future<void> updateInventoryItem(
    Character character, InventoryItem item) async {
  return character.update(json: {
    'inventory': findAndReplaceInList(character.inventory, item),
  });
}

Future<void> deleteInventoryItem(
    Character character, InventoryItem item) async {
  return character
      .update(json: {'inventory': removeFromList(character.inventory, item)});
}

Future<void> createInventoryItem(
    Character character, InventoryItem item) async {
  final found = character.inventory
      .firstWhere((it) => it.name == item.name, orElse: () => null);
  if (found != null) {
    return character.update(json: {
      'inventory': findAndReplaceInList(character.inventory, found..amount += 1)
    });
  }
  return character
      .update(json: {'inventory': addToList(character.inventory, item)});
}

Future<void> incrItemAmount(
    Character character, InventoryItem item, num amount) async {
  return await character.update(json: {
    'inventory': findAndReplaceInList(
      character.inventory,
      item..amount = clamp(amount, 0, double.infinity).toInt(),
    ),
  });
}
