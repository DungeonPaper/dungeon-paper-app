import 'dart:convert';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/item_filters.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/icon_utils.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

import 'item_settings.dart';
import 'meta.dart';

class Item extends dw.Item with WithIcon implements WithMeta {
  Item({
    required Meta super.meta,
    this.amount = 1,
    required super.key,
    required super.name,
    required super.description,
    required this.settings,
    this.equipped = false,
    required super.tags,
  }) : _meta = meta;

  @override
  Meta get meta => _meta;
  final Meta _meta;
  final ItemSettings settings;
  final double amount;
  final bool equipped;

  dw.Tag? findTag(String name) => tags
      .cast<dw.Tag?>()
      .firstWhereOrNull((tag) => cleanStr(tag?.name ?? '') == name);
  bool get isWorn => findTag('worn') != null;

  int get weight => settings.countWeight ? tagIntValue('weight') ?? 0 : 0;
  int get armor =>
      settings.countArmor && isWorn && equipped ? tagIntValue('armor') ?? 0 : 0;
  int get damage =>
      settings.countDamage && equipped ? tagIntValue('damage') ?? 0 : 0;

  int? tagIntValue(String name) {
    final tag = findTag(name);
    if (tag == null) {
      return null;
    }
    // debugPrint('tagIntValue: $tag');
    if (tag.value is int) {
      return tag.value;
    } else if (tag.value is String) {
      final match = RegExp(r'\d+').firstMatch(tag.value)?.group(0);
      if (match != null) {
        return int.tryParse(match);
      }
    }

    return null;
  }

  @override
  Item copyWithInherited({
    Meta? meta,
    double? amount,
    String? key,
    String? name,
    String? description,
    bool? equipped,
    ItemSettings? settings,
    List<dw.Tag>? tags,
  }) =>
      Item(
        meta: meta ?? this.meta,
        amount: amount ?? this.amount,
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        equipped: equipped ?? this.equipped,
        settings: settings ?? this.settings,
        tags: tags ?? this.tags,
      );

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  factory Item.fromDwItem(
    dw.Item item, {
    Map<String, dynamic>? settings,
    double? amount,
    bool? equipped,
  }) =>
      Item(
        meta: Meta.tryParse(item.meta),
        amount: amount ?? 1,
        key: item.key,
        name: item.name,
        description: item.description,
        tags: item.tags,
        equipped: equipped ?? false,
        settings:
            settings != null ? ItemSettings.fromJson(settings) : ItemSettings(),
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item.fromDwItem(
        dw.Item.fromJson(json),
        amount: ((json['amount'] ?? 0) as num).toDouble(),
        settings: json['settings'],
        equipped: json['equipped'],
      );

  factory Item.empty() => Item(
        description: '',
        key: uuid(),
        meta: Meta.empty(),
        name: '',
        settings: ItemSettings(),
        tags: [],
        amount: 1,
        equipped: false,
      );

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(),
        '_meta': meta.toJson(),
        'amount': amount,
        'equipped': equipped,
        'settings': settings.toJson(),
      };

  @override
  IconData get icon => genericIcon;
  static IconData get genericIcon => DwIcons.swap_bag;
  static int Function(Item a, Item b) sorter(ItemFilters filters) =>
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase());

  static List<Item> unifyItems(Iterable<Item> items) {
    final map = <String, Item>{};
    for (final item in items) {
      if (map[item.key] != null) {
        map[item.key] =
            map[item.key]!.copyWithInherited(amount: map[item.key]!.amount + 1);
      } else {
        map[item.key] = item;
      }
    }
    return map.values.toList();
  }

  @override
  String get displayName => name;

  @override
  String get storageKey => Meta.storageKeyFor(Item);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Item &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          name == other.name &&
          description == other.description &&
          tags == other.tags &&
          settings == other.settings &&
          amount == other.amount &&
          equipped == other.equipped;

  @override
  int get hashCode => Object.hashAll(
      [key, name, description, tags, settings, amount, equipped]);

  @override
  String get debugProperties =>
      'meta: $meta, key: $key, name: $name, description: $description, tags: $tags, settings: $settings, amount: $amount, equipped: $equipped';

  @override
  String toString() => 'Item($debugProperties)';
}
