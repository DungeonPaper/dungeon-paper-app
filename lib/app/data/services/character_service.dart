import 'dart:async';

import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/core/utils/date_utils.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/character.dart';
import 'loading_service.dart';

class CharacterService extends GetxService with LoadingServiceMixin, UserServiceMixin {
  static CharacterService find() => Get.find();

  final all = <String, Character>{}.obs;
  final _currentKey = Rx<String?>(null);
  final _pageController = PageController(initialPage: 1, viewportFraction: 1.1);
  StreamSubscription? _sub;

  @override
  void onInit() async {
    super.onInit();
    // pageController.addListener(refreshPage);
    await registerCharacterListener();
  }

  @override
  void onClose() {
    // pageController.removeListener(refreshPage);
    _sub?.cancel();
  }

  PageController get pageController => _pageController;
  double get page => pageController.hasClients && pageController.positions.length == 1
      ? pageController.page ?? 0
      : 0;

  Character? get maybeCurrent => _currentKey.value != null ? all[_currentKey.value] : null;
  Character get current => maybeCurrent!;

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

  Iterable<Character> get charsByLastUsed {
    final copy = [...all.values];
    copy.sort(createSortByDate(order: SortOrder.desc, parse: (char) => char?.meta.data?.lastUsed));
    return copy;
  }

  Future<void> registerCharacterListener() async {
    _clearCharListener();
    debugPrint('registering character listener');
    _sub = StorageHandler.instance.collectionListener('Characters', charsListener);
  }

  void clear() {
    all.clear();
    _currentKey.value = null;
  }

  void setCurrent(String key) {
    if (all.containsKey(key)) {
      _currentKey.value = key;
      switchToCharacterTheme(current);
      updateCharacter(
        current.copyWith(
          meta: current.meta.copyWith(
              data: (current.meta.data ?? CharacterMeta()).copyWith(lastUsed: DateTime.now())),
        ),
      );
    }
  }

  void switchToCharacterTheme(Character character) {
    final dynamicTheme = DynamicTheme.of(Get.context!)!;
    final currentTheme = dynamicTheme.themeId;
    final newTheme = character.getCurrentTheme(user);
    if (currentTheme == newTheme) {
      return;
    }

    debugPrint('switching to theme ${character.getCurrentTheme(user)}');

    AppThemes.setTheme(newTheme);
  }

  void charsListener(List<DocData> json) {
    var list = json.map((c) => Character.fromJson(c));

    all.addAll(Map.fromIterable(list, key: (c) => c.key));

    if (all.isNotEmpty && _currentKey.value == null) {
      switchToLastUsedChar();
    }

    if (_currentKey.value != null) {
      switchToCharacterTheme(current);
    }

    loadingService.loadingCharacters = false;
    loadingService.afterFirstLoad = !loadingService.loadingUser;
  }

  void switchToLastUsedChar() {
    final hasLastChar = all.values.any((c) => c.meta.data?.lastUsed != null);
    if (hasLastChar) {
      final lastChar = charsByLastUsed.first;
      _currentKey.value = lastChar.key;
    } else {
      _currentKey.value = all.keys.first;
    }
  }

  Future<void> updateCharacter(Character character, {bool switchToCharacter = false}) {
    // (StorageHandler.instance.delegate as LocalStorageDelegate).storage.collection('Characters');
    character = character.copyWithInherited(meta: character.meta.stampUpdate());
    all[character.key] = character;
    if (switchToCharacter || _currentKey.value == null || !all.containsKey(_currentKey.value)) {
      setCurrent(character.key);
    }
    debugPrint('Updated char: ${character.key} (${character.displayName})');
    debugPrint(character.toRawJson());
    return StorageHandler.instance.update('Characters', character.key, character.toJson());
  }

  void createCharacter(Character character, {bool switchToCharacter = false}) {
    all[character.key] = character;
    StorageHandler.instance.create('Characters', character.key, character.toJson());
    if (switchToCharacter || _currentKey.value == null) {
      _currentKey.value = character.key;
    }
    debugPrint('Created char: ${character.key} (${character.displayName})');
    debugPrint(character.toRawJson());
  }

  void deleteCharacter(Character character) {
    all.remove(character.key);
    StorageHandler.instance.delete('Characters', character.key);
    if (character.key == _currentKey.value) {
      _currentKey.value = all.keys.first;
    }
    debugPrint('Deleted char: ${character.key} (${character.displayName})');
  }

  void updateAll(Iterable<Character> chars) {
    for (final char in chars) {
      updateCharacter(char);
    }
  }

  void _clearCharListener() {
    debugPrint('clearing char listener');
    _sub?.cancel();
    _sub = null;
  }
}

mixin CharacterServiceMixin {
  CharacterService get characterService => Get.find();
  CharacterService get charService => characterService;

  Character get character => characterService.current;
  Character? get maybeCharacter => characterService.maybeCurrent;
  Character get char => character;
  Character? get maybeChar => maybeCharacter;
}
