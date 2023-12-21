import 'dart:convert';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data/services/character_provider.dart';
import '../platforms/platform_export.dart';
import 'import_export_controller.dart';

class ExportController extends ChangeNotifier
    with CharacterProviderMixin, RepositoryProviderMixin
    implements ImportExportSelectionData {
  final toExport = ExportSelections();

  List<Character> get characters => characterProvider.allAsList;
  List<Move> get moves => repo.my.moves.values.toList();
  List<Spell> get spells => repo.my.spells.values.toList();
  List<Item> get items => repo.my.items.values.toList();
  List<CharacterClass> get classes => repo.my.classes.values.toList();
  List<Race> get races => repo.my.races.values.toList();

  ExportController() {
    toExport.characters = List.from(characters);
    toExport.moves = List.from(moves);
    toExport.spells = List.from(spells);
    toExport.items = List.from(items);
    toExport.classes = List.from(classes);
    toExport.races = List.from(races);
  }

  @override
  void toggle<T extends WithMeta>(T item, bool state) =>
      _toggleExportList<T>([item], state);

  @override
  void toggleAll<T extends WithMeta>(bool state) =>
      _toggleExportList<T>(listByType<T>(), state);

  void _toggleExportList<T>(List<T> items, bool state) {
    switch (T) {
      case == Character:
        toExport.characters =
            _toggleInList(toExport.characters, items.cast<Character>(), state);
        break;
      case == Move:
        toExport.moves =
            _toggleInList(toExport.moves, items.cast<Move>(), state);
        break;
      case == Spell:
        toExport.spells =
            _toggleInList(toExport.spells, items.cast<Spell>(), state);
        break;
      case == Item:
        toExport.items =
            _toggleInList(toExport.items, items.cast<Item>(), state);
        break;
      case == CharacterClass:
        toExport.classes = _toggleInList(
            toExport.classes, items.cast<CharacterClass>(), state);
        break;
      case == Race:
        toExport.races =
            _toggleInList(toExport.races, items.cast<Race>(), state);
        break;
    }
    notifyListeners();
  }

  @override
  bool isSelected<T extends WithMeta>(T item) {
    return toExport.listByType<T>().map((x) => x.key).contains(item.key);
  }

  List<T> _toggleInList<T>(List<T> list, List<T> items, bool state) {
    late List<T> res;
    if (state) {
      res = addByKey<T>(list, items);
    } else {
      res = removeByKey<T>(list, items);
    }
    notifyListeners();
    return res;
  }

  void Function()? getDoExport(BuildContext context) {
    return () async {
      final strData = utf8.encode(json.encode(toExport.toJson()));

      final dt = DateFormat('yy-MM-dd_HH.mm.ss').format(DateTime.now());
      final fileName = 'DungeonPaperV2_$dt.json';

      Exporter().export(context, strData, fileName);
    };
  }

  @override
  List<T> listByType<T extends WithMeta>() {
    switch (T) {
      case == Character:
        return characters as List<T>;
      case == Move:
        return moves as List<T>;
      case == Spell:
        return spells as List<T>;
      case == Item:
        return items as List<T>;
      case == CharacterClass:
        return classes as List<T>;
      case == Race:
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
      case == Character:
        return characters as List<T>;
      case == Move:
        return moves as List<T>;
      case == Spell:
        return spells as List<T>;
      case == Item:
        return items as List<T>;
      case == CharacterClass:
        return classes as List<T>;
      case == Race:
        return races as List<T>;
    }
    throw TypeError();
  }
}
