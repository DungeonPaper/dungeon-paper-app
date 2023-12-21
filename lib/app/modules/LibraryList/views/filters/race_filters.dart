import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/entity_filters.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

class RaceFiltersView extends StatelessWidget {
  const RaceFiltersView({
    super.key,
    required this.filters,
    required this.group,
    required this.onChange,
    required this.searchController,
  });

  final RaceFilters filters;
  final FiltersGroup group;
  final void Function(RaceFilters) onChange;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.consumer(
      (context, repo, _) => EntityFiltersView<Race, RaceFilters>(
        filters: filters,
        emptyFilters: RaceFilters(classKey: null),
        onChange: onChange,
        searchController: searchController,
        typeName: tn(Race),
        filterWidgetsBuilder: (context, f) => [
          SelectBox<String>(
            label: Text(tr.entityPlural(tn(CharacterClass))),
            isExpanded: true,
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

class RaceFilters extends EntityFilters<Race> {
  String? search;
  String? classKey;

  RaceFilters({
    this.search,
    required this.classKey,
  });

  @override
  bool filter(Race race) {
    if (search != null && search!.isNotEmpty) {
      if (![
        race.name,
        race.description,
        race.explanation,
        ...race.tags.map((t) => t.name),
        ...race.tags.map((t) => t.value?.toString()),
      ].any((el) => cleanStr(el ?? '').contains(cleanStr(search!)))) {
        return false;
      }
    }

    if (classKey != null) {
      if (!race.classKeys
          .map((x) => cleanStr(x.key))
          .contains(cleanStr(classKey!))) {
        return false;
      }
    }
    return true;
  }

  @override
  void setSearch(String search) {
    this.search = search;
  }

  @override
  List<bool?> get filterActiveList => [classKey?.isNotEmpty];

  @override
  double getScore(Race race) {
    return avg(
      [
            classKey != null &&
                    race.classKeys
                        .map((x) => cleanStr(x.key))
                        .contains(cleanStr(classKey!))
                ? 1.0
                : 0.0,
          ] +
          [race.name, race.description, race.explanation]
              .map(
                (e) => (search?.isEmpty ?? true) || e.isEmpty
                    ? 0.0
                    : StringSimilarity.compareTwoStrings(search!, e),
              )
              .toList(),
    );
  }
}
