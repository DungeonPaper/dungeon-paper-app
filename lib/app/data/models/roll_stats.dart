import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../core/dw_icons.dart';
import '../../widgets/atoms/svg_icon.dart';

class RollStats {
  RollStats({
    required Iterable<RollStat> stats,
  }) : stats = stats.toList();

  factory RollStats.dungeonWorld({
    required int dex,
    required int str,
    required int wis,
    required int con,
    required int intl,
    required int cha,
  }) =>
      RollStats(stats: [
        RollStat(
          key: 'STR',
          name: 'Strength',
          description: 'Measures muscle and physical power',
          value: str,
        ),
        RollStat(
          key: 'DEX',
          name: 'Dexterity',
          description: 'Measures agility, reflexes and balance',
          value: dex,
        ),
        RollStat(
          key: 'CON',
          name: 'Constitution',
          description: "Represents your character's health and stamina",
          value: con,
        ),
        RollStat(
          key: 'INT',
          name: 'Intelligence',
          description: 'Determines how well your character learns and reasons',
          value: intl,
        ),
        RollStat(
          key: 'WIS',
          name: 'Wisdom',
          description: "Describes a character's willpower, common sense, awareness, and intuition",
          value: wis,
        ),
        RollStat(
          key: 'CHA',
          name: 'Charisma',
          description:
              "Measures a character's personality, personal magnetism, ability to lead, and appearance",
          value: cha,
        ),
      ]);

  final List<RollStat> stats;

  Map<String, RollStat> get statsMap => Map.fromIterable(stats, key: (s) => s.key);

  RollStats copyWith({
    Iterable<RollStat>? stats,
  }) =>
      RollStats(stats: stats ?? this.stats.toList());

  factory RollStats.fromRawJson(String str) => RollStats.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  RollStat getStat(String statKey) {
    statKey = statKey.trim().toUpperCase();
    if (!statsMap.containsKey(statKey)) {
      throw Exception('Stat $statKey not found, available: ${statsMap.keys}');
    }
    return statsMap[statKey]!;
  }

  RollStat get dex => getStat('dex');
  RollStat get str => getStat('str');
  RollStat get wis => getStat('wis');
  RollStat get con => getStat('con');
  RollStat get intl => getStat('int');
  RollStat get cha => getStat('cha');

  int get dexMod => dex.modifier;
  int get strMod => str.modifier;
  int get wisMod => wis.modifier;
  int get conMod => con.modifier;
  int get intMod => intl.modifier;
  int get chaMod => cha.modifier;

  factory RollStats.fromJson(Map<String, dynamic> json) => RollStats(
        stats: List<RollStat>.from(json['stats'].map((x) => RollStat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'stats': stats.map((s) => s.toJson()).toList(),
      };
}

class RollStat {
  final String key;
  final String name;
  final String description;
  final int value;

  RollStat({
    required String key,
    required this.name,
    required this.value,
    required this.description,
  }) : key = key.trim().toUpperCase();

  factory RollStat.fromJson(Map<String, dynamic> json) => RollStat(
      key: json['key'], name: json['name'], value: json['value'], description: json['description']);

  Map<String, dynamic> toJson() => {
        'key': key,
        'name': name,
        'value': value,
        'description': description,
      };

  int get modifier => modifierForValue(value);
  Widget get icon => _icons[key.toLowerCase()] ?? _icons['_other']!;

  static int modifierForValue(int value) {
    var modifiers = {1: -3, 4: -2, 6: -1, 9: 0, 13: 1, 16: 2, 18: 3};

    if (modifiers.containsKey(value)) {
      return modifiers[value]!;
    }

    for (var i = value; i > 0; --i) {
      if (modifiers.containsKey(i)) {
        return modifiers[i]!;
      }
    }

    return -1;
  }

  static final _icons = <String, Widget>{
    'dex': SvgIcon(DwIcons.stat_dex),
    'str': SvgIcon(DwIcons.stat_str),
    'wis': SvgIcon(DwIcons.stat_wis),
    'con': SvgIcon(DwIcons.stat_con),
    'int': SvgIcon(DwIcons.stat_int),
    'cha': SvgIcon(DwIcons.stat_cha),
    '_other': const Icon(Icons.help),
  };
}
