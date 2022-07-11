// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/monster.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/core/http/api_requests/search.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';

import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepositoryService extends GetxService {
  final builtIn = BuiltInRepository(id: 'playbook');
  final my = PersonalRepository(id: 'personal');

  StorageDelegate get storage => StorageHandler.instance;

  void clear() {
    builtIn.clear();
    my.clear();
  }

  @override
  void onClose() async {
    super.onClose();
    builtIn.dispose();
    my.dispose();
  }

  Future<void> loadAllData() async {
    await loadBuiltInRepo();
    await loadMyRepo();
  }

  Future<void> loadBuiltInRepo() {
    return builtIn.init();
  }

  Future<void> loadMyRepo() async {
    await my.init();
  }
}

enum RemoteBehavior {
  whenAllEmpty,
  whenAnyEmpty,
  always,
  never,
}

abstract class RepositoryCache {
  RepositoryCache({required this.id});

  String? get cachePrefix;
  final String id;
  abstract final RemoteBehavior loadRemote;

  final classes = <String, CharacterClass>{}.obs;
  final items = <String, Item>{}.obs;
  final monsters = <String, Monster>{}.obs;
  final moves = <String, Move>{}.obs;
  final races = <String, Race>{}.obs;
  final spells = <String, Spell>{}.obs;
  final tags = <String, dw.Tag>{}.obs;
  final notes = <String, Note>{}.obs;

  final subs = <StreamSubscription>[];

  StorageDelegate get storage => StorageHandler.instance;
  StorageDelegate get cache => CacheHandler.instance;
  Future<SearchResponse> get getFromRemote;

  Future<void> init({bool ignoreCache = false}) async {
    debugPrint('Initializing repo: $id, cache prefix: "${cacheKey('')}"');

    final cacheRes = await getCacheResponse();
    final shouldLoadFromRemote = ignoreCache ? true : await shouldUseRemote(cacheRes);

    if (shouldLoadFromRemote) {
      debugPrint('Cache invalid for $id, loading from remote');
      final resp = await getFromRemote;
      await setAllFrom(resp, saveIntoCache: true);
    } else {
      debugPrint('Cache valid for $id, loading from cache');
      await setAllFrom(cacheRes, saveIntoCache: false);
    }

    registerListeners();
  }

  Future<SearchResponse> getCacheResponse() async {
    return SearchResponse.fromJson({
      'CharacterClasses': await cache.getCollection(cacheKey('CharacterClasses')),
      'Items': await cache.getCollection(cacheKey('Items')),
      'Monsters': await cache.getCollection(cacheKey('Monsters')),
      'Moves': await cache.getCollection(cacheKey('Moves')),
      'Races': await cache.getCollection(cacheKey('Races')),
      'Spells': await cache.getCollection(cacheKey('Spells')),
      'Tags': await cache.getCollection(cacheKey('Tags')),
      'Notes': await cache.getCollection(cacheKey('Notes')),
    });
  }

  Future<bool> shouldUseRemote(SearchResponse cacheRes) async {
    final behaviorMap = <RemoteBehavior, bool>{
      RemoteBehavior.whenAnyEmpty: cacheRes.isAnyEmpty,
      RemoteBehavior.whenAllEmpty: cacheRes.isAllEmpty,
      RemoteBehavior.always: true,
      RemoteBehavior.never: false,
    };

    return behaviorMap[loadRemote]!;
  }

  void registerListeners() {
    debugPrint(
        'registering listeners for $id, delegate: $storage, listener prefix: "${listenerKey('')}"');

    subs.addAll([
      storage.collectionListener(
        listenerKey('CharacterClasses'),
        (d) {
          if (d.isNotEmpty) {
            debugPrint(
                'Update in CharacterClasses for $id: ${[for (var x in d) x['key']].join(',')}');
            classes.value = {for (var x in d) x['key']: CharacterClass.fromJson(x)};
          }
        },
      ),
      storage.collectionListener(
        listenerKey('Items'),
        (d) {
          if (d.isNotEmpty) {
            debugPrint('Update in Items for $id: ${[for (var x in d) x['key']].join(',')}');
            items.value = {for (var x in d) x['key']: Item.fromJson(x)};
          }
        },
      ),
      storage.collectionListener(
        listenerKey('Monsters'),
        (d) {
          if (d.isNotEmpty) {
            debugPrint('Update in Monsters for $id: ${[for (var x in d) x['key']].join(',')}');
            monsters.value = {for (var x in d) x['key']: Monster.fromJson(x)};
          }
        },
      ),
      storage.collectionListener(
        listenerKey('Moves'),
        (d) {
          if (d.isNotEmpty) {
            debugPrint('Update in Moves for $id: ${[for (var x in d) x['key']].join(',')}');
            moves.value = {for (var x in d) x['key']: Move.fromJson(x)};
          }
        },
      ),
      storage.collectionListener(
        listenerKey('Races'),
        (d) {
          if (d.isNotEmpty) {
            debugPrint('Update in Races for $id: ${[for (var x in d) x['key']].join(',')}');
            races.value = {for (var x in d) x['key']: Race.fromJson(x)};
          }
        },
      ),
      storage.collectionListener(
        listenerKey('Spells'),
        (d) {
          if (d.isNotEmpty) {
            debugPrint('Update in Spells for $id: ${[for (var x in d) x['key']].join(',')}');
            spells.value = {for (var x in d) x['key']: Spell.fromJson(x)};
          }
        },
      ),
      storage.collectionListener(
        listenerKey('Tags'),
        (d) {
          if (d.isNotEmpty) {
            debugPrint('Update in Tags for $id: ${[for (var x in d) x['name']].join(',')}');
            tags.value = {for (var x in d) x['name']: dw.Tag.fromJson(x)};
          }
        },
      ),
      storage.collectionListener(
        listenerKey('Notes'),
        (d) {
          if (d.isNotEmpty) {
            debugPrint('Update in Notes for $id: ${[for (var x in d) x['key']].join(',')}');
            notes.value = {for (var x in d) x['key']: Note.fromJson(x)};
          }
        },
      ),
    ]);
  }

