// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/monster.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/core/http/api_requests/search.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';

import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

class RepositoryService extends GetxService {
  final builtIn = RepositoryData();
  final my = RepositoryData();

  void clear() {
    builtIn.clear();
    my.clear();
  }

  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<RepositoryService> init() async {
    await _initBuiltInRepo();
    await _initMyRepo();
    return this;
  }

  Future<void> _initBuiltInRepo() async {
    final repo = builtIn;
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

      repo.updateList<CharacterClass>('Classes', repo.classes, resp.classes,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<Item>('Items', repo.items, resp.items,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<Monster>('Monsters', repo.monsters, resp.monsters,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<Move>('Moves', repo.moves, resp.moves,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<Race>('Races', repo.races, resp.races,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<Spell>('Spells', repo.spells, resp.spells,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<dw.Tag>('Tags', repo.tags, resp.tags,
          key: (x) => x.name, toJson: (x) => x.toJson());
    } else {
      repo.updateList<CharacterClass>(
          'Classes', repo.classes, cachedClasses.map((x) => CharacterClass.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<Item>('Items', repo.items, cachedItems.map((x) => Item.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<Monster>(
          'Monsters', repo.monsters, cachedMonsters.map((x) => Monster.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<Move>('Moves', repo.moves, cachedMoves.map((x) => Move.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<Race>('Races', repo.races, cachedRaces.map((x) => Race.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<Spell>('Spells', repo.spells, cachedSpells.map((x) => Spell.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<dw.Tag>('Tags', repo.tags, cachedTags.map((x) => dw.Tag.fromJson(x)),
          key: (x) => x.name, toJson: (x) => x.toJson(), saveIntoCache: false);
    }
  }

  Future<void> _initMyRepo() async {
    final repo = builtIn;
    var cachedClasses = await CacheHandler.instance.getCollection('myClasses');
    var cachedItems = await CacheHandler.instance.getCollection('myItems');
    var cachedMonsters = await CacheHandler.instance.getCollection('myMonsters');
    var cachedMoves = await CacheHandler.instance.getCollection('myMoves');
    var cachedRaces = await CacheHandler.instance.getCollection('myRaces');
    var cachedSpells = await CacheHandler.instance.getCollection('mySpells');
    var cachedTags = await CacheHandler.instance.getCollection('myTags');

    if ([
      cachedClasses,
      cachedItems,
      cachedMonsters,
      cachedMoves,
      cachedRaces,
      cachedSpells,
      cachedTags,
    ].any((l) => l.isEmpty)) {
      final resp = SearchResponse.fromJson({
        'classes': await StorageHandler.instance.getCollection('myClasses'),
        'items': await StorageHandler.instance.getCollection('myItems'),
        'monsters': await StorageHandler.instance.getCollection('myMonsters'),
        'moves': await StorageHandler.instance.getCollection('myMoves'),
        'races': await StorageHandler.instance.getCollection('myRaces'),
        'spells': await StorageHandler.instance.getCollection('mySpells'),
        'tags': await StorageHandler.instance.getCollection('myTags'),
      });

      repo.updateList<CharacterClass>('Classes', repo.classes, resp.classes,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<Item>('Items', repo.items, resp.items,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<Monster>('Monsters', repo.monsters, resp.monsters,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<Move>('Moves', repo.moves, resp.moves,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<Race>('Races', repo.races, resp.races,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<Spell>('Spells', repo.spells, resp.spells,
          key: (x) => x.key, toJson: (x) => x.toJson());
      repo.updateList<dw.Tag>('Tags', repo.tags, resp.tags,
          key: (x) => x.name, toJson: (x) => x.toJson());
    } else {
      repo.updateList<CharacterClass>(
          'Classes', repo.classes, cachedClasses.map((x) => CharacterClass.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<Item>('Items', repo.items, cachedItems.map((x) => Item.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<Monster>(
          'Monsters', repo.monsters, cachedMonsters.map((x) => Monster.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<Move>('Moves', repo.moves, cachedMoves.map((x) => Move.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<Race>('Races', repo.races, cachedRaces.map((x) => Race.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<Spell>('Spells', repo.spells, cachedSpells.map((x) => Spell.fromJson(x)),
          key: (x) => x.key, toJson: (x) => x.toJson(), saveIntoCache: false);
      repo.updateList<dw.Tag>('Tags', repo.tags, cachedTags.map((x) => dw.Tag.fromJson(x)),
          key: (x) => x.name, toJson: (x) => x.toJson(), saveIntoCache: false);
    }
  }
}

class RepositoryData {
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

  updateList<T>(
    String collectionName,
    RxMap<String, T> list,
    Iterable<T>? resp, {
    required String Function(T item) key,
    required dynamic Function(T item) toJson,
    bool saveIntoCache = true,
  }) {
    if (resp == null) {
      return;
    }
    list
      ..clear()
      ..addAll(Map.fromIterable(resp, key: (x) => key(x)));

    if (saveIntoCache) {
      for (final x in list.values) CacheHandler.instance.create(collectionName, key(x), toJson(x));
    }
  }
}
