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
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import 'import_export_controller.dart';

class ExportController extends GetxController
    with GetSingleTickerProviderStateMixin
    implements ImportExportSelectionData {
  final toExport = ExportSelections().obs;

  CharacterService get characterService => Get.find();
  RepositoryService get repoService => Get.find();

  List<Character> get characters => characterService.all;
  List<Move> get moves => repoService.my.moves.values.toList();
  List<Spell> get spells => repoService.my.spells.values.toList();
  List<Item> get items => repoService.my.items.values.toList();
  List<CharacterClass> get classes => repoService.my.classes.values.toList();

  @override
  void onInit() {
    super.onInit();
    toExport.value.characters = List.from(characters);
    toExport.value.moves = List.from(moves);
    toExport.value.spells = List.from(spells);
    toExport.value.items = List.from(items);
    toExport.value.classes = List.from(classes);
  }

  @override
  void toggle<T>(T item, bool state) => _toggleExportList<T>([item], state);

  @override
  void toggleAll<T>(bool state) => _toggleExportList<T>(listByType<T>(), state);

  void _toggleExportList<T>(List<T> items, bool state) {
    switch (T) {
      case Character:
        toExport.value.characters =
            _toggleInList(toExport.value.characters, items.cast<Character>(), state);
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
        toExport.value.classes =
            _toggleInList(toExport.value.classes, items.cast<CharacterClass>(), state);
        break;
    }
    toExport.refresh();
  }

  @override
  bool isSelected<T>(T item) {
    return toExport.value.listByType<T>().map(keyFor).contains(keyFor(item));
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
      final _strData = utf8.encode(json.encode(toExport.value.toJson()));
      final tmp = await getTemporaryDirectory();
      final dt = DateFormat('yy-MM-dd_HH.mm.ss').format(DateTime.now());
      final fileName = 'DungeonPaperV2-$dt.json';

      final _tmpFile = File(path.join(tmp.path, fileName));
      await _tmpFile.writeAsBytes(_strData);

      final params = SaveFileDialogParams(sourceFilePath: _tmpFile.path);
      try {
        final path = await FlutterFileDialog.saveFile(params: params);
        if (path == null) {
          // unawaited(analytics.logEvent(name: Events.ExportFail, parameters: {
          //   'reason': 'user_canceled',
          // }));
          // TODO intl
          Get.rawSnackbar(title: 'Export Failed', message: 'Operation canceled');
        } else {
          // unawaited(analytics.logEvent(name: Events.ExportSuccess, parameters: {
          //   'characters_count': _charactersToExport?.length ?? 0,
          //   'classes_count': _classesToExport?.length ?? 0,
          // }));
          // TODO intl
          Get.rawSnackbar(
            title: 'Export Successful',
            message: 'Your data was exported without problems.',
          );
        }
      } catch (e) {
        // unawaited(analytics.logEvent(name: Events.ExportFail, parameters: {
        //   'reason': e.toString(),
        // }));
        // TODO intl
        Get.rawSnackbar(
          title: 'Export Failed',
          message: 'Something went wrong.\nTry again or contact support if this persists.',
        );
        rethrow;
      }
    };
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
}

class ExportSelections {
  List<CharacterClass> classes = [];
  List<Character> characters = [];
  List<Move> moves = [];
  List<Spell> spells = [];
  List<Item> items = [];

  Map<String, dynamic> toJson() => {
        'classes': classes.map((x) => x.toJson()).toList(),
        'characters': characters.map((x) => x.toJson()).toList(),
        'moves': moves.map((x) => x.toJson()).toList(),
        'spells': spells.map((x) => x.toJson()).toList(),
        'items': items.map((x) => x.toJson()).toList(),
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
    }
    throw TypeError();
  }
}
