// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/monster.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';

import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

class RepositoryService extends GetxService {
  final classes = <String, CharacterClass>{}.obs;
  final items = <String, Item>{}.obs;
  final monsters = <String, Monster>{}.obs;
  final moves = <String, Move>{}.obs;
  final races = <String, Race>{}.obs;
  final spells = <String, Spell>{}.obs;
  final tags = <String, dw.Tag>{}.obs;

  void clear() {
    classes.clear();
  }

  @override
  void onInit() async {
    super.onInit();
    init();
  }

  RxMap<String, T> listByType<T>() {
    switch (T) {
      case CharacterClass:
        return classes as RxMap<String, T>;
      case Item:
        return items as RxMap<String, T>;
      case Monster:
        return monsters as RxMap<String, T>;
      case Move:
        return moves as RxMap<String, T>;
      case Race:
        return races as RxMap<String, T>;
      case Spell:
        return spells as RxMap<String, T>;
      case dw.Tag:
        return tags as RxMap<String, T>;
    }
    throw TypeError();
  }

  Future<RepositoryService> init() async {
    var cachedClasses = await CacheHandler.instance.getCollection('Classes');
    var cachedItems = await CacheHandler.instance.getCollection('Items');
    var cachedMonsters = await CacheHandler.instance.getCollection('Monsters');
    var cachedMoves = await CacheHandler.instance.getCollection('Moves');
    var cachedRaces = await CacheHandler.instance.getCollection('Races');
    var cachedSpells = await CacheHandler.instance.getCollection('Spells');
    var cachedTags = await CacheHandler.instance.getCollection('Tags');

    if ([
      cachedClasses,
      cachedItems,
      cachedMonsters,
      cachedMoves,
      cachedRaces,
      cachedSpells,
      cachedTags,
    ].any((l) => l.isEmpty)) {
      final resp = await api.requests.getDefaultRepository();

      updateList<CharacterClass>('Classes', classes, resp.classes!,
          key: (x) => x.key, toJson: (x) => x.toJson());
      updateList<Item>('Items', items, resp.items!, key: (x) => x.key, toJson: (x) => x.toJson());
      updateList<Monster>('Monsters', monsters, resp.monsters!,
          key: (x) => x.key, toJson: (x) => x.toJson());
      updateList<Move>('Moves', moves, resp.moves!, key: (x) => x.key, toJson: (x) => x.toJson());
      updateList<Race>('Races', races, resp.races!, key: (x) => x.key, toJson: (x) => x.toJson());
      updateList<Spell>('Spells', spells, resp.spells!,
          key: (x) => x.key, toJson: (x) => x.toJson());
      updateList<dw.Tag>('Tags', tags, resp.tags!, key: (x) => x.name, toJson: (x) => x.toJson());
    } else {
      updateList<CharacterClass>(
          'Classes', classes, cachedClasses.map((x) => CharacterClass.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      updateList<Item>('Items', items, cachedItems.map((x) => Item.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      updateList<Monster>('Monsters', monsters, cachedMonsters.map((x) => Monster.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      updateList<Move>('Moves', moves, cachedMoves.map((x) => Move.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      updateList<Race>('Races', races, cachedRaces.map((x) => Race.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      updateList<Spell>('Spells', spells, cachedSpells.map((x) => Spell.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      updateList<dw.Tag>('Tags', tags, cachedTags.map((x) => dw.Tag.fromJson(x)),
          key: (x) => x.name, toJson: (x) => x.toJson(), saveIntoCache: false);
    }

    return this;
  }

  updateList<T>(
    String collectionName,
    RxMap<String, T> list,
    Iterable<T> resp, {
    required String Function(T item) key,
    required dynamic Function(T item) toJson,
    bool saveIntoCache = true,
  }) {
    list
      ..clear()
      ..addAll(Map.fromIterable(resp, key: (x) => key(x)));

    if (saveIntoCache) {
      for (final x in list.values) CacheHandler.instance.create(collectionName, key(x), toJson(x));
    }
  }
}
