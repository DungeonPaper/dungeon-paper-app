import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/LibraryList/controllers/library_list_controller.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/entity_filters.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:string_similarity/string_similarity.dart';

class ItemFiltersView extends StatelessWidget {
  ItemFiltersView({
    super.key,
    required this.filters,
    required this.onChange,
    required this.searchController,
  });

  final ItemFilters filters;
  final service = Get.find<RepositoryService>();
  final void Function(ItemFilters) onChange;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return EntityFiltersView<Item, ItemFilters>(
      filters: filters,
      emptyFilters: ItemFilters(),
      onChange: onChange,
      searchController: searchController,
      typeName: tn(Item),
    );
  }
}

class ItemFilters extends EntityFilters<Item> {
  String? search;

  ItemFilters({
    this.search,
  });

  @override
  bool filter(Item item) {
    if (search != null && search!.isNotEmpty) {
      if (![
        item.name,
        item.description,
        ...item.tags.map((t) => t.name),
        ...item.tags.map((t) => t.value?.toString()),
      ].any((el) => cleanStr(el ?? '').contains(cleanStr(search!)))) {
        return false;
      }
    }
    return true;
  }

  @override
  void setSearch(String search) => this.search = search;

  @override
  List<bool?> get filterActiveList => [];

  @override
  double getScore(Item item) {
    return avg(
      [item.name, item.description].map(
        (e) => (search?.isEmpty ?? true) || e.isEmpty
            ? 0.0
            : StringSimilarity.compareTwoStrings(search!, e),
      ),
    );
  }
}
