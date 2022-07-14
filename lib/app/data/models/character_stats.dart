import 'dart:convert';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:dungeon_world_data/dungeon_world_data.dart';
import 'package:flutter/material.dart';

class CharacterStats {
  CharacterStats({
    required this.level,
    required this.currentHp,
    required this.currentExp,
    this.armor,
    this.maxHp,
    this.damageDice,
    this.load,
  });

  final int level;
  final int? maxHp;
  final int currentHp;
  final int currentExp;
  final int? armor;
  final dw.Dice? damageDice;
  final int? load;

  int get maxExp => maxExpForLevel(level);
  static int maxExpForLevel(int level) => level + 7;

  int get totalMaxExp => totalMaxExpForLevel(level);
  static int totalMaxExpForLevel(int level) =>
      range(1, level).fold<int>(8, (acc, l) => acc + maxExpForLevel(l + 1));

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

  CharacterStats copyWithMaxHp(int? maxHp) => CharacterStats(
        level: level,
        maxHp: maxHp,
        currentHp: currentHp,
        currentExp: currentExp,
        armor: armor,
        damageDice: damageDice,
        load: load,
      );

  factory CharacterStats.fromRawJson(String str) => CharacterStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CharacterStats.fromJson(Map<String, dynamic> json) => CharacterStats(
        level: json['level'],
        maxHp: json['maxHP'],
        currentHp: json['currentHP'],
        currentExp: json['currentEXP'],
        armor: json['armor'],
        damageDice: json['damageDice'] != null ? Dice.fromJson(json['damageDice']) : null,
        load: json['load'],
      );

  Map<String, dynamic> toJson() => {
        'level': level,
        'maxHP': maxHp,
        'currentHP': currentHp,
        'currentEXP': currentExp,
        'armor': armor,
        'damageDice': damageDice?.toJson(),
        'load': load,
      };

  CharacterStats copyWithArmor(int? armor) => CharacterStats(
        level: level,
        maxHp: maxHp,
        currentHp: currentHp,
        currentExp: currentExp,
        armor: armor,
        damageDice: damageDice,
        load: load,
      );

  CharacterStats copyWithLoad(int? load) => CharacterStats(
        level: level,
        maxHp: maxHp,
        currentHp: currentHp,
        currentExp: currentExp,
        armor: armor,
        damageDice: damageDice,
        load: load,
      );

  copyWithDamageDice(dw.Dice? damageDice) => CharacterStats(
        level: level,
        maxHp: maxHp,
        currentHp: currentHp,
        currentExp: currentExp,
        armor: armor,
        damageDice: damageDice,
        load: load,
      );
}
