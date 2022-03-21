import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/entity_filters.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class MoveFiltersView extends StatelessWidget {
  MoveFiltersView({
    Key? key,
    required this.filters,
    required this.onChange,
    required this.searchController,
  }) : super(key: key);

  final MoveFilters filters;
  final repo = Get.find<RepositoryService>();
  final void Function(MoveFilters) onChange;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return EntityFiltersView<Move, MoveFilters>(
      filters: filters,
      onChange: onChange,
      searchController: searchController,
      trailing: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: DropdownButton<MoveCategory?>(
                isExpanded: true,
                value: filters.category,
                items: [
                  DropdownMenuItem<MoveCategory?>(
                    child: Text(S.current.allEntity(S.current.entityPlural(MoveCategory))),
                    value: null,
                  ),
                  ...MoveCategory.values.map(
                    (cat) => DropdownMenuItem<MoveCategory?>(
                      child: Text(
                        ![MoveCategory.advanced1, MoveCategory.advanced2].contains(cat)
                            ? S.current.moveCategory(cat)
                            : S.current.moveCategoryWithLevel(cat),
                      ),
                      value: cat,
                    ),
                  ),
                ],
                onChanged: (cat) => onChange(filters..category = cat),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: DropdownButton<String>(
                isExpanded: true,
                value: filters.classKey,
                items: [
                  DropdownMenuItem<String>(
                    child: Text(S.current.allEntity(S.current.entityPlural(CharacterClass))),
                    value: null,
                  ),
                  ...<CharacterClass>{...repo.builtIn.classes.values, ...repo.my.classes.values}
                      .map(
                    (cls) => DropdownMenuItem<String>(
                      child: Text(cls.name),
                      value: cls.key,
                    ),
                  ),
                ],
                onChanged: (key) => onChange(filters..classKey = key),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MoveFilters extends EntityFilters<Move> {
  MoveCategory? category;
  String? search;
  String? classKey;

  MoveFilters({
    this.category,
    this.search,
    this.classKey,
  });

  @override
  // ignore: avoid_renaming_method_parameters
  bool filter(Move move) {
    if (category != null) {
      if (move.category != category) {
        return false;
      }
    }

    if (search != null && search!.isNotEmpty) {
      if (![
        move.name,
        move.description,
        move.explanation,
        ...move.tags.map((t) => t.name),
        ...move.tags.map((t) => t.value),
      ].any((el) => cleanStr(el).contains(cleanStr(search!)))) {
        return false;
      }
    }

    if (classKey != null) {
      if (!move.classKeys.map(cleanStr).contains(cleanStr(classKey!))) {
        return false;
      }
    }
    return true;
  }

  @override
  void setSearch(String search) {
    this.search = search;
  }
}
