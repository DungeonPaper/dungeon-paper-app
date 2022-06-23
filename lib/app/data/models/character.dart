// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';
import 'dart:math';

import 'package:dungeon_paper/app/model_utils/model_icon.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/core/utils/uuid.dart';
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
  int get pendingExp {
    final marks = sessionMarks.where((m) => m.completed).length;
    // TODO add end of session questions to calculation?
    return marks;
  }

  int get maxExp => stats.maxExp;
  double get currentHpPercent => clamp(stats.currentHp / maxHp, 0, 1);
  double get currentExpPercent => clamp(stats.currentExp / maxExp, 0, 1);
  int get maxLoad => stats.load ?? (characterClass.load + abilityScores.loadBaseValue);
  int get currentLoad => items.fold(0, (weight, item) => weight + item.weight);
  int get armor => stats.armor ?? items.fold(0, (armor, item) => armor + item.armor);

  Set<String> get noteCategories => Set.from(
        (<String>[
          ...settings.noteCategoriesSort,
          ...(notes.map((note) => note.localizedCategory).toList()
            ..sort(stringSorter(order: SortOrder.asc))),
        ]),
      );
  Set<String> get actionCategories => Set.from(
        <String>[...settings.actionCategoriesSort, ...allActionCategories].where(
          (cat) => !settings.actionCategoriesHide.contains(cat),
        ),
      );
  dw.Dice get damageDice => stats.damageDice ?? characterClass.damageDice;
  List<SessionMark> get bonds =>
      sessionMarks.where((e) => e.type == dw.SessionMarkType.bond).toList();
  List<SessionMark> get flags =>
      sessionMarks.where((e) => e.type == dw.SessionMarkType.flag).toList();

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
    var characterClass = CharacterClass.empty();
    return Character(
      key: uuid(),
      meta: Meta.version(1),
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
        armor: 0,
        currentExp: 0,
        currentHp: 20,
        // damageDice: characterClass.damageDice,
        maxHp: 20,
        // load: characterClass.load,
      ),
      moves: [],
      abilityScores: AbilityScores.dungeonWorld(
        cha: rand.nextInt(20),
        con: rand.nextInt(20),
        dex: rand.nextInt(20),
        intl: rand.nextInt(20),
        str: rand.nextInt(20),
        wis: rand.nextInt(20),
      ),
      spells: [],
      race: Race(
        key: uuid(),
        name: 'Human',
        classKeys: [characterClass.key],
        description: '',
        explanation: '',
        meta: Meta.version(1),
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
            meta: Meta.version(1),
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
        coins: ((json['coins'] ?? 0) as num).toDouble(),
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
