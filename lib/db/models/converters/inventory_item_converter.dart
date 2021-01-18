import 'package:dungeon_paper/db/models/inventory_items.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

class InventoryItemConverter
    implements JsonConverter<InventoryItem, Map<String, dynamic>> {
  const InventoryItemConverter();

  @override
  InventoryItem fromJson(Map<String, dynamic> json) {
    if (json == null) {
      return null;
    }
    return InventoryItem.fromJSON(json);
  }

  @override
  Map<String, dynamic> toJson(InventoryItem data) => data.toJSON();
}
