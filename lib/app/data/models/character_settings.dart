import 'dart:convert';

class CharacterSettings {
  CharacterSettings({
    required this.noteCategoriesSort,
    required this.actionCategoriesSort,
    required this.quickCategoriesSort,
    required this.actionCategoriesHide,
    this.sortOrder,
    this.category,
  });

  final Set<String> noteCategoriesSort;
  final Set<String> actionCategoriesSort;
  final Set<String> quickCategoriesSort;
  final Set<String> actionCategoriesHide;
  final int? sortOrder;
  final String? category;

  CharacterSettings copyWith({
    Set<String>? noteCategoriesSort,
    Set<String>? actionCategoriesSort,
    Set<String>? actionCategoriesHide,
    Set<String>? quickCategoriesSort,
    int? sortOrder,
    String? category,
  }) =>
      CharacterSettings(
        noteCategoriesSort: noteCategoriesSort ?? this.noteCategoriesSort,
        actionCategoriesSort: actionCategoriesSort ?? this.actionCategoriesSort,
        actionCategoriesHide: actionCategoriesHide ?? this.actionCategoriesHide,
        quickCategoriesSort: quickCategoriesSort ?? this.quickCategoriesSort,
        sortOrder: sortOrder ?? this.sortOrder,
        category: category ?? this.category,
      );

  factory CharacterSettings.fromRawJson(String str) => CharacterSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterSettings.fromJson(Map<String, dynamic> json) => CharacterSettings(
        noteCategoriesSort: Set<String>.from(json['noteCategoriesSort'] ?? []),
        actionCategoriesSort: Set<String>.from(json['actionCategoriesSort'] ?? []),
        actionCategoriesHide: Set<String>.from(json['actionCategoriesHide'] ?? []),
        quickCategoriesSort: Set<String>.from(json['quickCategoriesSort'] ?? []),
        sortOrder: json['sortOrder'],
        category: json['category'],
      );

  factory CharacterSettings.empty() => CharacterSettings(
        noteCategoriesSort: {},
        actionCategoriesSort: {},
        actionCategoriesHide: {},
        quickCategoriesSort: {},
      );

  Map<String, dynamic> toJson() => {
        'noteCategoriesSort': List<dynamic>.from(noteCategoriesSort),
        'actionCategoriesSort': List<dynamic>.from(actionCategoriesSort),
        'actionCategoriesHide': List<dynamic>.from(actionCategoriesHide),
        'quickCategoriesSort': List<dynamic>.from(quickCategoriesSort),
        'sortOrder': sortOrder,
        'category': category,
      };
}
