import 'package:dungeon_paper/src/utils/utils.dart';
import 'package:dungeon_world_data/equipment.dart';
import 'package:dungeon_world_data/tag.dart';
import 'package:uuid/uuid.dart';

import 'character.dart';

enum EquipmentKeys { key, item, amount }

class InventoryItem extends Equipment {
  num amount;
  bool equipped;
  bool countWeight;
  bool countDamage;
  bool countArmor;

  InventoryItem({
    String key,
    String name,
    String pluralName,
    String description,
    List<Tag> tags,
    this.amount,
    this.equipped = false,
    this.countWeight = true,
    this.countDamage = true,
    this.countArmor = true,
  }) : super(
          key: key ?? Uuid().v4(),
          name: name ?? '',
          pluralName: pluralName,
          description: description ?? '',
          tags: tags ?? [],
        );

  static InventoryItem fromEquipment(
    Equipment equipment, {
    int amount = 1,
    bool equipped = false,
    bool countWeight = true,
    bool countDamage = true,
    bool countArmor = true,
  }) {
    return InventoryItem(
      key: equipment.key ?? Uuid().v4(),
      name: equipment.name ?? '',
      description: equipment.description ?? '',
      pluralName: equipment.pluralName,
      tags: equipment.tags ?? [],
      amount: amount ?? 1,
      equipped: equipped ?? false,
      countWeight: countWeight ?? true,
      countDamage: countDamage ?? true,
      countArmor: countArmor ?? true,
    );
  }

  bool get hasDamage =>
      tags?.firstWhere(
        (t) => t?.name?.toLowerCase() == 'damage',
        orElse: () => null,
      ) !=
      null;

  bool get hasWeight =>
      tags?.firstWhere(
        (t) => t?.name?.toLowerCase() == 'weight',
        orElse: () => null,
      ) !=
      null;

  bool get hasArmor =>
      tags?.firstWhere(
        (t) => t?.name?.toLowerCase() == 'armor',
        orElse: () => null,
      ) !=
      null;

  int get armor {
    if (!countArmor) {
      return 0;
    }

    final armor = tags?.firstWhere(
      (t) => t?.name?.toLowerCase() == 'armor',
      orElse: () => null,
    );
    if (armor != null && armor.hasValue) {
      var armorValue = 0;
      if (armor.value is num) {
        armorValue += armor.value;
      } else {
        armorValue += int.tryParse(armor.value ?? '0') ?? 0.0;
      }
      return armorValue * amount;
    }
    return 0;
  }

  double get weight {
    if (!countWeight) {
      return 0;
    }

    final armor = tags?.firstWhere(
      (t) => t?.name?.toLowerCase() == 'weight',
      orElse: () => null,
    );
    if (name == 'Axe') {
      print(this.toString());
    }
    if (armor != null && armor.hasValue) {
      var weightValue = 0.toDouble();
      if (armor.value is num) {
        weightValue += armor.value;
      } else {
        weightValue += double.tryParse(armor.value ?? '0') ?? 0.0;
      }
      return weightValue * amount;
    }
    return 0;
  }

  int get damage {
    if (!countDamage) {
      return 0;
    }

    final damage = tags?.firstWhere(
      (t) => t?.name?.toLowerCase() == 'damage',
      orElse: () => null,
    );
    if (damage != null && damage.hasValue) {
      var damageValue = 0;
      if (damage.value is num) {
        damageValue += damage.value;
      } else {
        damageValue += int.tryParse(damage.value ?? 0) ?? 0;
      }
      return damageValue;
    }
    return 0;
  }

  factory InventoryItem.fromJSON(Map map) {
    var orig = Equipment.fromJSON(_getItem(map));
    return InventoryItem.fromEquipment(
      orig,
      amount: map['amount'],
      equipped: map['equipped'] ?? false,
      countWeight: map['count_weight'] ?? true,
      countDamage: map['count_damage'] ?? true,
      countArmor: map['count_armor'] ?? true,
    );
  }

  static R _getItem<R>(Map map) {
    return map.containsKey('item') && map['item'] != null ? map['item'] : map;
  }

  @override
  Map toJSON() => {
        ...super.toJSON(),
        'amount': amount,
        'equipped': equipped ?? false,
        'count_weight': countWeight ?? true,
        'count_damage': countDamage ?? true,
        'count_armor': countArmor ?? true,
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
