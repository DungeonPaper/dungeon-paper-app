import 'dart:convert';

import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/roll_button.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:flutter/material.dart';

enum RacePosition { start, end }

@immutable
class CharacterSettings {
  const CharacterSettings({
    this.noteCategories = const NoteCategoryList(sortOrder: {}),
    this.actionCategories = const ActionCategoryList(sortOrder: {}, hidden: {}),
    this.quickCategories = const ActionCategoryList(sortOrder: {}, hidden: {}),
    this.sortOrder,
    this.category,
    required this.rollButtons,
    this.racePosition = RacePosition.start,
    this.lightTheme,
    this.darkTheme,
  });

  final NoteCategoryList noteCategories;
  final ActionCategoryList actionCategories;
  final ActionCategoryList quickCategories;

  final int? sortOrder;
  final String? category;
  final List<RollButton?> rollButtons;
  final RacePosition racePosition;
  final int? lightTheme;
  final int? darkTheme;

  CharacterSettings copyWith({
    int? sortOrder,
    String? category,
    List<RollButton?>? rollButtons,
    NoteCategoryList? noteCategories,
    ActionCategoryList? actionCategories,
    ActionCategoryList? quickCategories,
    RacePosition? racePosition,
    int? lightTheme,
    int? darkTheme,
  }) =>
      CharacterSettings(
        sortOrder: sortOrder ?? this.sortOrder,
        category: category ?? this.category,
        rollButtons: rollButtons ?? this.rollButtons,
        actionCategories: actionCategories ?? this.actionCategories,
        noteCategories: noteCategories ?? this.noteCategories,
        racePosition: racePosition ?? this.racePosition,
        quickCategories: quickCategories ?? this.quickCategories,
        lightTheme: lightTheme ?? this.lightTheme,
        darkTheme: darkTheme ?? this.darkTheme,
      );

  factory CharacterSettings.fromRawJson(String str) =>
      CharacterSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterSettings.fromJson(Map<String, dynamic> json) =>
      CharacterSettings(
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
        rollButtons: List<RollButton?>.from((json['rollButtons'] ?? [])
            .map((x) => x != null ? RollButton.fromJson(x) : null)),
        racePosition: RacePosition.values.firstWhere(
          (element) => element.name == json['racePosition'],
          orElse: () => RacePosition.start,
        ),
        lightTheme: json['lightTheme'],
        darkTheme: json['darkTheme'],
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
        'lightTheme': lightTheme,
        'darkTheme': darkTheme,
      };

  CharacterSettings copyWithThemes({int? lightTheme, int? darkTheme}) =>
      CharacterSettings(
        lightTheme: lightTheme,
        darkTheme: darkTheme,
        sortOrder: sortOrder,
        category: category,
        rollButtons: rollButtons,
        actionCategories: actionCategories,
        noteCategories: noteCategories,
        racePosition: racePosition,
        quickCategories: quickCategories,
      );

  String get debugProperties =>
      'sortOrder: $sortOrder, category: $category, rollButtons: $rollButtons, noteCategories: $noteCategories, actionCategories: $actionCategories, quickCategories: $quickCategories, racePosition: $racePosition, lightTheme: $lightTheme, darkTheme: $darkTheme';

  @override
  String toString() => 'CharacterSettings($debugProperties)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterSettings &&
          runtimeType == other.runtimeType &&
          sortOrder == other.sortOrder &&
          category == other.category &&
          rollButtons == other.rollButtons &&
          noteCategories == other.noteCategories &&
          actionCategories == other.actionCategories &&
          quickCategories == other.quickCategories &&
          racePosition == other.racePosition &&
          lightTheme == other.lightTheme &&
          darkTheme == other.darkTheme;

  @override
  int get hashCode => Object.hashAll([
        sortOrder,
        category,
        rollButtons,
        noteCategories,
        actionCategories,
        quickCategories,
        racePosition,
        lightTheme,
        darkTheme,
      ]);
}

@immutable
class OrderedCategoryList<T> {
  const OrderedCategoryList({
    // required this.categories,
    required this.sortOrder,
    required this.hidden,
    required this.canHide,
  });

