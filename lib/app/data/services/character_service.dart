import 'dart:async';

import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/core/utils/date_utils.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/character.dart';
import 'loading_service.dart';

class CharacterService extends GetxService with LoadingServiceMixin {
  final all = <String, Character>{}.obs;
  final _current = Rx<String?>(null);

  final _pageController = PageController(initialPage: 1).obs;
  final lastIntPage = 0.obs;
  StreamSubscription? _sub;

  PageController get pageController => _pageController.value;
  double get page => pageController.hasClients && pageController.positions.length == 1
      ? pageController.page ?? 0
      : 0;

  Character? get current => _current.value != null ? all[_current.value] : null;

  List<Character> get allAsList => all.values.toList();

  Map<String, List<Character>> get charsByCategory {
    final out = <String, List<Character>>{};
    for (final char in all.values) {
      out[char.settings.category ?? ''] ??= [];
      out[char.settings.category ?? '']!.add(char);
    }
    for (final key in out.keys) {
      out[key]!.sort((a, b) => (a.settings.sortOrder ?? double.infinity)
          .compareTo(b.settings.sortOrder ?? double.infinity));
    }
    return out;
  }

  void clear() {
    all.clear();
    _current.value = null;
  }

  void setCurrent(String key) {
    if (all.containsKey(key)) {
      _current.value = key;
      updateCharacter(
        current!.copyWith(
          meta: current!.meta.copyWith(
              data: (current!.meta.data ?? CharacterMeta()).copyWith(lastUsed: DateTime.now())),
        ),
      );
    }
  }

  Iterable<Character> get charsByLastUsed {
    final copy = [...all.values];
    copy.sort(dateComparator(order: SortOrder.desc, parse: (char) => char?.meta.data?.lastUsed));
    return copy;
  }

  @override
  void onInit() async {
    super.onInit();
    pageController.addListener(refreshPage);
    await registerCharacterListener();
  }

  Future<void> registerCharacterListener() async {
    _sub?.cancel();
    _sub = StorageHandler.instance.collectionListener('Characters', charsListener);
  }

  void charsListener(List<DocData> json) {
    var list = json.map((c) => Character.fromJson(c));

    all.addAll(Map.fromIterable(list, key: (c) => c.key));
    loadingService.loadingCharacters = false;

    if (all.isNotEmpty && _current.value == null) {
      final hasLastChar = all.values.any((c) => c.meta.data?.lastUsed != null);
      if (hasLastChar) {
        final lastChar = charsByLastUsed.first;
        _current.value = lastChar.key;
      } else {
        _current.value = all.keys.first;
      }
    }
  }

  void refreshPage() {
    _current.refresh();
    _pageController.refresh();
    if (page == page.toInt()) {
      lastIntPage.value = page.toInt();
    }
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  void updateCharacter(Character character, {bool switchToCharacter = false}) {
    // (StorageHandler.instance.delegate as LocalStorageDelegate).storage.collection('Characters');
    all[character.key] = character;
    StorageHandler.instance.update('Characters', character.key, character.toJson());
    if (switchToCharacter || _current.value == null || !all.containsKey(_current.value)) {
      setCurrent(character.key);
    }
    debugPrint('Updated char: ${character.key} (${character.displayName})');
    debugPrint(character.toRawJson());
  }

  void createCharacter(Character character, {bool switchToCharacter = false}) {
    all[character.key] = character;
    StorageHandler.instance.create('Characters', character.key, character.toJson());
    if (switchToCharacter || _current.value == null) {
      _current.value = character.key;
    }
    debugPrint('Created char: ${character.key} (${character.displayName})');
    debugPrint(character.toRawJson());
  }

  void deleteCharacter(Character character) {
    all.remove(character.key);
    StorageHandler.instance.delete('Characters', character.key);
    if (character.key == _current.value) {
      _current.value = all.keys.first;
    }
    debugPrint('Deleted char: ${character.key} (${character.displayName})');
  }

  static CharacterService find() => Get.find();

  @override
  void onClose() {
    pageController.removeListener(refreshPage);
    _sub?.cancel();
  }

  void updateAll(Iterable<Character> chars) {
    for (final char in chars) {
      updateCharacter(char);
    }
  }
}

mixin CharacterServiceMixin {
  CharacterService get characterService => Get.find();
  CharacterService get charService => characterService;

  Character get character => characterService.current!;
  Character? get maybeCharacter => characterService.current;
  Character get char => character;
  Character? get maybeChar => maybeCharacter;
}
