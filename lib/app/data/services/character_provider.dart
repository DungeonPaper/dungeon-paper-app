import 'dart:async';

import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/core/global_keys.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/core/utils/date_utils.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/character.dart';
import 'loading_service.dart';

class CharacterProvider extends ChangeNotifier
    with LoadingServiceMixin, UserServiceMixin {
  static CharacterProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of(context, listen: listen);

  final all = <String, Character>{};
  String? _currentKey;
  final _pageController = PageController(initialPage: 1, viewportFraction: 1.1);
  StreamSubscription? _sub;

  CharacterProvider() {
    debugPrint('[PROVIDER] initializing character provider');
    registerCharacterListener();
  }

  @override
  void dispose() {
    super.dispose();
    // pageController.removeListener(refreshPage);
    _sub?.cancel();
  }

  PageController get pageController => _pageController;
  double get page =>
      pageController.hasClients && pageController.positions.length == 1
          ? pageController.page ?? 0
          : 0;

  Character? get maybeCurrent => _currentKey != null ? all[_currentKey] : null;
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
    copy.sort(createSortByDate(
        order: SortOrder.desc, parse: (char) => char?.meta.data?.lastUsed));
    return copy;
  }

  Future<void> registerCharacterListener() async {
    _clearCharListener();
    debugPrint('[PROVIDER] registering character listener');
    _sub =
        StorageHandler.instance.collectionListener('Characters', charsListener);
  }

  void clear() {
    all.clear();
    _currentKey = null;
    notifyListeners();
  }

  void setCurrent(String key) {
    if (all.containsKey(key)) {
      _currentKey = key;
      notifyListeners();
      switchToCharacterTheme(current);
      updateCharacter(
        current.copyWith(
          meta: current.meta.copyWith(
              data: (current.meta.data ?? CharacterMeta())
                  .copyWith(lastUsed: DateTime.now())),
        ),
      );
    }
  }

  void switchToCharacterTheme(Character character) =>
      switchToTheme(character.getCurrentTheme(user));

  void switchToTheme(int themeId) {
    if (appGlobalKey.currentContext == null) {
      debugPrint('[PROVIDER] no context, cannot switch theme');
      return;
    }
    final dynamicTheme = DynamicTheme.of(appGlobalKey.currentContext!)!;
    final currentTheme = dynamicTheme.themeId;
    if (currentTheme == themeId) {
      return;
    }

    debugPrint('[PROVIDER] switching to theme $themeId');
    AppThemes.setTheme(themeId);
  }

  void charsListener(List<DocData> json) {
    var list = json.map((c) => Character.fromJson(c));

    all.addAll(Map.fromIterable(list, key: (c) => c.key));

    if (all.isNotEmpty && _currentKey == null) {
      switchToLastUsedChar();
    }

    if (maybeCurrent != null) {
      switchToCharacterTheme(current);
    }

    loadingService.loadingCharacters = false;
    loadingService.afterFirstLoad = !loadingService.loadingUser;
    notifyListeners();
  }

  void switchToLastUsedChar() {
    final hasLastChar = all.values.any((c) => c.meta.data?.lastUsed != null);
    if (hasLastChar) {
      final lastChar = charsByLastUsed.first;
      _currentKey = lastChar.key;
    } else if (all.isNotEmpty) {
      _currentKey = all.keys.first;
    } else {
      _currentKey = null;
    }
    notifyListeners();
  }

  Future<void> updateCharacter(
    Character character, {
    bool switchToCharacter = false,
  }) {
    character = character.copyWithInherited(meta: character.meta.stampUpdate());
    all[character.key] = character;
    notifyListeners();
    if (switchToCharacter ||
        _currentKey == null ||
        !all.containsKey(_currentKey)) {
      setCurrent(character.key);
    }
    debugPrint(
        '[PROVIDER] Updated char: ${character.key} (${character.displayName})');
    debugPrint(character.toRawJson());
    return StorageHandler.instance
        .update('Characters', character.key, character.toJson());
  }

  void createCharacter(Character character, {bool switchToCharacter = false}) {
    all[character.key] = character;
    StorageHandler.instance
        .create('Characters', character.key, character.toJson());
    if (switchToCharacter || _currentKey == null) {
      _currentKey = character.key;
    }
    debugPrint(
        '[PROVIDER] Created char: ${character.key} (${character.displayName})');
    debugPrint(character.toRawJson());
    notifyListeners();
  }

  void deleteCharacter(Character character) {
    all.remove(character.key);
    try {
      StorageHandler.instance.delete('Characters', character.key);
    } catch (e) {
      debugPrint('[PROVIDER] Error deleting character: $e');
    }
    if (character.key == _currentKey) {
      _currentKey = all.keys.first;
    }
    debugPrint(
        '[PROVIDER] Deleted char: ${character.key} (${character.displayName})');
    notifyListeners();
  }

  void updateAll(Iterable<Character> chars) {
    for (final char in chars) {
      updateCharacter(char);
    }
  }

  void _clearCharListener() {
    debugPrint('[PROVIDER] clearing char listener');
    _sub?.cancel();
    _sub = null;
  }
}

mixin CharacterProviderMixin {
  CharacterProvider get characterProvider =>
      CharacterProvider.of(appGlobalKey.currentContext!);
  CharacterProvider get charProvider => characterProvider;

  Character get character => characterProvider.current;
  Character? get maybeCharacter => characterProvider.maybeCurrent;
  Character get char => character;
  Character? get maybeChar => maybeCharacter;
}

