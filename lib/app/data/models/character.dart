// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

import 'package:dungeon_paper/app/data/models/roll_button.dart';
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/app/model_utils/model_icon.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

import 'bio.dart';
import 'session_marks.dart';
import 'character_class.dart';
import 'character_settings.dart';
import 'item.dart';
import 'character_stats.dart';
import 'meta.dart';
import 'move.dart';
import 'note.dart';
import 'race.dart';
import 'ability_scores.dart';
import 'spell.dart';

class Character implements WithMeta<Character, CharacterMeta>, WithIcon {
  Character({
    required this.meta,
    required this.key,
    required this.displayName,
    required this.avatarUrl,
    required this.characterClass,
    required this.moves,
    required this.spells,
    required this.items,
    this.coins = 0,
    required this.notes,
    required this.stats,
    required this.abilityScores,
    required this.sessionMarks,
    required this.bio,
    required this.race,
    required this.settings,
  });

  @override
  final Meta<CharacterMeta> meta;
  @override
  final String key;
  final String displayName;
  final String avatarUrl;
  final CharacterClass characterClass;
  final List<Move> moves;
  final List<Spell> spells;
  final List<Item> items;
  final double coins;
  final List<Note> notes;
  final CharacterStats stats;
  final AbilityScores abilityScores;
  final List<SessionMark> sessionMarks;
  final Bio bio;
  final Race race;
  final CharacterSettings settings;

  int get currentHp => clamp(stats.currentHp, 0, maxHp);
  int get maxHp => stats.maxHp ?? defaultMaxHp;
  int get defaultMaxHp => (characterClass.hp + abilityScores.hpBaseValue);
  int get currentExp => stats.currentExp;
  int get pendingExp => sessionMarks.where((m) => m.completed).length;

  int get maxExp => stats.maxExp;
  double get currentHpPercent => clamp(stats.currentHp / maxHp, 0, 1);
  double get currentExpPercent => clamp(stats.currentExp / maxExp, 0, 1);
  int get maxLoad => stats.load ?? (characterClass.load + abilityScores.loadBaseValue);
  int get currentLoad => items.fold(0, (weight, item) => weight + item.weight);
  int get armor => stats.armor ?? items.fold(0, (armor, item) => armor + item.armor);
  int get damageModifier => items.fold(0, (mod, item) => mod + item.damage);

  int getLightTheme(User user) => settings.lightTheme ?? user.settings.defaultLightTheme;
  int getDarkTheme(User user) => settings.darkTheme ?? user.settings.defaultDarkTheme;

  int getCurrentTheme(User user) => getThemeForBrightness(
      user, user.settings.brightnessOverride ?? getCurrentPlatformBrightness());

  int getThemeForBrightness(User user, Brightness brightness) =>
      brightness == Brightness.light ? getLightTheme(user) : getDarkTheme(user);

  static RollButton get basicActionRollButton => RollButton(
        label: S.current.rollBasicActionButton,
        dice: [dw.Dice.d6 * 2],
        specialDice: [],
      );
  static RollButton get hackAndSlashRollButton => RollButton(
        label: S.current.rollAttackDamageButton,
        dice: [dw.Dice.fromJson('2d6+STR')],
        specialDice: [SpecialDice.damage],
      );

  static RollButton get volleyRollButton => RollButton(
        label: S.current.rollVolleyButton,
        dice: [dw.Dice.fromJson('2d6+DEX')],
        specialDice: [SpecialDice.damage],
      );

  static RollButton get discernRealitiesRollButton => RollButton(
        label: S.current.rollDiscernRealitiesButton,
        dice: [dw.Dice.fromJson('2d6+WIS')],
        specialDice: [],
      );

  static List<RollButton> get defaultRollButtons => [
        basicActionRollButton,
        hackAndSlashRollButton,
      ];

  List<RollButton?> get rawRollButtons => [
        settings.rollButtons.isNotEmpty ? settings.rollButtons[0] : null,
        settings.rollButtons.length > 1 ? settings.rollButtons[1] : null,
      ];

  List<RollButton> get rollButtons => [
        rawRollButtons[0] ?? basicActionRollButton,
        rawRollButtons[1] ?? hackAndSlashRollButton,
      ];

  Set<String> get noteCategories =>
      settings.noteCategories.getSorted(notes.map((note) => note.localizedCategory).toSet());

  Set<String> get actionCategories => settings.actionCategories.getSorted(allActionCategories);

  dw.Dice get damageDice =>
      stats.damageDice ?? characterClass.damageDice.copyWithModifierValue(damageModifier);

  List<SessionMark> get bonds =>
      sessionMarks.where((e) => e.type == dw.SessionMarkType.bond).toList();

  List<SessionMark> get flags =>
      sessionMarks.where((e) => e.type == dw.SessionMarkType.flag).toList();

  List<SessionMark> get endOfSessionMarks =>
      sessionMarks.where((e) => e.type == dw.SessionMarkType.endOfSession).toList();

  static const allActionCategories = {'Move', 'Spell', 'Item'};

  @override
  Character copyWith({
    Meta<CharacterMeta>? meta,
    String? key,
    String? displayName,
    CharacterSettings? settings,
    String? avatarUrl,
    CharacterClass? characterClass,
    List<Move>? moves,
    List<Spell>? spells,
    List<Item>? items,
    double? coins,
    List<Note>? notes,
    CharacterStats? stats,
    AbilityScores? abilityScores,
    List<SessionMark>? sessionMarks,
    Bio? bio,
    Race? race,
  }) =>
      copyWithInherited(
        meta: this.meta,
        key: this.key,
        displayName: this.displayName,
        settings: this.settings,
        avatarUrl: this.avatarUrl,
        characterClass: this.characterClass,
        moves: this.moves,
        spells: this.spells,
        items: this.items,
        coins: this.coins,
        notes: this.notes,
        stats: this.stats,
        abilityScores: this.abilityScores,
        sessionMarks: this.sessionMarks,
        bio: this.bio,
        race: this.race,
      );

