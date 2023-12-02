import 'dart:convert';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'import_export_controller.dart';

import 'package:dungeon_paper/app/modules/ImportExport/platforms/abstract_export.dart'
    if (dart.library.io) 'package:dungeon_paper/app/modules/ImportExport/platforms/native_export.dart'
    if (dart.library.html) 'package:dungeon_paper/app/modules/ImportExport/platforms/web_export.dart';

class ExportController extends GetxController
    with GetSingleTickerProviderStateMixin, CharacterServiceMixin, RepositoryServiceMixin
    implements ImportExportSelectionData {
  final toExport = ExportSelections().obs;

  List<Character> get characters => characterService.allAsList;
  List<Move> get moves => repo.my.moves.values.toList();
  List<Spell> get spells => repo.my.spells.values.toList();
  List<Item> get items => repo.my.items.values.toList();
  List<CharacterClass> get classes => repo.my.classes.values.toList();
  List<Race> get races => repo.my.races.values.toList();

  @override
  void onInit() {
    super.onInit();
    toExport.value.characters = List.from(characters);
    toExport.value.moves = List.from(moves);
    toExport.value.spells = List.from(spells);
    toExport.value.items = List.from(items);
    toExport.value.classes = List.from(classes);
    toExport.value.races = List.from(races);
  }

  @override
  void toggle<T extends WithMeta>(T item, bool state) => _toggleExportList<T>([item], state);

  @override
  void toggleAll<T extends WithMeta>(bool state) => _toggleExportList<T>(listByType<T>(), state);

  void _toggleExportList<T>(List<T> items, bool state) {
    switch (T) {
      case Character:
        toExport.value.characters = _toggleInList(toExport.value.characters, items.cast<Character>(), state);
        break;
      case Move:
        toExport.value.moves = _toggleInList(toExport.value.moves, items.cast<Move>(), state);
        break;
      case Spell:
        toExport.value.spells = _toggleInList(toExport.value.spells, items.cast<Spell>(), state);
        break;
      case Item:
        toExport.value.items = _toggleInList(toExport.value.items, items.cast<Item>(), state);
        break;
      case CharacterClass:
        toExport.value.classes = _toggleInList(toExport.value.classes, items.cast<CharacterClass>(), state);
        break;
      case Race:
        toExport.value.races = _toggleInList(toExport.value.races, items.cast<Race>(), state);
        break;
    }
    toExport.refresh();
  }

  @override
  bool isSelected<T extends WithMeta>(T item) {
    return toExport.value.listByType<T>().map((x) => x.key).contains(item.key);
  }

  List<T> _toggleInList<T>(List<T> list, List<T> items, bool state) {
    if (state) {
      return addByKey<T>(list, items);
    } else {
      return removeByKey<T>(list, items);
    }
  }

  void Function()? getDoExport() {
    return () async {
      final strData = utf8.encode(json.encode(toExport.value.toJson()));

      final dt = DateFormat('yy-MM-dd_HH.mm.ss').format(DateTime.now());
      final fileName = 'DungeonPaperV2_$dt.json';

      Exporter().export(strData, fileName);
    };
  }

  @override
  List<T> listByType<T extends WithMeta>() {
    switch (T) {
      case Character:
        return characters as List<T>;
      case Move:
        return moves as List<T>;
      case Spell:
        return spells as List<T>;
      case Item:
        return items as List<T>;
      case CharacterClass:
        return classes as List<T>;
      case Race:
        return races as List<T>;
    }
    throw TypeError();
  }
}

class ExportSelections {
  List<CharacterClass> classes = [];
  List<Character> characters = [];
  List<Move> moves = [];
  List<Spell> spells = [];
  List<Item> items = [];
  List<Race> races = [];

  Map<String, dynamic> toJson() => {
        'classes': classes.map((x) => x.toJson()).toList(),
        'characters': characters.map((x) => x.toJson()).toList(),
        'moves': moves.map((x) => x.toJson()).toList(),
        'spells': spells.map((x) => x.toJson()).toList(),
        'items': items.map((x) => x.toJson()).toList(),
        'races': races.map((x) => x.toJson()).toList(),
      };

  List<T> listByType<T>() {
    switch (T) {
      case Character:
        return characters as List<T>;
      case Move:
        return moves as List<T>;
      case Spell:
        return spells as List<T>;
      case Item:
        return items as List<T>;
      case CharacterClass:
        return classes as List<T>;
      case Race:
        return races as List<T>;
    }
    throw TypeError();
  }
}
