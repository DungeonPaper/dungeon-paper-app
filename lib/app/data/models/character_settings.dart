import 'dart:convert';

class CharacterSettings {
  CharacterSettings({
    required this.noteCategoriesSort,
    required this.actionCategoriesSort,
    required this.actionCategoriesHide,
  });

  final Set<String> noteCategoriesSort;
  final Set<String> actionCategoriesSort;
  final Set<String> actionCategoriesHide;

  CharacterSettings copyWith({
    Set<String>? noteCategoriesSort,
    Set<String>? actionCategoriesSort,
    Set<String>? actionCategoriesHide,
  }) =>
      CharacterSettings(
        noteCategoriesSort: noteCategoriesSort ?? this.noteCategoriesSort,
        actionCategoriesSort: actionCategoriesSort ?? this.actionCategoriesSort,
        actionCategoriesHide: actionCategoriesHide ?? this.actionCategoriesHide,
      );

  factory CharacterSettings.fromRawJson(String str) => CharacterSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterSettings.fromJson(Map<String, dynamic> json) => CharacterSettings(
        noteCategoriesSort: Set<String>.from(json['noteCategoriesSort'] ?? []),
        actionCategoriesSort: Set<String>.from(json['actionCategoriesSort'] ?? []),
        actionCategoriesHide: Set<String>.from(json['actionCategoriesHide'] ?? []),
      );

  factory CharacterSettings.empty() => CharacterSettings(
        noteCategoriesSort: {},
        actionCategoriesSort: {},
        actionCategoriesHide: {},
      );

  Map<String, dynamic> toJson() => {
        'noteCategoriesSort': List<dynamic>.from(noteCategoriesSort),
        'actionCategoriesSort': List<dynamic>.from(actionCategoriesSort),
        'actionCategoriesHide': List<dynamic>.from(actionCategoriesHide),
      };
}
