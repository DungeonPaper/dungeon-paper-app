// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';

import 'package:dungeon_paper/data/models/character_stats_settings.dart';
import 'package:dungeon_paper/data/models/roll_stats.dart';

import '../../core/utils/uuid.dart';
import 'bio.dart';
import 'bond.dart';
import 'dice.dart';
import 'item.dart';
import 'character_stats.dart';
import 'meta.dart';
import 'move.dart';
import 'race.dart';

class Character {
  Character({
    required this.meta,
    required this.key,
    required this.displayName,
    required this.classKey,
    required this.moves,
    required this.spells,
    required this.items,
    required this.isShared,
    required this.stats,
    required this.rollStats,
    required this.bonds,
    required this.bio,
    required this.race,
  });

  final Meta meta;
  final String key;
  final String displayName;
  final String classKey;
  final List<Move> moves;
  final List<Move> spells;
  final List<Item> items;
  final bool isShared;
  final CharacterStats stats;
  final RollStats rollStats;
  final List<Bond> bonds;
  final Bio bio;
  final Race race;

  Character copyWith({
    Meta? meta,
    String? key,
    String? displayName,
    String? classKey,
    List<Move>? moves,
    List<Move>? spells,
    List<Item>? items,
    bool? isShared,
    CharacterStats? stats,
    RollStats? rollStats,
    List<Bond>? bonds,
    Bio? bio,
    Race? race,
  }) =>
      Character(
        meta: meta ?? this.meta,
        key: key ?? this.key,
        displayName: displayName ?? this.displayName,
        classKey: classKey ?? this.classKey,
        moves: moves ?? this.moves,
        spells: spells ?? this.spells,
        items: items ?? this.items,
        isShared: isShared ?? this.isShared,
        stats: stats ?? this.stats,
        rollStats: rollStats ?? this.rollStats,
        bonds: bonds ?? this.bonds,
        bio: bio ?? this.bio,
        race: race ?? this.race,
      );

  factory Character.fromRawJson(String str) =>
      Character.fromJson(json.decode(str));

  factory Character.withClass({required String classKey}) {
    return Character(
      key: uuid(),
      meta: Meta(schemaVersion: 1),
      displayName: "",
      items: [],
      bio: Bio(description: "", looks: []),
      bonds: [],
      classKey: classKey,
      isShared: false,
      stats: CharacterStats(
        level: 1,
        armor: 0,
        currentExp: 0,
        currentHp: 20,
        hitDice: Dice.fromJson("1d10"),
        maxHp: 20,
        settings: CharacterStatsSettings(),
      ),
      moves: [],
      rollStats: RollStats(
        cha: 10,
        con: 10,
        dex: 10,
        rollStatsInt: 10,
        str: 10,
        wis: 10,
      ),
      spells: [],
      race: Race(
        key: uuid(),
        name: "Human",
        classKeys: [classKey],
        description: "",
        explanation: "",
        meta: Meta(schemaVersion: 1),
        tags: [],
      ),
    );
  }

  String toRawJson() => json.encode(toJson());

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        meta: Meta.fromJson(json["_meta"]),
        key: json["key"],
        displayName: json["displayName"],
        classKey: json["classKey"],
        moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
        spells: List<Move>.from(json["spells"].map((x) => Move.fromJson(x))),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        isShared: json["isShared"],
        stats: CharacterStats.fromJson(json["stats"]),
        rollStats: RollStats.fromJson(json["rollStats"]),
        bonds: List<Bond>.from(json["bonds"].map((x) => Bond.fromJson(x))),
        bio: Bio.fromJson(json["bio"]),
        race: Race.fromJson(json["race"]),
      );

  Map<String, dynamic> toJson() => {
        "_meta": meta.toJson(),
        "key": key,
        "displayName": displayName,
        "classKey": classKey,
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "spells": List<dynamic>.from(spells.map((x) => x.toJson())),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "isShared": isShared,
        "stats": stats.toJson(),
        "rollStats": rollStats.toJson(),
        "bonds": List<dynamic>.from(bonds.map((x) => x.toJson())),
        "bio": bio.toJson(),
        "race": race.toJson(),
      };
}
