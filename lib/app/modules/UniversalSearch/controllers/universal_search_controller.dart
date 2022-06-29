import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/app/model_utils/model_search.dart';
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

  List get results {
    if (search.text.trim().isEmpty) {
      return [];
    }
    final entries = sources.entries;
    final map = enumerate(entries).map((e) {
      final flatten2 = flatten(e.value.value);
      final where = flatten2.where((e) => searchFor(e.runtimeType, e, search.text));
      final uniqueBy = where.uniqueBy((e) => keyFor(e));
      if (uniqueBy.isEmpty) {
        return [];
      }
      return e.index < entries.length
          ? [SearchSeparator(S.current.entityPlural(uniqueBy.first.runtimeType)), ...uniqueBy]
          : uniqueBy;
    });
    return map.toList();
  }

  List get flatResults => results.fold(<dynamic>[], (all, current) => all + current);

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
