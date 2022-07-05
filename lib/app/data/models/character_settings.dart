import 'dart:convert';

import 'package:dungeon_paper/app/data/models/roll_button.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:flutter/material.dart';

enum RacePosition { start, end }

@immutable
class CharacterSettings {
  const CharacterSettings({
    this.noteCategories = const NoteCategoryList(
      sortOrder: {},
    ),
    this.actionCategories = const ActionCategoryList(
      sortOrder: {},
      hidden: {},
    ),
    this.quickCategories = const ActionCategoryList(
      sortOrder: {},
      hidden: {},
    ),
    this.sortOrder,
    this.category,
    required this.rollButtons,
    this.racePosition = RacePosition.start,
  });

  final NoteCategoryList noteCategories;
  final ActionCategoryList actionCategories;
  final ActionCategoryList quickCategories;

  final int? sortOrder;
  final String? category;
  final List<RollButton?> rollButtons;
  final RacePosition racePosition;

  CharacterSettings copyWith({
    int? sortOrder,
    String? category,
    List<RollButton?>? rollButtons,
    NoteCategoryList? noteCategories,
    ActionCategoryList? actionCategories,
    ActionCategoryList? quickCategories,
    RacePosition? racePosition,
  }) =>
      CharacterSettings(
        sortOrder: sortOrder ?? this.sortOrder,
        category: category ?? this.category,
        rollButtons: rollButtons ?? this.rollButtons,
        actionCategories: actionCategories ?? this.actionCategories,
        noteCategories: noteCategories ?? this.noteCategories,
        racePosition: racePosition ?? this.racePosition,
        quickCategories: quickCategories ?? this.quickCategories,
      );

  factory CharacterSettings.fromRawJson(String str) => CharacterSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterSettings.fromJson(Map<String, dynamic> json) => CharacterSettings(
        noteCategories: json['noteCategories'] != null
            ? NoteCategoryList.fromJson(json['noteCategories'])
            : const NoteCategoryList(sortOrder: {}),
        actionCategories: json['actionCategories'] != null
            ? ActionCategoryList.fromJson(json['actionCategories'])
            : const ActionCategoryList(
                sortOrder: {},
                hidden: {},
              ),
        quickCategories: json['actionCategories'] != null
            ? ActionCategoryList.fromJson(json['actionCategories'])
            : const ActionCategoryList(
                sortOrder: {},
                hidden: {},
              ),
        sortOrder: json['sortOrder'],
        category: json['category'],
        rollButtons: List<RollButton?>.from(
            (json['rollButtons'] ?? []).map((x) => x != null ? RollButton.fromJson(x) : null)),
        racePosition: RacePosition.values.firstWhere(
          (element) => element.name == json['racePosition'],
          orElse: () => RacePosition.start,
        ),
      );

  factory CharacterSettings.empty() => const CharacterSettings(
        rollButtons: [],
        noteCategories: NoteCategoryList(sortOrder: {}),
        actionCategories: ActionCategoryList(
          sortOrder: {},
          hidden: {},
        ),
        quickCategories: ActionCategoryList(
          sortOrder: {},
          hidden: {},
        ),
      );

  Map<String, dynamic> toJson() => {
        'sortOrder': sortOrder,
        'category': category,
        'rollButtons': List<dynamic>.from(rollButtons.map((x) => x?.toJson())),
        'noteCategories': noteCategories.toJson(),
        'actionCategories': actionCategories.toJson(),
        'quickCategories': quickCategories.toJson(),
        'racePosition': racePosition.name,
      };
}

@immutable
class OrderedCategoryList {
  const OrderedCategoryList({
    // required this.categories,
    required this.sortOrder,
    required this.hidden,
    required this.canHide,
  });

  // final Set<String> categories;
  final Set<String> hidden;
  final Set<String> sortOrder;
  final bool canHide;

  Map<String, dynamic> toJson() => {
        // 'categories': List<dynamic>.from(categories),
        'hidden': List<dynamic>.from(hidden),
        'sortOrder': List<dynamic>.from(sortOrder),
        'canHide': canHide,
      };

  factory OrderedCategoryList.fromRawJson(String str) =>
      OrderedCategoryList.fromJson(json.decode(str));

  factory OrderedCategoryList.fromJson(Map<String, dynamic> json) => OrderedCategoryList(
        hidden: Set<String>.from(json['hidden']),
        sortOrder: Set<String>.from(json['sortOrder']),
        canHide: json['canHide'],
      );

  OrderedCategoryList copyWith({
    // Set<String>? categories,
    Set<String>? hidden,
    Set<String>? sortOrder,
    bool? canHide,
  }) =>
      OrderedCategoryList(
        hidden: hidden ?? this.hidden,
        sortOrder: sortOrder ?? this.sortOrder,
        canHide: canHide ?? this.canHide,
      );

  Set<String> getSorted([Set<String> all = const {}]) => <String>{
        ...sortOrder,
        ...(all.toList()..sort(stringSorter(order: SortOrder.asc))),
      }
          .where(
            (cat) => !hidden.contains(cat),
          )
          .toSet();
}

@immutable
class NoteCategoryList extends OrderedCategoryList {
  const NoteCategoryList({
    // required super.categories,
    required super.sortOrder,
  }) : super(canHide: false, hidden: const {});

  factory NoteCategoryList.fromRawJson(String str) => NoteCategoryList.fromJson(json.decode(str));

  factory NoteCategoryList.fromJson(Map<String, dynamic> json) => NoteCategoryList(
        sortOrder: Set<String>.from(json['sortOrder']),
      );

  NoteCategoryList copyWithInherited({
    // Set<String>? categories,
    Set<String>? sortOrder,
  }) =>
      NoteCategoryList(
        sortOrder: sortOrder ?? this.sortOrder,
      );
}

@immutable
class ActionCategoryList extends OrderedCategoryList {
  const ActionCategoryList({
    // required super.categories,
    required super.sortOrder,
    required super.hidden,
  }) : super(canHide: true);

  factory ActionCategoryList.fromRawJson(String str) =>
      ActionCategoryList.fromJson(json.decode(str));

  factory ActionCategoryList.fromJson(Map<String, dynamic> json) => ActionCategoryList(
        sortOrder: Set<String>.from(json['sortOrder']),
        hidden: Set<String>.from(json['hidden']),
      );

  ActionCategoryList copyWithInherited({
    // Set<String>? categories,
    Set<String>? sortOrder,
    Set<String>? hidden,
  }) =>
      ActionCategoryList(
        sortOrder: sortOrder ?? this.sortOrder,
        hidden: hidden ?? this.hidden,
      );
}
