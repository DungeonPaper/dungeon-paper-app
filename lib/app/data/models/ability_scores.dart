import 'dart:convert';

import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/core/utils/icon_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import '../../../core/dw_icons.dart';

class AbilityScores {
  AbilityScores({
    required Iterable<AbilityScore> stats,
  }) : stats = stats.toList();

  factory AbilityScores.dungeonWorldAll(int value) => AbilityScores.dungeonWorld(
        dex: value,
        str: value,
        wis: value,
        con: value,
        intl: value,
        cha: value,
      );

  factory AbilityScores.dungeonWorld({
    required int dex,
    required int str,
    required int wis,
    required int con,
    required int intl,
    required int cha,
  }) =>
      AbilityScores(stats: [
        AbilityScore(
          key: 'STR',
          name: S.current.abilityScoreStrName,
          description: S.current.abilityScoreStrDescription,
          debilityName: S.current.abilityScoreStrDebilityName,
          debilityDescription: S.current.abilityScoreStrDebilityDescription,
          value: str,
        ),
        AbilityScore(
          key: 'DEX',
          name: S.current.abilityScoreDexName,
          description: S.current.abilityScoreDexDescription,
          debilityName: S.current.abilityScoreDexDebilityName,
          debilityDescription: S.current.abilityScoreDexDebilityDescription,
          value: dex,
        ),
        AbilityScore(
          key: 'CON',
          name: S.current.abilityScoreConName,
          description: S.current.abilityScoreConDescription,
          debilityName: S.current.abilityScoreConDebilityName,
          debilityDescription: S.current.abilityScoreConDebilityDescription,
          value: con,
        ),
        AbilityScore(
          key: 'INT',
          name: S.current.abilityScoreIntName,
          description: S.current.abilityScoreIntDescription,
          debilityName: S.current.abilityScoreIntDebilityName,
          debilityDescription: S.current.abilityScoreIntDebilityDescription,
          value: intl,
        ),
        AbilityScore(
          key: 'WIS',
          name: S.current.abilityScoreWisName,
          description: S.current.abilityScoreWisDescription,
          debilityName: S.current.abilityScoreWisDebilityName,
          debilityDescription: S.current.abilityScoreWisDebilityDescription,
          value: wis,
        ),
        AbilityScore(
          key: 'CHA',
          name: S.current.abilityScoreChaName,
          description: S.current.abilityScoreChaDescription,
          debilityName: S.current.abilityScoreChaDebilityName,
          debilityDescription: S.current.abilityScoreChaDebilityDescription,
          value: cha,
        ),
      ]);

  final List<AbilityScore> stats;

  Map<String, AbilityScore> get statsMap => Map.fromIterable(stats, key: (s) => s.key);

  AbilityScores copyWith({
    Iterable<AbilityScore>? stats,
  }) =>
      AbilityScores(stats: stats ?? this.stats);

  AbilityScores copyWithStatValues(Map<String, int> map) => copyWith(
        stats: stats.map(
          (stat) => map.containsKey(stat.key) ? stat.copyWith(value: map[stat.key]) : stat,
        ),
      );

  AbilityScores copyWithDebilities(Iterable<String> keys, {required bool isDebilitated}) => copyWith(
        stats: stats.map((e) => keys.contains(e.key) ? e.copyWith(isDebilitated: isDebilitated) : e),
      );

  factory AbilityScores.fromRawJson(String str) => AbilityScores.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  AbilityScore getStat(String statKey) {
    statKey = statKey.trim().toUpperCase();
    if (statKey == 'BOND') {
      return AbilityScore(
        key: 'BOND',
        name: S.current.abilityScoreBondName,
        value: 10,
        isDebilitated: false,
        description: S.current.abilityScoreBondDescription,
        debilityName: S.current.abilityScoreBondDebilityName,
        debilityDescription: S.current.abilityScoreBondDebilityDescription,
      );
    }
    if (!statsMap.containsKey(statKey)) {
      throw Exception('Stat $statKey not found, available: ${statsMap.keys}');
    }
    return statsMap[statKey]!;
  }

  AbilityScore? get dex => getStat('DEX');
  AbilityScore? get str => getStat('STR');
  AbilityScore? get wis => getStat('WIS');
  AbilityScore? get con => getStat('CON');
  AbilityScore? get intl => getStat('INT');
  AbilityScore? get cha => getStat('CHA');

