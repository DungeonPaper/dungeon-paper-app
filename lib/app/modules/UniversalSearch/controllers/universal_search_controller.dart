import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/note.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/model_utils/model_search.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/character_class_filters.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/item_filters.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/move_filters.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/note_filters.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/filters/spell_filters.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UniversalSearchController extends GetxController
    with RepositoryServiceMixin, CharacterServiceMixin {
  final _search = TextEditingController(text: '').obs;

  TextEditingController get search => _search.value;

  Map<Type, List<List>> get sources => {
        Move: [
          char.moves,
          repo.my.moves.values.toList(),
          repo.builtIn.moves.values.toList(),
        ],
        Spell: [
          char.spells,
          repo.my.spells.values.toList(),
          repo.builtIn.spells.values.toList(),
        ],
        Item: [
          char.items,
          repo.my.items.values.toList(),
          repo.builtIn.items.values.toList(),
        ],
        CharacterClass: [
          repo.my.classes.values.toList(),
          repo.builtIn.classes.values.toList(),
        ],
      };

  @override
  void onInit() {
    super.onInit();
    search.addListener(_update);
  }

  List<T> getSource<T>() => flatten(sources[T] as List<List<T>>);

  List<T> flatten<T>(List<List<T>> list) => list.fold(<T>[], (all, current) => all + current);

  Future<List<List>> get results {
    if (search.text.trim().isEmpty) {
      return Future.value([]);
    }
    final entries = sources.entries;
    final map = enumerate(entries).map((e) {
      final list = flatten(e.value.value)
          .where((e) => searchFor(e.runtimeType, e, search.text))
          .uniqueBy((e) => keyFor(e));

      if (list.isEmpty) {
        return [];
      }

      final sorters = {
        Move: (a, b) => MoveFilters(search: search.text, classKey: null).sortByScore(a, b),
        Spell: (a, b) =>
            SpellFilters(search: search.text, classKey: null, level: null).sortByScore(a, b),
        Item: (a, b) => ItemFilters(search: search.text).sortByScore(a, b),
        CharacterClass: (a, b) => CharacterClassFilters(search: search.text).sortByScore(a, b),
      };

      list.sort(
        (a, b) => sorters[a.runtimeType]!(a, b),
      );

      return e.index < entries.length
          ? [SearchSeparator(S.current.entityPlural(list.first.runtimeType)), ...list]
          : list;
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
