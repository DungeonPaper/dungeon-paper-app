import 'dart:math';

import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/core/http/api_requests/search.dart';
import 'package:dungeon_paper/core/pref_keys.dart';
import 'package:dungeon_paper/core/shared_preferences.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/character.dart';
import '../models/character_class.dart';
import '../models/character_stats.dart';
import '../models/meta.dart';
import '../models/move.dart';
import '../models/spell.dart';

class ClassService extends GetxService {
  final all = <String, CharacterClass>{}.obs;

  void clear() {
    all.clear();
  }

  @override
  void onInit() async {
    super.onInit();
    init();
  }

  Future<ClassService> init() async {
    var json = await CacheHandler.instance.getCollection('classes');
    Iterable<CharacterClass> list;

    if (json.isEmpty) {
      var resp = await api.requests.search(SearchRequest(types: {SearchType.classes}, query: ''));
      list = resp.classes!;
      for (final cls in list) {
        CacheHandler.instance.create('classes', cls.key, cls.toJson());
      }
    } else {
      list = json.map((c) => CharacterClass.fromJson(c));
    }

    all.addAll(Map.fromIterable(list, key: (c) => c.key));

    return this;
  }
}
