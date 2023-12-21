import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/entity_filters.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

class SpellFiltersView extends StatelessWidget {
  const SpellFiltersView({
    super.key,
    required this.group,
    required this.filters,
    required this.onChange,
    required this.searchController,
  });

  final SpellFilters filters;
  final FiltersGroup group;
  final void Function(SpellFilters) onChange;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.consumer(
      (context, repo, _) => EntityFiltersView<Spell, SpellFilters>(
        filters: filters,
        emptyFilters: SpellFilters(classKey: null, level: null),
        onChange: onChange,
        searchController: searchController,
        typeName: tn(Spell),
        filterWidgetsBuilder: (context, f) => [
          SelectBox<String>(
            label: Text(tr.entityPlural(tn(Spell))),
            value: f.classKey,
            items: [
              DropdownMenuItem<String>(
                value: null,
                child: Text(tr.generic
                    .allEntities(tr.entityPlural(tn(CharacterClass)))),
              ),
              ...<CharacterClass>{
                ...repo.builtIn.classes.values,
                ...repo.my.classes.values
              }.map(
                (cls) => DropdownMenuItem<String>(
                  value: cls.key,
                  child: Text(cls.name),
                ),
              ),
            ],
            onChanged: (key) {
              onChange(f..classKey = key);
              f.controller.add(f);
            },
          ),
        ],
      ),
    );
  }
}

class SpellFilters extends EntityFilters<Spell> {
  String? search;
  String? classKey;
  String? level;

  SpellFilters({
    this.search,
    required this.classKey,
    required this.level,
  });

  @override
  bool filter(Spell spell) {
    if (level != null) {
      if (spell.level != level) {
        return false;
      }
    }

    if (search != null && search!.isNotEmpty) {
      if (![
        spell.name,
        spell.description,
        spell.explanation,
        ...spell.tags.map((t) => t.name),
        ...spell.tags.map((t) => t.value?.toString()),
      ].any((el) => cleanStr(el ?? '').contains(cleanStr(search!)))) {
        return false;
      }
    }

    if (classKey != null) {
      if (!spell.classKeys
          .map((x) => cleanStr(x.key))
          .contains(cleanStr(classKey!))) {
        return false;
      }
    }
    return true;
  }

  @override
  void setSearch(String search) => this.search = search;

  @override
  List<bool?> get filterActiveList => [classKey?.isNotEmpty];

  @override
  double getScore(Spell spell) {
    return avg(
      [
            level == spell.level ? 1.0 : 0.0,
            classKey != null &&
                    spell.classKeys
                        .map((x) => cleanStr(x.key))
                        .contains(cleanStr(classKey!))
                ? 1.0
                : 0.0,
          ] +
          [spell.name, spell.description, spell.explanation]
              .map(
                (e) => (search?.isEmpty ?? true) || e.isEmpty
                    ? 0.0
                    : StringSimilarity.compareTwoStrings(search!, e),
              )
              .toList(),
    );
  }
}
