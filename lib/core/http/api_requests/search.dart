import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/monster.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/core/utils/map_utils.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

enum SearchType {
  classes,
  items,
  monsters,
  moves,
  races,
  spells,
  tags,
}

final searchTypeToString = <SearchType, String>{
  SearchType.classes: 'Classes',
  SearchType.items: 'Items',
  SearchType.monsters: 'Monsters',
  SearchType.moves: 'Moves',
  SearchType.races: 'Races',
  SearchType.spells: 'Spells',
  SearchType.tags: 'Tags',
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
  final List<dw.Tag>? tags;

  SearchResponse({
    this.classes,
    this.items,
    this.monsters,
    this.moves,
    this.races,
    this.spells,
    this.tags,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        classes: json['Classes'] != null
            ? List.from(json['Classes'].map((x) => CharacterClass.fromJson(x)))
            : null,
        items: json['Items'] != null ? List.from(json['Items'].map((x) => Item.fromJson(x))) : null,
        monsters: json['Monsters'] != null
            ? List.from(json['Monsters'].map((x) => Monster.fromJson(x)))
            : null,
        moves: json['Moves'] != null ? List.from(json['Moves'].map((x) => Move.fromJson(x))) : null,
        races: json['Races'] != null ? List.from(json['Races'].map((x) => Race.fromJson(x))) : null,
        spells:
            json['Spells'] != null ? List.from(json['Spells'].map((x) => Spell.fromJson(x))) : null,
        tags: json['Tags'] != null ? List.from(json['Tags'].map((x) => dw.Tag.fromJson(x))) : null,
      );

  bool get isAnyEmpty => [
        classes,
        items,
        monsters,
        moves,
        races,
        spells,
        tags,
      ].any((l) => l == null || l.isEmpty);
}
