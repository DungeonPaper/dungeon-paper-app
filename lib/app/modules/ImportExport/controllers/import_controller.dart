import 'dart:convert';
import 'dart:io';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/modules/ImportExport/local_widgets/import_progress_dialog.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';

import 'import_export_controller.dart';

class ImportController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements ImportExportSelectionData {
  final Rx<ImportSelections?> toImport = Rx(null);

  CharacterService get characterService => Get.find();
  RepositoryService get repoService => Get.find();

  List<Character> get characters => toImport.value!.allCharacters.toList();
  List<Move> get moves => toImport.value!.allMoves.toList();
  List<Spell> get spells => toImport.value!.allSpells.toList();
  List<Item> get items => toImport.value!.allItems.toList();
  List<CharacterClass> get classes => toImport.value!.allClasses.toList();

  int get selectionsCount =>
      [characters, moves, spells, items, classes].fold(0, (total, list) => total + list.length);

  bool get hasData => toImport.value != null;

  final importStep = Rx<Type?>(null);
  final leftCount = 0.obs;

  @override
  void toggle<T>(T item, bool state) => _toggleImportList<T>([item], state);

  @override
  void toggleAll<T>(bool state) => _toggleImportList<T>(listByType<T>(), state);

  void _toggleImportList<T>(List<T> items, bool state) {
    switch (T) {
      case Character:
        toImport.value!.characters =
            _toggleInList(toImport.value!.characters, items.cast<Character>(), state);
        break;
      case Move:
        toImport.value!.moves = _toggleInList(toImport.value!.moves, items.cast<Move>(), state);
        break;
      case Spell:
        toImport.value!.spells = _toggleInList(toImport.value!.spells, items.cast<Spell>(), state);
        break;
      case Item:
        toImport.value!.items = _toggleInList(toImport.value!.items, items.cast<Item>(), state);
        break;
      case CharacterClass:
        toImport.value!.classes =
            _toggleInList(toImport.value!.classes, items.cast<CharacterClass>(), state);
        break;
    }
    toImport.refresh();
  }

  @override
  bool isSelected<T>(T item) {
    return toImport.value!.listByType<T>(selected: true).map(keyFor).contains(keyFor(item));
  }

  List<T> _toggleInList<T>(List<T> list, List<T> items, bool state) {
    if (state) {
      return addByKey<T>(list, items);
    } else {
      return removeByKey<T>(list, items);
    }
  }

  @override
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
    }
    throw TypeError();
  }

  void pickImportFile() async {
    try {
      final _path = await FlutterFileDialog.pickFile(
        params: const OpenFileDialogParams(
          fileExtensionsFilter: ['json'],
          mimeTypesFilter: ['application/json'],
        ),
      );

      if (_path == null) {
        return;
      }

      final js = json.decode(await File(_path).readAsString()) as Map<String, dynamic>;
      toImport.value = ImportSelections.fromJson(js);
    } catch (e) {
      // unawaited(analytics.logEvent(name: Events.ImportFail, parameters: {
      //   'reason': e.toString(),
      // }));
      Get.rawSnackbar(
        title: S.current.importFailedTitle,
        message: S.current.importFailedMessage,
      );
      rethrow;
    }
  }

  void Function()? getDoImport() {
    if (!hasData || toImport.value?.hasSelections != true) {
      return null;
    }

    return () async {
      leftCount.value = selectionsCount;

      Get.dialog(const ImportProgressDialog());

      importStep.value = Character;
      for (final char in characters) {
        await StorageHandler.instance.create('Characters', char.key, char.toJson());
        leftCount.value -= 1;
      }
      importStep.value = CharacterClass;
      for (final cls in classes) {
        await StorageHandler.instance.create('Classes', cls.key, cls.toJson());
        leftCount.value -= 1;
      }
      importStep.value = Move;
      for (final move in moves) {
        await StorageHandler.instance.create('Moves', move.key, move.toJson());
        leftCount.value -= 1;
      }
      importStep.value = Spell;
      for (final spell in spells) {
        await StorageHandler.instance.create('Spells', spell.key, spell.toJson());
        leftCount.value -= 1;
      }
      importStep.value = Item;
      for (final items in items) {
        await StorageHandler.instance.create('Items', items.key, items.toJson());
        leftCount.value -= 1;
      }
      await Future.delayed(const Duration(seconds: 1));
      Get.back();

      Get.rawSnackbar(
        title: S.current.importFailedTitle,
        message: S.current.importFailedMessage,
      );
    };
  }
}

class ImportSelections {
  final List<CharacterClass> allClasses;
  final List<Character> allCharacters;
  final List<Move> allMoves;
  final List<Spell> allSpells;
  final List<Item> allItems;

  ImportSelections({
    required this.allClasses,
    required this.allCharacters,
    required this.allMoves,
    required this.allSpells,
    required this.allItems,
    this.classes = const [],
    this.characters = const [],
    this.moves = const [],
    this.spells = const [],
    this.items = const [],
  });

  List<CharacterClass> classes;
  List<Character> characters;
  List<Move> moves;
  List<Spell> spells;
  List<Item> items;

  factory ImportSelections.fromJson(Map<String, dynamic> json) {
    final allClasses = (json['classes'] ?? [])
        .map((x) => CharacterClass.fromJson(x))
        .toList()
        .cast<CharacterClass>();
    final allCharacters =
        (json['characters'] ?? []).map((x) => Character.fromJson(x)).toList().cast<Character>();
    final allMoves = (json['moves'] ?? []).map((x) => Move.fromJson(x)).toList().cast<Move>();
    final allSpells = (json['spells'] ?? []).map((x) => Spell.fromJson(x)).toList().cast<Spell>();
    final allItems = (json['items'] ?? []).map((x) => Item.fromJson(x)).toList().cast<Item>();
    return ImportSelections(
      allClasses: allClasses,
      allCharacters: allCharacters,
      allMoves: allMoves,
      allSpells: allSpells,
      allItems: allItems,
      classes: allClasses,
      characters: allCharacters,
      moves: allMoves,
      spells: allSpells,
      items: allItems,
    );
  }

  List<T> listByType<T>({required bool selected}) {
    switch (T) {
      case Character:
        return (selected ? characters : allCharacters) as List<T>;
      case Move:
        return (selected ? moves : allMoves) as List<T>;
      case Spell:
        return (selected ? spells : allSpells) as List<T>;
      case Item:
        return (selected ? items : allItems) as List<T>;
      case CharacterClass:
        return (selected ? classes : allClasses) as List<T>;
    }
    throw TypeError();
  }

  bool get hasSelections => [
        classes,
        characters,
        moves,
        spells,
        items,
      ].any((l) => l.isNotEmpty);
}
