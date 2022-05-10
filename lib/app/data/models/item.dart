import 'dart:convert';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/filters/item_filters.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import 'item_settings.dart';
import 'meta.dart';

class Item extends dw.Item implements WithMeta {
  Item({
    required Meta meta,
    this.amount = 1,
    required String key,
    required String name,
    required String description,
    required this.settings,
    this.equipped = false,
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
  final bool equipped;

  int get weight => settings.countWeight
      ? tags
              .cast<dw.Tag?>()
              .firstWhere((tag) => cleanStr(tag?.name ?? '') == 'weight', orElse: () => null)
              ?.value ??
          0
      : 0;

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
        settings: settings != null ? ItemSettings.fromJson(settings) : ItemSettings(),
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item.fromDwItem(
        dw.Item.fromJson(json),
        amount: json['amount'],
        settings: json['settings'],
        equipped: json['equipped'],
      );

  factory Item.empty() => Item(
        description: '',
        key: uuid(),
        meta: Meta.version(1),
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
      };

  DwIconData get icon => DwIcons.swap_bag;
  static DwIconData get genericIcon => DwIcons.swap_bag;
  static int Function(Item a, Item b) sorter(ItemFilters filters) =>
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase());

  static List<Item> unifyItems(Iterable<Item> items) {
    final map = <String, Item>{};
    for (final item in items) {
      if (map[item.key] != null) {
        map[item.key] = map[item.key]!.copyWithInherited(amount: map[item.key]!.amount + 1);
      } else {
        map[item.key] = item;
      }
    }
    return map.values.toList();
  }
}
