import 'dart:convert';

class CharacterStatsSettings {
  CharacterStatsSettings({
    this.overrideMaxHp,
  });

  final int? overrideMaxHp;

  CharacterStatsSettings copyWith({
    int? overrideMaxHp,
  }) =>
      CharacterStatsSettings(
        overrideMaxHp: overrideMaxHp ?? this.overrideMaxHp,
      );

  factory CharacterStatsSettings.fromRawJson(String str) =>
      CharacterStatsSettings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterStatsSettings.fromJson(Map<String, dynamic> json) =>
      CharacterStatsSettings(
        overrideMaxHp: json["overrideMaxHP"],
      );

  Map<String, dynamic> toJson() => {
        "overrideMaxHP": overrideMaxHp,
      };
}
