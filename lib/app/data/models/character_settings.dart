import 'dart:convert';

class CharacterSettings {
  CharacterSettings({
    required this.noteCategoriesSort,
  });

  final Set<String> noteCategoriesSort;

  CharacterSettings copyWith({
    Set<String>? noteCategoriesSort,
  }) =>
      CharacterSettings(
        noteCategoriesSort: noteCategoriesSort ?? this.noteCategoriesSort,
      );

  factory CharacterSettings.fromRawJson(String str) => CharacterSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterSettings.fromJson(Map<String, dynamic> json) => CharacterSettings(
        noteCategoriesSort: Set<String>.from(json['noteCategoriesSort'] ?? []),
      );

  Map<String, dynamic> toJson() => {
        'noteCategoriesSort': List<dynamic>.from(noteCategoriesSort),
      };
}
