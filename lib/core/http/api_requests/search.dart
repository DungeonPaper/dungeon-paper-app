import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/monster.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/core/utils/map_utils.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

enum SearchType {
  classes,
  items,
  monsters,
  moves,
  races,
  spells,
  notes,
  tags,
}

final searchTypeToString = <SearchType, String>{
  SearchType.classes: 'CharacterClasses',
  SearchType.items: 'Items',
  SearchType.monsters: 'Monsters',
  SearchType.moves: 'Moves',
  SearchType.races: 'Races',
  SearchType.spells: 'Spells',
  SearchType.tags: 'Tags',
  SearchType.notes: 'Notes',
};

final stringTypeToSearchType = searchTypeToString.inverse;

class SearchRequest {
  final Set<SearchType> types;
  final String query;

  SearchRequest({required this.types, required this.query});

  @override
  String toString() => Uri(queryParameters: {
        'types': types.map((t) => searchTypeToString[t]).join(','),
        'q': query,
        '__no_token': '__no_token'
      }).query;
}

class SearchResponse {
  final List<CharacterClass>? classes;
  final List<Item>? items;
  final List<Monster>? monsters;
  final List<Move>? moves;
  final List<Race>? races;
  final List<Spell>? spells;
  final List<Note>? notes;
  final List<dw.Tag>? tags;

  SearchResponse({
    this.classes,
    this.items,
    this.monsters,
    this.moves,
    this.races,
    this.spells,
    this.notes,
    this.tags,
  });

  static List<T> values<T>(dynamic object) => object is List<T> ? object : (object as Map<String, T>).values.toList();

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    debugPrint('Parsing response: ${json.map((k, v) => MapEntry(k, v.length))}');
    return SearchResponse(
      classes: json['CharacterClasses'] != null
          ? List.from(values(json['CharacterClasses']).map((x) => CharacterClass.fromJson(x)))
          : null,
      items: json['Items'] != null ? List.from(values(json['Items']).map((x) => Item.fromJson(x))) : null,
      monsters: json['Monsters'] != null ? List.from(values(json['Monsters']).map((x) => Monster.fromJson(x))) : null,
      moves: json['Moves'] != null ? List.from(values(json['Moves']).map((x) => Move.fromJson(x))) : null,
      races: json['Races'] != null ? List.from(values(json['Races']).map((x) => Race.fromJson(x))) : null,
      spells: json['Spells'] != null ? List.from(values(json['Spells']).map((x) => Spell.fromJson(x))) : null,
      notes: json['Notes'] != null ? List.from(values(json['Notes']).map((x) => Note.fromJson(x))) : null,
      tags: json['Tags'] != null ? List.from(values(json['Tags']).map((x) => dw.Tag.fromJson(x))) : null,
    );
  }

  SearchResponse.empty()
      : classes = [],
        items = [],
        monsters = [],
        moves = [],
        spells = [],
        races = [],
        tags = [],
        notes = [];

  factory SearchResponse.fromPackageRepo() => SearchResponse(
        classes:
            dw.dungeonWorldData.characterClasses.values.map((e) => CharacterClass.fromDwCharacterClass(e)).toList(),
        items: dw.dungeonWorldData.items.values.map((e) => Item.fromDwItem(e)).toList(),
        monsters: dw.dungeonWorldData.monsters.values.map((e) => Monster.fromDwMonster(e)).toList(),
        moves: dw.dungeonWorldData.moves.values.map((e) => Move.fromDwMove(e)).toList(),
        spells: dw.dungeonWorldData.spells.values.map((e) => Spell.fromDwSpell(e)).toList(),
        races: dw.dungeonWorldData.races.values.map((e) => Race.fromDwRace(e)).toList(),
        tags: dw.dungeonWorldData.tags.values.toList(),
        // notes: [],
      );

  bool get isAnyEmpty => [
        classes,
        items,
        monsters,
        moves,
        races,
        spells,
        tags,
        // ignore notes
        // notes,
      ].any((l) => l == null || l.isEmpty);

  bool get isAllEmpty => [
        classes,
        items,
        monsters,
        moves,
        races,
        spells,
        tags,
        // ignore notes
        // notes,
      ].every((l) => l == null || l.isEmpty);
}
