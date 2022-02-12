import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'item_settings.dart';
import 'meta.dart';

class Item extends dw.Item {
  Item({
    required SharedMeta meta,
    required int amount,
    required String key,
    required String name,
    required this.settings,
    required List<dw.Tag> tags,
  })  : _meta = meta,
        super(
          meta: meta,
          amount: amount,
          key: key,
          name: name,
          tags: tags,
        );

  @override
  SharedMeta get meta => _meta;
  final SharedMeta _meta;
  final ItemSettings settings;

  Item copyWithInherited({
    SharedMeta? meta,
    int? amount,
    String? key,
    String? name,
    ItemSettings? settings,
    List<dw.Tag>? tags,
  }) =>
      Item(
        meta: meta ?? this.meta,
        amount: amount ?? this.amount,
        key: key ?? this.key,
        name: name ?? this.name,
        settings: settings ?? this.settings,
        tags: tags ?? this.tags,
      );

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  factory Item.fromDwItem(dw.Item item, {ItemSettings? settings}) => Item(
        meta: item.meta != null
            ? SharedMeta.fromJson(item.meta)
            : SharedMeta.version(1),
        amount: item.amount,
        key: item.key,
        name: item.name,
        tags: item.tags,
        settings: settings ?? ItemSettings(),
      );

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item.fromDwItem(dw.Item.fromJson(json));

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        "_meta": meta.toJson(),
      };
}
