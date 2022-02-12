import 'dart:convert';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class CharacterStats {
  CharacterStats({
    required this.level,
    required this.currentHp,
    required this.currentExp,
    required this.armor,
    this.maxHp,
    this.damageDice,
    this.load,
  });

  final int level;
  final int? maxHp;
  final int currentHp;
  final int currentExp;
  final int armor;
  final dw.Dice? damageDice;
  final int? load;

  CharacterStats copyWith({
    int? level,
    int? maxHp,
    int? currentHp,
    int? currentExp,
    int? armor,
    dw.Dice? damageDice,
    int? load,
  }) =>
      CharacterStats(
        level: level ?? this.level,
        maxHp: maxHp ?? this.maxHp,
        currentHp: currentHp ?? this.currentHp,
        currentExp: currentExp ?? this.currentExp,
        armor: armor ?? this.armor,
        damageDice: damageDice ?? this.damageDice,
        load: load ?? this.load,
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
        damageDice: json["damageDice"],
        load: json["load"],
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "maxHP": maxHp,
        "currentHP": currentHp,
        "currentEXP": currentExp,
        "armor": armor,
        "damageDice": damageDice?.toJson(),
        "load": load,
      };
}
