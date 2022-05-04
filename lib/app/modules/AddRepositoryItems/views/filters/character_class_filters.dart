import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/entity_filters.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CharacterClassFiltersView extends StatelessWidget {
  CharacterClassFiltersView({
    Key? key,
    required this.filters,
    required this.group,
    required this.onChange,
    required this.searchController,
  }) : super(key: key);

  final CharacterClassFilters filters;
  final FiltersGroup group;
  final repo = Get.find<RepositoryService>();
  final void Function(CharacterClassFilters) onChange;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return EntityFiltersView<CharacterClass, CharacterClassFilters>(
      filters: filters,
      onChange: onChange,
      searchController: searchController,
      filterWidgetsBuilder: (context, f) => [
        // SelectBox<CharacterClassCategory?>(
        //   isExpanded: true,
        //   label: Text(S.current.entityPlural(CharacterClassCategory)),
        //   value: f.category,
        //   items: [
        //     DropdownMenuItem<CharacterClassCategory?>(
        //       child: Text(S.current.allGeneric(S.current.entityPlural(CharacterClassCategory))),
        //       value: null,
        //     ),
        //     ...CharacterClassCategory.values.map(
        //       (cat) => DropdownMenuItem<CharacterClassCategory?>(
        //         child: Text(
        //           ![CharacterClassCategory.advanced1, CharacterClassCategory.advanced2].contains(cat)
        //               ? S.current.moveCategory(cat)
        //               : S.current.moveCategoryWithLevel(cat),
        //         ),
        //         value: cat,
        //       ),
        //     ),
        //   ],
        //   onChanged: (cat) {
        //     onChange(f..category = cat);
        //     f.controller.add(f);
        //   },
        // ),
        // SelectBox<String>(
        //   label: Text(S.current.entityPlural(CharacterClass)),
        //   isExpanded: true,
        //   value: f.classKey,
        //   items: [
        //     DropdownMenuItem<String>(
        //       child: Text(S.current.allGeneric(S.current.entityPlural(CharacterClass))),
        //       value: null,
        //     ),
        //     ...<CharacterClass>{...repo.builtIn.classes.values, ...repo.my.classes.values}.map(
        //       (cls) => DropdownMenuItem<String>(
        //         child: Text(cls.name),
        //         value: cls.key,
        //       ),
        //     ),
        //   ],
        //   onChanged: (key) {
        //     onChange(f..classKey = key);
        //     f.controller.add(f);
        //   },
        // ),
      ],
    );
  }
}

class CharacterClassFilters extends EntityFilters<CharacterClass> {
  // CharacterClassCategory? category;
  String? search;
  String? classKey;

  CharacterClassFilters({
    // this.category,
    this.search,
    this.classKey,
  });

  @override
  // ignore: avoid_renaming_method_parameters
  bool filter(CharacterClass cls) {
    // if (category != null) {
    //   if (cls.category != category) {
    //     return false;
    //   }
    // }

    if (search != null && search!.isNotEmpty) {
      if (![
        cls.name,
        cls.description,
        // cls.explanation,
        // ...cls.tags.map((t) => t.name),
        // ...cls.tags.map((t) => t.value),
      ].any((el) => cleanStr(el).contains(cleanStr(search!)))) {
        return false;
      }
    }

    // if (classKey != null) {
    //   // // if (![CharacterClassCategory.basic, CharacterClassCategory.special].contains(category) &&
    //       !cls.classKeys.map(cleanStr).contains(cleanStr(classKey!))) {
    //     return false;
    //   }
    // }
    return true;
  }

  @override
  void setSearch(String search) {
    this.search = search;
  }

  @override
  List<bool?> get filterActiveList => [];
}
