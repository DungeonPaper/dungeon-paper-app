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
import 'package:dungeon_paper/core/utils/list_utils.dart';

import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepositoryService extends GetxService {
  final builtIn = BuiltInRepository(id: 'playbook');
  final my = PersonalRepository(id: 'personal');

  StorageDelegate get storage => StorageHandler.instance;

  void clear() {
    builtIn._clearValues();
    my._clearValues();
  }

  @override
  void onClose() async {
    super.onClose();
    await Future.wait([builtIn.dispose(), my.dispose()]);
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

enum RepositoryStatus {
  loading,
  loaded,
  error,
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

  RepositoryStatus status = RepositoryStatus.loading;

  bool get isLoading => status == RepositoryStatus.loading;
  bool get isLoaded => status == RepositoryStatus.loaded;
  bool get isError => status == RepositoryStatus.error;

  StorageDelegate get storage => StorageHandler.instance;
  StorageDelegate get cache => CacheHandler.instance;
  Future<SearchResponse> get getFromRemote;

  Future<void> init({bool ignoreCache = false}) async {
    clearListeners();
    status = RepositoryStatus.loading;
    debugPrint('[$id] Initializing repo: $id, cache prefix: "${cacheKey('')}"');

    try {
      SearchResponse cacheRes;

      try {
        cacheRes = ignoreCache ? SearchResponse.empty() : await getCacheResponse();
      } catch (e) {
        cacheRes = SearchResponse.empty();
      }
      final shouldLoadFromRemote = ignoreCache ? true : await shouldUseRemote(cacheRes);

      if (shouldLoadFromRemote) {
        debugPrint('[$id] Cache ${ignoreCache ? 'skipped' : 'invalid'}, loading from remote');
        SearchResponse resp;
        try {
          resp = await getFromRemote;
          await setAllFrom(resp, saveIntoCache: true);
        } catch (e) {
          debugPrint('[$id] Error loading from remote: $e');
          resp = SearchResponse.empty();
        }
      } else {
        debugPrint('[$id] Cache valid, loading from cache');
        await setAllFrom(cacheRes, saveIntoCache: false);
      }

      debugPrint('[$id] Finished loading $id, registering listeners');

      registerListeners();
      status = RepositoryStatus.loaded;
    } catch (e) {
      status = RepositoryStatus.error;
      rethrow;
    }
  }

  Future<SearchResponse> getCacheResponse() async {
    final promises = {
      'CharacterClasses': cache.getCollection(cacheKey('CharacterClasses')),
      'Items': cache.getCollection(cacheKey('Items')),
      'Monsters': cache.getCollection(cacheKey('Monsters')),
      'Moves': cache.getCollection(cacheKey('Moves')),
      'Races': cache.getCollection(cacheKey('Races')),
      'Spells': cache.getCollection(cacheKey('Spells')),
      'Tags': cache.getCollection(cacheKey('Tags')),
      'Notes': cache.getCollection(cacheKey('Notes')),
    };
    final resp = await Future.wait(promises.values);
    final keys = promises.keys.toList();

    return SearchResponse.fromJson({
      'CharacterClasses': resp[keys.indexOf('CharacterClasses')],
      'Items': resp[keys.indexOf('Items')],
      'Monsters': resp[keys.indexOf('Monsters')],
      'Moves': resp[keys.indexOf('Moves')],
      'Races': resp[keys.indexOf('Races')],
      'Spells': resp[keys.indexOf('Spells')],
      'Tags': resp[keys.indexOf('Tags')],
      'Notes': resp[keys.indexOf('Notes')],
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
    clearListeners();
    debugPrint('[$id] registering listeners, delegate: $storage, listener prefix: "${listenerKey('')}"');

    subs.addAll([
      storage.collectionListener(
        listenerKey('CharacterClasses'),
        (d) {
          _parseMap<CharacterClass>(
            d,
            key: (x) => x.key,
            save: (x) => classes.value = x,
            parse: (x) => CharacterClass.fromJson(x),
          );
        },
      ),
      storage.collectionListener(
        listenerKey('Items'),
        (d) {
          _parseMap<Item>(
            d,
            key: (x) => x.key,
            save: (x) => items.value = x,
            parse: (x) => Item.fromJson(x),
          );
        },
      ),
      storage.collectionListener(
        listenerKey('Monsters'),
        (d) {
          _parseMap<Monster>(
            d,
            key: (x) => x.key,
            save: (x) => monsters.value = x,
            parse: (x) => Monster.fromJson(x),
          );
        },
      ),
      storage.collectionListener(
        listenerKey('Moves'),
        (d) {
          _parseMap<Move>(
            d,
            key: (x) => x.key,
            save: (x) => moves.value = x,
            parse: (x) => Move.fromJson(x),
          );
        },
      ),
      storage.collectionListener(
        listenerKey('Races'),
        (d) {
          _parseMap<Race>(
            d,
            key: (x) => x.key,
            save: (x) => races.value = x,
            parse: (x) => Race.fromJson(x),
          );
        },
      ),
      storage.collectionListener(
        listenerKey('Spells'),
        (d) {
          _parseMap<Spell>(
            d,
            key: (x) => x.key,
            save: (x) => spells.value = x,
            parse: (x) => Spell.fromJson(x),
          );
        },
      ),
      storage.collectionListener(
        listenerKey('Tags'),
        (d) {
          _parseMap<dw.Tag>(
            d,
            key: (x) => x.name,
            save: (x) => tags.value = x,
            parse: (x) => dw.Tag.fromJson(x),
          );
        },
      ),
      storage.collectionListener(
        listenerKey('Notes'),
        (d) {
          _parseMap<Note>(
            d,
            key: (x) => x.key,
            save: (x) => notes.value = x,
            parse: (x) => Note.fromJson(x),
          );
        },
      ),
    ]);
  }

  Map<String, T> _parseMap<T>(
    List<dynamic> list, {
    required void Function(Map<String, T>) save,
    required String Function(T) key,
    required T Function(dynamic) parse,
  }) {
    if (list.isEmpty) {
      return const {};
    }
    final out = <String, T>{};
    debugPrint('[$id] Update in $T: ${list.length} items');
    for (final entry in list) {
      try {
        final obj = parse(entry);
        final _key = key(obj);
        out[_key] = obj;
      } catch (e) {
        debugPrint('[$id] Error parsing $T: $entry');
      }
    }
    save(out);
    return out;
  }

  void clearListeners() {
    debugPrint('[$id] Clearing listeners');
    for (var sub in subs) {
      sub.cancel();
    }
    subs.clear();
  }

  Future<void> dispose() async {
    clearListeners();
    _clearValues();
    await cache.clear();
  }

  Future<void> setAllFrom(
    SearchResponse resp, {
    required bool saveIntoCache,
  }) async {
    await Future.wait([
      updateList<CharacterClass>(cacheKey('CharacterClasses'), classes, resp.classes, saveIntoCache: saveIntoCache),
      updateList<Item>(cacheKey('Items'), items, resp.items, saveIntoCache: saveIntoCache),
      updateList<Monster>(cacheKey('Monsters'), monsters, resp.monsters, saveIntoCache: saveIntoCache),
      updateList<Move>(cacheKey('Moves'), moves, resp.moves, saveIntoCache: saveIntoCache),
      updateList<Race>(cacheKey('Races'), races, resp.races, saveIntoCache: saveIntoCache),
      updateList<Spell>(cacheKey('Spells'), spells, resp.spells, saveIntoCache: saveIntoCache),
      updateList<Note>(cacheKey('Tags'), notes, resp.notes, saveIntoCache: saveIntoCache),
      updateList<dw.Tag>(cacheKey('Tags'), tags, resp.tags, saveIntoCache: saveIntoCache),
    ]);
  }

  String cacheKey(String key) => (cachePrefix ?? '') + key;
  String listenerKey(String key) => cacheKey(key);

  void _clearValues() {
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
    debugPrint('[$id] Update in $collectionName (${resp.length})');
    list.addAll(Map.fromIterable(resp, key: (x) => x.key));

    if (saveIntoCache && list.isNotEmpty) {
      for (final x in list.values) await cache.create(collectionName, Meta.keyFor(x), Meta.toJsonFor(x));
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
      debugPrint('[playbook] Getting repo content');
      return api.requests.getDefaultRepository(ignoreCache: true);
    } catch (_) {
      debugPrint('[playbook] Failed getting repo content, using built-in');
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
        () async {
          final futures = {
            'CharacterClasses': storage.getCollection('CharacterClasses'),
            'Items': storage.getCollection('Items'),
            'Monsters': storage.getCollection('Monsters'),
            'Moves': storage.getCollection('Moves'),
            'Races': storage.getCollection('Races'),
            'Spells': storage.getCollection('Spells'),
            'Tags': storage.getCollection('Tags'),
            'Notes': storage.getCollection('Notes'),
          };
          return Future.wait(futures.values).then((v) async {
            final map = {for (final e in enumerate(v)) futures.keys.elementAt(e.index): e.value};
            return SearchResponse.fromJson(map);
          });
        },
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
