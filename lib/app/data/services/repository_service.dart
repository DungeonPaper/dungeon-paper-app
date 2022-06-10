// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/monster.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/model_utils/model_json.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/core/http/api_requests/search.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';

import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RepositoryService extends GetxService {
  final builtIn = RepositoryCache(
    id: 'playbook',
    cachePrefix: 'repo',
    loadRemote: RemoteBehavior.whenAnyEmpty,
  );
  final my = RepositoryCache(
    id: 'personal',
    loadRemote: RemoteBehavior.always,
  );
  StorageDelegate get storage => StorageHandler.instance;

  void clear() {
    builtIn.clear();
    my.clear();
  }

  @override
  void onInit() {
    super.onInit();
    loadAllData();
  }

  @override
  void onClose() async {
    super.onClose();
    builtIn.dispose();
    my.dispose();
  }

  Future<RepositoryService> loadAllData() async {
    await builtIn.init(Future(() {
      try {
        return api.requests.getDefaultRepository(ignoreCache: true);
      } catch (_) {
        return SearchResponse.fromPackageRepo();
      }
    }));
    await my.init(
      Future(
        () async => SearchResponse.fromJson({
          'classes': await storage.getCollection('Classes'),
          'items': await storage.getCollection('Items'),
          'monsters': await storage.getCollection('Monsters'),
          'moves': await storage.getCollection('Moves'),
          'races': await storage.getCollection('Races'),
          'spells': await storage.getCollection('Spells'),
          'tags': await storage.getCollection('Tags'),
          'notes': await storage.getCollection('Notes'),
        }),
      ),
    );
    return this;
  }
}

enum RemoteBehavior {
  whenAllEmpty,
  whenAnyEmpty,
  always,
  never,
}

class RepositoryCache {
  RepositoryCache({required this.id, this.cachePrefix, required this.loadRemote});

  final String? cachePrefix;
  final String id;
  final RemoteBehavior loadRemote;

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

  Future<void> init(Future<SearchResponse> getFromRemote) async {
    debugPrint('Initializing repo: $id');

    final cacheRes = SearchResponse.fromJson({
      'Classes': await cache.getCollection(keyClasses),
      'Items': await cache.getCollection(keyItems),
      'Monsters': await cache.getCollection(keyMonsters),
      'Moves': await cache.getCollection(keyMoves),
      'Races': await cache.getCollection(keyRaces),
      'Spells': await cache.getCollection(keySpells),
      'Tags': await cache.getCollection(keyTags),
      'Notes': await cache.getCollection(keyNotes),
    });

    final behaviorMap = <RemoteBehavior, bool>{
      RemoteBehavior.whenAnyEmpty: cacheRes.isAnyEmpty,
      RemoteBehavior.whenAllEmpty: cacheRes.isAllEmpty,
      RemoteBehavior.always: true,
      RemoteBehavior.never: false,
    };

    final shouldLoadFromRemote = behaviorMap[loadRemote]!;

    if (shouldLoadFromRemote) {
      debugPrint('Cache invalid for $id, loading from remote');
      await setAllFrom(await getFromRemote, saveIntoCache: true);
    } else {
      debugPrint('Cache valid for $id, loading from cache');
      await setAllFrom(cacheRes, saveIntoCache: false);
    }

    registerListeners();
  }

  void registerListeners() {
    subs.addAll([
      storage.collectionListener(keyClasses,
          (d) => classes.value = {for (var x in d) x['key']: CharacterClass.fromJson(x)}),
      storage.collectionListener(
          keyItems, (d) => items.value = {for (var x in d) x['key']: Item.fromJson(x)}),
      storage.collectionListener(
          keyMonsters, (d) => monsters.value = {for (var x in d) x['key']: Monster.fromJson(x)}),
      storage.collectionListener(
          keyMoves, (d) => moves.value = {for (var x in d) x['key']: Move.fromJson(x)}),
      storage.collectionListener(
          keyRaces, (d) => races.value = {for (var x in d) x['key']: Race.fromJson(x)}),
      storage.collectionListener(
          keySpells, (d) => spells.value = {for (var x in d) x['key']: Spell.fromJson(x)}),
      storage.collectionListener(
          keyTags, (d) => tags.value = {for (var x in d) x['name']: dw.Tag.fromJson(x)}),
      storage.collectionListener(
          keyNotes, (d) => notes.value = {for (var x in d) x['key']: Note.fromJson(x)}),
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
      updateList<CharacterClass>(keyClasses, classes, resp.classes, saveIntoCache: saveIntoCache),
      updateList<Item>(keyItems, items, resp.items, saveIntoCache: saveIntoCache),
      updateList<Monster>(keyMonsters, monsters, resp.monsters, saveIntoCache: saveIntoCache),
      updateList<Move>(keyMoves, moves, resp.moves, saveIntoCache: saveIntoCache),
      updateList<Race>(keyRaces, races, resp.races, saveIntoCache: saveIntoCache),
      updateList<Spell>(keySpells, spells, resp.spells, saveIntoCache: saveIntoCache),
      updateList<Note>(keyTags, notes, resp.notes, saveIntoCache: saveIntoCache),
      updateList<dw.Tag>(keyTags, tags, resp.tags, saveIntoCache: saveIntoCache),
    ]);
  }

  String _key(String key) => (cachePrefix ?? '') + key;
  String get keyClasses => _key('Classes');
  String get keyItems => _key('Items');
  String get keyMonsters => _key('Monsters');
  String get keyMoves => _key('Moves');
  String get keyRaces => _key('Races');
  String get keySpells => _key('Spells');
  String get keyTags => _key('Tags');
  String get keyNotes => _key('Notes');

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

    list.addAll(Map.fromIterable(resp, key: (x) => keyFor(x as T)));

    if (saveIntoCache) {
      for (final x in list.values) await cache.create(collectionName, keyFor(x), toJsonFor(x));
    }
  }
}

mixin RepositoryServiceMixin {
  RepositoryService get repository => Get.find();
  RepositoryService get repo => repository;
}