  @override
  Character copyWithInherited({
    Meta<CharacterMeta>? meta,
    String? key,
    String? displayName,
    CharacterSettings? settings,
    String? avatarUrl,
    CharacterClass? characterClass,
    List<Move>? moves,
    List<Spell>? spells,
    List<Item>? items,
    double? coins,
    List<Note>? notes,
    CharacterStats? stats,
    AbilityScores? abilityScores,
    List<SessionMark>? sessionMarks,
    Bio? bio,
    Race? race,
  }) =>
      Character(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        displayName: displayName ?? this.displayName,
        settings: settings ?? this.settings,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        characterClass: characterClass ?? this.characterClass,
        moves: moves ?? this.moves,
        spells: spells ?? this.spells,
        items: items ?? this.items,
        coins: coins ?? this.coins,
        notes: notes ?? this.notes,
        stats: stats ?? this.stats,
        abilityScores: abilityScores ?? this.abilityScores,
        sessionMarks: sessionMarks ?? this.sessionMarks,
        bio: bio ?? this.bio,
        race: race ?? this.race,
      );

  factory Character.fromRawJson(String str) => Character.fromJson(json.decode(str));

  factory Character.empty() {
    final rand = Random();
    final characterClass = CharacterClass.empty();
    final abilityScores = AbilityScores.dungeonWorld(
      cha: rand.nextInt(20),
      con: rand.nextInt(20),
      dex: rand.nextInt(20),
      intl: rand.nextInt(20),
      str: rand.nextInt(20),
      wis: rand.nextInt(20),
    );

    return Character(
      key: uuid(),
      meta: Meta.empty(),
      displayName: '',
      settings: CharacterSettings.empty(),
      avatarUrl: '',
      items: [],
      coins: 0,
      bio: Bio.empty(),
      sessionMarks: [],
      characterClass: characterClass,
      notes: [],
      stats: CharacterStats(
        level: 1,
        currentExp: 0,
        currentHp: characterClass.hp + abilityScores.hpBaseValue,
      ),
      moves: [],
      abilityScores: abilityScores,
      spells: [],
      race: Race(
        key: uuid(),
        name: 'Human',
        classKeys: [characterClass.key],
        description: '',
        explanation: '',
        meta: Meta.empty(),
        tags: [],
      ),
    );
  }

  factory Character.withClass({required CharacterClass characterClass, Race? race}) {
    return Character.empty().copyWith(
      characterClass: characterClass,
      race: race ??
          Race(
            key: uuid(),
            name: 'Human',
            classKeys: [characterClass.key],
            description: '',
            explanation: '',
            meta: Meta.empty(),
            tags: [],
          ),
    );
  }

  String toRawJson() => json.encode(toJson());

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        meta: Meta.tryParse(json['_meta'], parseData: (data) => CharacterMeta.fromJson(data)),
        key: json['key'],
        displayName: json['displayName'],
        avatarUrl: json['avatarURL'],
        settings: json['settings'] != null
            ? CharacterSettings.fromJson(json['settings'])
            : CharacterSettings.empty(),
        characterClass: CharacterClass.fromJson(json['class']),
        moves: List<Move>.from(json['moves'].map((x) => Move.fromJson(x))),
        spells: List<Spell>.from(json['spells'].map((x) => Spell.fromJson(x))),
        items: List<Item>.from(json['items'].map((x) => Item.fromJson(x))),
        coins: (json['coins'] ?? 0).toDouble(),
        notes: List<Note>.from(json['notes'].map((x) => Note.fromJson(x))),
        stats: CharacterStats.fromJson(json['stats']),
        abilityScores: AbilityScores.fromJson(json['abilityScores']),
        sessionMarks:
            List<SessionMark>.from(json['sessionMarks'].map((x) => SessionMark.fromJson(x))),
        bio: Bio.fromJson(json['bio']),
        race: Race.fromJson(json['race']),
      );

  Map<String, dynamic> toJson() => {
        '_meta': meta.toJson((data) => data?.toJson()),
        'key': key,
        'displayName': displayName,
        'avatarURL': avatarUrl,
        'settings': settings.toJson(),
        'class': characterClass.toJson(),
        'moves': List<dynamic>.from(moves.map((x) => x.toJson())),
        'spells': List<dynamic>.from(spells.map((x) => x.toJson())),
        'items': List<dynamic>.from(items.map((x) => x.toJson())),
        'coins': coins,
        'notes': List<dynamic>.from(notes.map((x) => x.toJson())),
        'stats': stats.toJson(),
        'abilityScores': abilityScores.toJson(),
        'sessionMarks': List<dynamic>.from(sessionMarks.map((x) => x.toJson())),
        'bio': bio.toJson(),
        'race': race.toJson(),
      };

  @override
  IconData get icon => genericIcon;
  static IconData get genericIcon => Icons.person;
}

class CharacterMeta {
  final DateTime? lastUsed;

  CharacterMeta({this.lastUsed});

  factory CharacterMeta.fromJson(Map<String, dynamic> json) => CharacterMeta(
        lastUsed: json['lastUsed'] != null ? DateTime.parse(json['lastUsed']) : null,
      );

  CharacterMeta copyWith({
    DateTime? lastUsed,
  }) =>
      CharacterMeta(
        lastUsed: lastUsed ?? this.lastUsed,
      );

  Map<String, dynamic> toJson() => {
        'lastUsed': lastUsed?.toString(),
      };
}
