import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_search.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/character_class_filters.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/item_filters.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/move_filters.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/race_filters.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/spell_filters.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum SourceType {
  character,
  myLibrary,
  builtInLibrary,
}

class UniversalSearchController extends GetxController
    with RepositoryServiceMixin, CharacterServiceMixin {
  final _search = TextEditingController(text: '').obs;

  TextEditingController get search => _search.value;

  bool get hasCharacter => charService.all.isNotEmpty;

  final enabledSources =
      <SourceType>{SourceType.character, SourceType.myLibrary, SourceType.builtInLibrary}.obs;

  Map<Type, List<Iterable>> get sources => {
        Move: <Iterable<Move>>[
          sourceEnabled(SourceType.character) ? charService.maybeCurrent?.moves ?? [] : [],
          sourceEnabled(SourceType.myLibrary) ? repo.my.moves.values : [],
          sourceEnabled(SourceType.builtInLibrary) ? repo.builtIn.moves.values : [],
        ],
        Spell: <Iterable<Spell>>[
          sourceEnabled(SourceType.character) ? charService.maybeCurrent?.spells ?? [] : [],
          sourceEnabled(SourceType.myLibrary) ? repo.my.spells.values : [],
          sourceEnabled(SourceType.builtInLibrary) ? repo.builtIn.spells.values : [],
        ],
        Item: <Iterable<Item>>[
          sourceEnabled(SourceType.character) ? charService.maybeCurrent?.items ?? [] : [],
          sourceEnabled(SourceType.myLibrary) ? repo.my.items.values : [],
          sourceEnabled(SourceType.builtInLibrary) ? repo.builtIn.items.values : [],
        ],
        CharacterClass: <Iterable<CharacterClass>>[
          sourceEnabled(SourceType.myLibrary) ? repo.my.classes.values : [],
          sourceEnabled(SourceType.builtInLibrary) ? repo.builtIn.classes.values : [],
        ],
        Race: <Iterable<Race>>[
          sourceEnabled(SourceType.myLibrary) ? repo.my.races.values : [],
          sourceEnabled(SourceType.builtInLibrary) ? repo.builtIn.races.values : [],
        ],
      };

  void toggleSource(SourceType type, [bool? value]) {
    final _value = value ?? !sourceEnabled(type);
    if (_value) {
      enabledSources.add(type);
    } else {
      enabledSources.remove(type);
    }
  }

  bool sourceEnabled(SourceType type) => enabledSources.contains(type);

  @override
  void onInit() {
    super.onInit();
    search.addListener(_update);
  }

  List<T> getSource<T>() => flatten(sources[T] as List<List<T>>);

  List<T> flatten<T>(List<Iterable<T>> list) =>
      list.fold(<T>[], (all, current) => all..addAll(current));

  Future<List<List>> get results async {
    if (search.text.trim().isEmpty) {
      return Future.value([]);
    }
    final entries = sources.entries;
    final map = enumerate(entries).map((e) {
      final list = flatten(e.value.value)
          .where((e) => searchFor(e.runtimeType, e, search.text))
          .uniqueBy((e) => e.key);

      if (list.isEmpty) {
        return [];
      }

      final sorters = {
        Move: (a, b) => MoveFilters(search: search.text, classKey: null).sortByScore(a, b),
        Spell: (a, b) =>
            SpellFilters(search: search.text, classKey: null, level: null).sortByScore(a, b),
        Item: (a, b) => ItemFilters(search: search.text).sortByScore(a, b),
        CharacterClass: (a, b) => CharacterClassFilters(search: search.text).sortByScore(a, b),
        Race: (a, b) => RaceFilters(search: search.text, classKey: null).sortByScore(a, b),
      };

      list.sort(
        (a, b) => sorters[a.runtimeType]!(a, b),
      );

      final result = e.index < entries.length
          ? [SearchSeparator(S.current.entityPlural(list.first.runtimeType)), ...list]
          : list;
      debugPrint('result for ${e.value.runtimeType}: $result');
      return result;
    });

    return Future.value(map.toList());
  }

  Future<List> get flatResults async {
    final res = await results;
    return res.fold<List<dynamic>>(<dynamic>[], (all, current) => all + current);
  }

  @override
  void onClose() {
    super.onClose();
    search.removeListener(_update);
  }

  void _update() {
    _search.refresh();
  }
}

class SearchSeparator {
  final String text;

  SearchSeparator(this.text);
}
