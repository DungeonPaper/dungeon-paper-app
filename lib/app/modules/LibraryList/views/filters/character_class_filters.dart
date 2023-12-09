import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/entity_filters.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:string_similarity/string_similarity.dart';

class CharacterClassFiltersView extends StatelessWidget {
  CharacterClassFiltersView({
    super.key,
    required this.filters,
    required this.group,
    required this.onChange,
    required this.searchController,
  });

  final CharacterClassFilters filters;
  final FiltersGroup group;
  final repo = Get.find<RepositoryService>();
  final void Function(CharacterClassFilters) onChange;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return EntityFiltersView<CharacterClass, CharacterClassFilters>(
      filters: filters,
      typeName: tn(CharacterClass),
      emptyFilters: CharacterClassFilters(),
      onChange: onChange,
      searchController: searchController,
      filterWidgetsBuilder: (context, f) => [],
    );
  }
}

class CharacterClassFilters extends EntityFilters<CharacterClass> {
  String? search;
  String? classKey;

  CharacterClassFilters({
    this.search,
  });

  @override
  bool filter(CharacterClass cls) {
    if (search != null && search!.isNotEmpty) {
      if (![
        cls.name,
        cls.description,
      ].any((el) => cleanStr(el).contains(cleanStr(search!)))) {
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
  List<bool?> get filterActiveList => [];

  @override
  double getScore(CharacterClass cls) {
    return avg(
      [cls.name, cls.description].map(
        (e) => (search?.isEmpty ?? true) || e.isEmpty
            ? 0.0
            : StringSimilarity.compareTwoStrings(search!, e),
      ),
    );
  }
}
