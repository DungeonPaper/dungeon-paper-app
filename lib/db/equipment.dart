import 'package:dungeon_paper/db/base.dart';
import 'package:dungeon_world_data/equipment.dart';

enum EquipmentKeys { item, amount }

class InventoryItem with Serializer<EquipmentKeys> {
  Equipment item;
  num amount;

  InventoryItem([Map map]) {
    map ??= {};
    initSerializeMap({
      EquipmentKeys.item: map['item'],
      EquipmentKeys.amount: map['amount'],
    });
  }

  @override
  toJSON() {
    return {
      'title': item,
      'description': amount,
    };
  }

  @override
  initSerializeMap([Map map]) {
    serializeMap = {
      EquipmentKeys.item: (v) {
        item = v ?? Equipment('', [], '');
      },
      EquipmentKeys.amount: (v) {
        amount = v ?? 1;
      },
    };
    return serializeAll(map);
  }
}
