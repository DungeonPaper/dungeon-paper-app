import 'dart:convert';

import 'character_stats_settings.dart';
import 'dice.dart';

class CharacterStats {
  CharacterStats({
    required this.level,
    required this.maxHp,
    required this.currentHp,
    required this.currentExp,
    required this.armor,
    required this.hitDice,
    required this.settings,
  });

  final int level;
  final int maxHp;
  final int currentHp;
  final int currentExp;
  final int armor;
  final Dice hitDice;
  final CharacterStatsSettings settings;

  CharacterStats copyWith({
    int? level,
    int? maxHp,
    int? currentHp,
    int? currentExp,
    int? armor,
    Dice? hitDice,
    CharacterStatsSettings? settings,
  }) =>
      CharacterStats(
        level: level ?? this.level,
        maxHp: maxHp ?? this.maxHp,
        currentHp: currentHp ?? this.currentHp,
        currentExp: currentExp ?? this.currentExp,
        armor: armor ?? this.armor,
        hitDice: hitDice ?? this.hitDice,
        settings: settings ?? this.settings,
      );

  factory CharacterStats.fromRawJson(String str) =>
      CharacterStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterStats.fromJson(Map<String, dynamic> json) => CharacterStats(
        level: json["level"],
        maxHp: json["maxHP"],
        currentHp: json["currentHP"],
        currentExp: json["currentEXP"],
        armor: json["armor"],
        hitDice: json["hitDice"],
        settings: CharacterStatsSettings.fromJson(json["settings"]),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "maxHP": maxHp,
        "currentHP": currentHp,
        "currentEXP": currentExp,
        "armor": armor,
        "hitDice": hitDice.toJson(),
        "settings": settings.toJson(),
      };
}
