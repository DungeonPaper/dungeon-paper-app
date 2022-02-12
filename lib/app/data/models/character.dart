// To parse this JSON data, do
//
//     final character = characterFromJson(jsonString);

import 'dart:convert';

import '../../data/models/character_class.dart';
import '../../data/models/roll_stats.dart';
import '../../utils/uuid.dart';
import 'bio.dart';
import 'bond.dart';
import 'item.dart';
import 'character_stats.dart';
import 'meta.dart';
import 'move.dart';
import 'note.dart';
import 'race.dart';

class Character {
  Character({
    required this.meta,
    required this.key,
    required this.displayName,
    required this.avatarUrl,
    required this.characterClass,
    required this.moves,
    required this.spells,
    required this.items,
    required this.notes,
    required this.stats,
    required this.rollStats,
    required this.bonds,
    required this.bio,
    required this.race,
  });

  final SharedMeta meta;
  final String key;
  final String displayName;
  final String avatarUrl;
  final CharacterClass characterClass;
  final List<Move> moves;
  final List<Move> spells;
  final List<Item> items;
  final List<Note> notes;
  final CharacterStats stats;
  final RollStats rollStats;
  final List<Bond> bonds;
  final Bio bio;
  final Race race;

  Character copyWith({
    SharedMeta? meta,
    String? key,
    String? displayName,
    String? avatarUrl,
    CharacterClass? characterClass,
    List<Move>? moves,
    List<Move>? spells,
    List<Item>? items,
    List<Note>? notes,
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
        avatarUrl: avatarUrl ?? this.avatarUrl,
        characterClass: characterClass ?? this.characterClass,
        moves: moves ?? this.moves,
        spells: spells ?? this.spells,
        items: items ?? this.items,
        notes: notes ?? this.notes,
        stats: stats ?? this.stats,
        rollStats: rollStats ?? this.rollStats,
        bonds: bonds ?? this.bonds,
        bio: bio ?? this.bio,
        race: race ?? this.race,
      );

  factory Character.fromRawJson(String str) =>
      Character.fromJson(json.decode(str));

  factory Character.empty() {
    var characterClass = CharacterClass.empty();
    return Character(
      key: uuid(),
      meta: SharedMeta.version(1),
      displayName: "",
      avatarUrl: "",
      items: [],
      bio: Bio(description: "", looks: []),
      bonds: [],
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
      rollStats: RollStats(
        cha: 10,
        con: 10,
        dex: 10,
        intl: 10,
        str: 10,
        wis: 10,
      ),
      spells: [],
      race: Race(
        key: uuid(),
        name: "Human",
        classKeys: [characterClass.key],
        description: "",
        explanation: "",
        meta: SharedMeta.version(1),
        tags: [],
      ),
    );
  }

  factory Character.withClass({required CharacterClass characterClass}) {
    return Character.empty().copyWith(
      characterClass: characterClass,
      race: Race(
        key: uuid(),
        name: "Human",
        classKeys: [characterClass.key],
        description: "",
        explanation: "",
        meta: SharedMeta.version(1),
        tags: [],
      ),
    );
  }

  String toRawJson() => json.encode(toJson());

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        meta: SharedMeta.fromJson(json["_meta"]),
        key: json["key"],
        displayName: json["displayName"],
        avatarUrl: json["avatarURL"],
        characterClass: CharacterClass.fromJson(json["class"]),
        moves: List<Move>.from(json["moves"].map((x) => Move.fromJson(x))),
        spells: List<Move>.from(json["spells"].map((x) => Move.fromJson(x))),
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        notes: List<Note>.from(json["notes"].map((x) => Note.fromJson(x))),
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
        "avatarURL": avatarUrl,
        "class": characterClass.toJson(),
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "spells": List<dynamic>.from(spells.map((x) => x.toJson())),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "notes": List<dynamic>.from(notes.map((x) => x.toJson())),
        "stats": stats.toJson(),
        "rollStats": rollStats.toJson(),
        "bonds": List<dynamic>.from(bonds.map((x) => x.toJson())),
        "bio": bio.toJson(),
        "race": race.toJson(),
      };

  int get maxHp => stats.maxHp ?? (characterClass.hp + rollStats.con);
  int get load => stats.load ?? (characterClass.load + rollStats.strMod);
}
