import 'dart:convert';

import 'item_settings.dart';
import 'meta.dart';
import 'tag.dart';

class Item {
  Item({
    required this.meta,
    required this.amount,
    required this.key,
    required this.name,
    required this.settings,
    required this.tags,
  });

  final Meta meta;
  final int amount;
  final String key;
  final String name;
  final ItemSettings settings;
  final List<Tag> tags;

  Item copyWith({
    Meta? meta,
    int? amount,
    String? key,
    String? name,
    ItemSettings? settings,
    List<Tag>? tags,
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

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        meta: Meta.fromJson(json["_meta"]),
        amount: json["amount"],
        key: json["key"],
        name: json["name"],
        settings: ItemSettings.fromJson(json["settings"]),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_meta": meta.toJson(),
        "amount": amount,
        "key": key,
        "name": name,
        "settings": settings.toJson(),
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };
}