  int? get dexMod => dex?.modifier;
  int? get strMod => str?.modifier;
  int? get wisMod => wis?.modifier;
  int? get conMod => con?.modifier;
  int? get intMod => intl?.modifier;
  int? get chaMod => cha?.modifier;

  int? get dexValue => dex?.value;
  int? get strValue => str?.value;
  int? get wisValue => wis?.value;
  int? get conValue => con?.value;
  int? get intValue => intl?.value;
  int? get chaValue => cha?.value;

  int get hpBaseValue => con?.value ?? 0;
  int get loadBaseValue => str?.modifier ?? 0;

  factory AbilityScores.fromJson(Map<String, dynamic> json) => AbilityScores(
        stats: List<AbilityScore>.from(json['stats'].map((x) => AbilityScore.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'stats': stats.map((s) => s.toJson()).toList(),
      };

  @override
  bool operator ==(Object? other) =>
      identical(this, other) || other is AbilityScores && runtimeType == other.runtimeType && stats == other.stats;

  @override
  int get hashCode => Object.hashAll(stats);

  String get debugProperties => stats.map((s) => '${s.key}: ${s.value}').join(', ');

  @override
  String toString() => 'AbilityScores($debugProperties)';
}

class AbilityScore with WithIcon, WithKey {
  @override
  final String key;
  final String name;
  final String description;
  final int value;
  final bool isDebilitated;
  final String debilityName;
  final String debilityDescription;
  final IconData? customIcon;

  AbilityScore({
    required String key,
    required this.name,
    required this.value,
    required this.description,
    required this.debilityName,
    required this.debilityDescription,
    IconData? icon,
    this.isDebilitated = false,
  })  : key = key.trim().toUpperCase(),
        customIcon = icon;

  factory AbilityScore.fromJson(Map<String, dynamic> json) => AbilityScore(
        key: json['key'],
        name: json['name'],
        value: json['value'],
        description: json['description'],
        isDebilitated: json['isDebilitated'] ?? false,
        debilityName: json['debilityName'],
        debilityDescription: json['debilityDescription'],
        icon: IconUtils.iconDataFromName(json['icon']),
      );

  factory AbilityScore.empty() => AbilityScore(
        key: '',
        name: '',
        value: 0,
        description: '',
        isDebilitated: false,
        debilityName: '',
        debilityDescription: '',
        icon: null,
      );

  Map<String, dynamic> toJson() => {
        'key': key,
        'name': name,
        'value': value,
        'description': description,
        'isDebilitated': isDebilitated,
        'debilityName': debilityName,
        'debilityDescription': debilityDescription,
        'icon': IconUtils.iconDataToJson(customIcon),
      };

  AbilityScore copyWith({
    String? key,
    String? name,
    String? description,
    int? value,
    bool? isDebilitated,
    String? debilityName,
    String? debilityDescription,
    IconData? icon,
  }) =>
      AbilityScore(
        key: key ?? this.key,
        name: name ?? this.name,
        description: description ?? this.description,
        value: value ?? this.value,
        isDebilitated: isDebilitated ?? this.isDebilitated,
        debilityName: debilityName ?? this.debilityName,
        debilityDescription: debilityDescription ?? this.debilityDescription,
        icon: icon ?? customIcon,
      );

  int get modifier => isDebilitated ? modifierForValue(value) - 1 : modifierForValue(value);

  @override
  IconData get icon => customIcon ?? iconFor(key);

  static IconData iconFor(String key) => _icons[key.toLowerCase()] ?? _icons['_other']!;

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

  static const _icons = <String, IconData>{
    'dex': DwIcons.stat_dex,
    'str': DwIcons.stat_str,
    'wis': DwIcons.stat_wis,
    'con': DwIcons.stat_con,
    'int': DwIcons.stat_int,
    'cha': DwIcons.stat_cha,
    '_other': Icons.format_list_numbered_rtl,
  };

  @override
  bool operator ==(Object? other) =>
      identical(this, other) ||
      other is AbilityScore &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          name == other.name &&
          description == other.description &&
          value == other.value &&
          isDebilitated == other.isDebilitated &&
          debilityName == other.debilityName &&
          debilityDescription == other.debilityDescription;

  @override
  int get hashCode => Object.hashAll([key, name, description, value, isDebilitated, debilityName, debilityDescription]);

  String get debugProperties =>
      'key: $key, value: $value, name: $name, description: $description, isDebilitated: $isDebilitated, debilityName: $debilityName, debilityDescription: $debilityDescription';

  @override
  String toString() => 'AbilityScore($debugProperties)';
}
