import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'item_settings.dart';
import 'meta.dart';

class Item extends dw.Item {
  Item({
    required Meta meta,
    this.amount = 1,
    required String key,
    required String name,
    required String description,
    required this.settings,
    required List<dw.Tag> tags,
  })  : _meta = meta,
        super(
          meta: meta,
          key: key,
          name: name,
          description: description,
          tags: tags,
        );

  @override
  Meta get meta => _meta;
  final Meta _meta;
  final ItemSettings settings;
  final double amount;

  Item copyWithInherited({
    Meta? meta,
    double? amount,
    String? key,
    String? name,
    String? description,
    ItemSettings? settings,
    List<dw.Tag>? tags,
  }) =>
      Item(
        meta: meta ?? this.meta,
        amount: amount ?? this.amount,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        settings: settings ?? this.settings,
        tags: tags ?? this.tags,
      );

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  factory Item.fromDwItem(
    dw.Item item, {
    Map<String, dynamic>? settings,
    double? amount,
  }) =>
      Item(
        meta: item.meta != null ? Meta.fromJson(item.meta) : Meta.version(1),
        amount: amount ?? 1,
        key: item.key,
        name: item.name,
        description: item.description,
        tags: item.tags,
        settings: settings != null ? ItemSettings.fromJson(settings) : ItemSettings(),
      );

  factory Item.fromJson(Map<String, dynamic> json) =>
      Item.fromDwItem(dw.Item.fromJson(json), amount: json['amount'], settings: json['settings']);

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '_meta': meta.toJson(),
        'amount': amount,
      };
}