  // final Set<String> categories;
  final Set<T> hidden;
  final Set<T> sortOrder;
  final bool canHide;

  Map<String, dynamic> toJson() => {
        // 'categories': List<dynamic>.from(categories),
        'hidden': List<dynamic>.from(hidden),
        'sortOrder': List<dynamic>.from(sortOrder),
        'canHide': canHide,
      };

  factory OrderedCategoryList.fromRawJson(String str) =>
      OrderedCategoryList.fromJson(json.decode(str));

  factory OrderedCategoryList.fromJson(Map<String, dynamic> json) =>
      OrderedCategoryList(
        hidden: Set<T>.from(json['hidden']),
        sortOrder: Set<T>.from(json['sortOrder']),
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

  Set<T> getSorted([Set<T> all = const {}]) => <T>{
        ...sortOrder,
        ...all,
        // .toList()..sort(stringSorter(order: SortOrder.asc))
      }
          .where(
            (cat) => !hidden.contains(cat),
          )
          .toSet()
          .cast<T>();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderedCategoryList &&
          runtimeType == other.runtimeType &&
          hidden == other.hidden &&
          sortOrder == other.sortOrder &&
          canHide == other.canHide;

  @override
  int get hashCode => Object.hashAll([
        hidden,
        sortOrder,
        canHide,
      ]);

  String get debugProperties =>
      'hidden: $hidden, sortOrder: $sortOrder, canHide: $canHide';

  @override
  String toString() => 'OrderedCategoryList($debugProperties)';
}

@immutable
class NoteCategoryList extends OrderedCategoryList<String> {
  const NoteCategoryList({
    // required super.categories,
    required super.sortOrder,
  }) : super(canHide: false, hidden: const {});

  factory NoteCategoryList.fromRawJson(String str) =>
      NoteCategoryList.fromJson(json.decode(str));

  factory NoteCategoryList.fromJson(Map<String, dynamic> json) =>
      NoteCategoryList(
        sortOrder: Set<String>.from(json['sortOrder']),
      );

  NoteCategoryList copyWithInherited({
    // Set<String>? categories,
    Set<String>? sortOrder,
  }) =>
      NoteCategoryList(
        sortOrder: sortOrder ?? this.sortOrder,
      );

  @override
  String get debugProperties => 'sortOrder: $sortOrder';

  @override
  String toString() => 'NoteCategoryList($debugProperties)';
}

@immutable
class ActionCategoryList extends OrderedCategoryList<Type> {
  const ActionCategoryList({
    // required super.categories,
    required super.sortOrder,
    required super.hidden,
  }) : super(canHide: true);

  factory ActionCategoryList.fromRawJson(String str) =>
      ActionCategoryList.fromJson(json.decode(str));

  factory ActionCategoryList.fromJson(Map<String, dynamic> json) =>
      ActionCategoryList(
        sortOrder:
            Set<Type>.from((json['sortOrder'] ?? []).map((x) => _toType(x))),
        hidden: Set<Type>.from((json['hidden'] ?? []).map((x) => _toType(x))),
      );

  ActionCategoryList copyWithInherited({
    // Set<String>? categories,
    Set<Type>? sortOrder,
    Set<Type>? hidden,
  }) =>
      ActionCategoryList(
        sortOrder: sortOrder ?? this.sortOrder,
        hidden: hidden ?? this.hidden,
      );

  @override
  Map<String, dynamic> toJson() {
    return {
      ...super.toJson(),
      'sortOrder': sortOrder.map((x) => x.toString()).toList(),
      'hidden': hidden.map((x) => x.toString()).toList(),
    };
  }

  @override
  Set<Type> getSorted([Set<Type> all = const {}]) =>
      super.getSorted(all).map((el) => _toType(el.toString())).toSet();

  @override
  String get debugProperties => 'sortOrder: $sortOrder, hidden: $hidden';

  @override
  String toString() => 'ActionCategoryList($debugProperties)';

  static Type _toType(String el) {
    switch (el) {
      case 'Move':
        return Move;
      case 'Spell':
        return Spell;
      case 'Item':
        return Item;
    }
    throw TypeError();
  }
}