  void clearListeners() {
    for (var sub in subs) {
      sub.cancel();
    }
  }

  void dispose() {
    clear();
    clearListeners();
  }

  Future<void> setAllFrom(
    SearchResponse resp, {
    required bool saveIntoCache,
  }) async {
    await Future.wait([
      updateList<CharacterClass>(cacheKey('CharacterClasses'), classes, resp.classes,
          saveIntoCache: saveIntoCache),
      updateList<Item>(cacheKey('Items'), items, resp.items, saveIntoCache: saveIntoCache),
      updateList<Monster>(cacheKey('Monsters'), monsters, resp.monsters,
          saveIntoCache: saveIntoCache),
      updateList<Move>(cacheKey('Moves'), moves, resp.moves, saveIntoCache: saveIntoCache),
      updateList<Race>(cacheKey('Races'), races, resp.races, saveIntoCache: saveIntoCache),
      updateList<Spell>(cacheKey('Spells'), spells, resp.spells, saveIntoCache: saveIntoCache),
      updateList<Note>(cacheKey('Tags'), notes, resp.notes, saveIntoCache: saveIntoCache),
      updateList<dw.Tag>(cacheKey('Tags'), tags, resp.tags, saveIntoCache: saveIntoCache),
    ]);
  }

  String cacheKey(String key) => (cachePrefix ?? '') + key;
  String listenerKey(String key) => cacheKey(key);

  void clear() {
    classes.clear();
    items.clear();
    monsters.clear();
    moves.clear();
    races.clear();
    spells.clear();
    notes.clear();
    tags.clear();
  }

  RxMap<String, T> listByType<T>([Type? type]) {
    assert(T != dynamic || type != null);
    final t = T != dynamic ? T : type;

    switch (t) {
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
      case Note:
        return notes as RxMap<String, T>;
      case dw.Tag:
        return tags as RxMap<String, T>;
    }
    throw TypeError();
  }

  Future<void> updateList<T>(
    String collectionName,
    RxMap<String, T> list,
    Iterable<T>? resp, {
    required bool saveIntoCache,
  }) async {
    if (resp == null) {
      return;
    }

    list.addAll(Map.fromIterable(resp, key: (x) => x.key));

    if (saveIntoCache && list.isNotEmpty) {
      for (final x in list.values)
        await cache.create(collectionName, Meta.keyFor(x), Meta.toJsonFor(x));
    }
  }
}

class BuiltInRepository extends RepositoryCache {
  BuiltInRepository({
    required super.id,
  });

  @override
  String? get cachePrefix => 'repo';

  @override
  Future<SearchResponse> getFromRemote = Future(() {
    try {
      debugPrint('Getting repo content');
      return api.requests.getDefaultRepository(ignoreCache: true);
    } catch (_) {
      debugPrint('Failed getting repo content, using built-in');
      return SearchResponse.fromPackageRepo();
    }
  });

  @override
  StorageDelegate get storage => cache;

  @override
  RemoteBehavior get loadRemote => RemoteBehavior.whenAnyEmpty;

  @override
  String listenerKey(String key) => cacheKey(key);
}

class PersonalRepository extends RepositoryCache {
  PersonalRepository({required super.id});

  @override
  Future<SearchResponse> get getFromRemote => Future(
        () async => SearchResponse.fromJson({
          'CharacterClasses': await storage.getCollection('CharacterClasses'),
          'Items': await storage.getCollection('Items'),
          'Monsters': await storage.getCollection('Monsters'),
          'Moves': await storage.getCollection('Moves'),
          'Races': await storage.getCollection('Races'),
          'Spells': await storage.getCollection('Spells'),
          'Tags': await storage.getCollection('Tags'),
          'Notes': await storage.getCollection('Notes'),
        }),
      );

  @override
  String? get cachePrefix => null;

  @override
  RemoteBehavior get loadRemote => RemoteBehavior.always;
}

mixin RepositoryServiceMixin {
  RepositoryService get repository => Get.find();
  RepositoryService get repo => repository;
}
