import 'dart:convert';
import 'dart:io';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/ImportExport/local_widgets/import_progress_dialog.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';

import 'import_export_controller.dart';

class ImportController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements ImportExportSelectionData {
  final Rx<ImportSelections?> toImport = Rx(null);

  List<Character> get characters => toImport.value!.allCharacters.toList();
  List<Move> get moves => toImport.value!.allMoves.toList();
  List<Spell> get spells => toImport.value!.allSpells.toList();
  List<Item> get items => toImport.value!.allItems.toList();
  List<CharacterClass> get classes => toImport.value!.allClasses.toList();
  List<Race> get races => toImport.value!.allRaces.toList();

  int get selectionsCount => [characters, moves, spells, items, classes].fold(0, (total, list) => total + list.length);

  bool get hasData => toImport.value != null;

  final importStep = Rx<Type?>(null);
  final leftCount = 0.obs;

  @override
  void toggle<T extends WithMeta>(T item, bool state) => _toggleImportList<T>([item], state);

  @override
  void toggleAll<T extends WithMeta>(bool state) => _toggleImportList<T>(listByType<T>(), state);

  void _toggleImportList<T>(List<T> items, bool state) {
    switch (T) {
      case Character:
        toImport.value!.characters = _toggleInList(toImport.value!.characters, items.cast<Character>(), state);
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
        toImport.value!.classes = _toggleInList(toImport.value!.classes, items.cast<CharacterClass>(), state);
        break;
      case Race:
        toImport.value!.races = _toggleInList(toImport.value!.races, items.cast<Race>(), state);
        break;
    }
    toImport.refresh();
  }

  @override
  bool isSelected<T extends WithMeta>(T item) {
    return toImport.value!.listByType<T>(selected: true).map((x) => x.key).contains(item.key);
  }

  List<T> _toggleInList<T>(List<T> list, List<T> items, bool state) {
    if (state) {
      return addByKey<T>(list, items);
    } else {
      return removeByKey<T>(list, items);
    }
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

  void pickImportFile() async {
    var result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['json']);
    if (result == null) {
      Get.rawSnackbar(
        title: S.current.importFailedTitle,
        message: S.current.importFailedMessage,
      );
      return;
    }

    final filedata = result.files.single.bytes;
    final filestring = utf8.decode(filedata as List<int>);
    final filejson = json.decode(filestring);
    toImport.value = ImportSelections.fromJson(filejson);
    /*
    try {
      final path = await FlutterFileDialog.pickFile(
        params: const OpenFileDialogParams(
          fileExtensionsFilter: ['json'],
          mimeTypesFilter: ['application/json'],
        ),
      );

      if (path == null) {
        return;
      }

      final js = json.decode(await File(path).readAsString()) as Map<String, dynamic>;
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
  */
  }

  void Function()? getDoImport() {
    if (!hasData || toImport.value?.hasSelections != true) {
      return null;
    }

    return () async {
      leftCount.value = selectionsCount;

      Get.dialog(const ImportProgressDialog(), barrierDismissible: false);
      importStep.value = Character;

      await Future.delayed(const Duration(milliseconds: 500));

      for (final char in characters) {
        await StorageHandler.instance.create('Characters', char.key, char.toJson());
        leftCount.value -= 1;
      }
      importStep.value = CharacterClass;
      for (final cls in classes) {
        await StorageHandler.instance.create('CharacterClasses', cls.key, cls.toJson());
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
      await Future.delayed(const Duration(milliseconds: 500));
      Get.back();

      Get.rawSnackbar(
        title: S.current.importSuccessTitle,
        message: S.current.importSuccessMessage,
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
  final List<Race> allRaces;

  ImportSelections({
    required this.allClasses,
    required this.allCharacters,
    required this.allMoves,
    required this.allSpells,
    required this.allItems,
    required this.allRaces,
    this.classes = const [],
    this.characters = const [],
    this.moves = const [],
    this.spells = const [],
    this.items = const [],
    this.races = const [],
  });

  List<CharacterClass> classes;
  List<Character> characters;
  List<Move> moves;
  List<Spell> spells;
  List<Item> items;
  List<Race> races;

  factory ImportSelections.fromJson(Map<String, dynamic> json) {
    final allClasses = (json['classes'] ?? []).map((x) => CharacterClass.fromJson(x)).toList().cast<CharacterClass>();
    final allCharacters =
        List<dynamic>.from(json['characters'] ?? []).map((x) => Character.fromJson(x)).toList().cast<Character>();
    final allMoves = List<dynamic>.from(json['moves'] ?? []).map((x) => Move.fromJson(x)).toList().cast<Move>();
    final allSpells = List<dynamic>.from(json['spells'] ?? []).map((x) => Spell.fromJson(x)).toList().cast<Spell>();
    final allItems = List<dynamic>.from(json['items'] ?? []).map((x) => Item.fromJson(x)).toList().cast<Item>();
    final allRaces = List<dynamic>.from(json['races'] ?? []).map((x) => Race.fromJson(x)).toList().cast<Race>();

    return ImportSelections(
      allClasses: allClasses,
      allCharacters: allCharacters,
      allMoves: allMoves,
      allSpells: allSpells,
      allItems: allItems,
      allRaces: allRaces,
      classes: allClasses,
      characters: allCharacters,
      moves: allMoves,
      spells: allSpells,
      items: allItems,
      races: allRaces,
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
      case Race:
        return (selected ? races : allRaces) as List<T>;
    }
    throw TypeError();
  }

  bool get hasSelections => [
        classes,
        characters,
        moves,
        spells,
        items,
        races,
      ].any((l) => l.isNotEmpty);
}
