import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';
import 'package:dungeon_paper/app/modules/AddRepositoryItems/views/entity_filters.dart';
import 'package:dungeon_paper/core/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemFiltersView extends StatelessWidget {
  ItemFiltersView({
    Key? key,
    required this.filters,
    required this.onChange,
    required this.searchController,
  }) : super(key: key);

  final ItemFilters filters;
  final service = Get.find<RepositoryService>();
  final void Function(ItemFilters) onChange;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return EntityFiltersView<Item, ItemFilters>(
      filters: filters,
      onChange: onChange,
      searchController: searchController,
    );
  }
}

class ItemFilters extends EntityFilters<Item> {
  String? search;

  ItemFilters({
    this.search,
  });

  @override
  // ignore: avoid_renaming_method_parameters
  bool filter(Item spell) {
    if (search != null && search!.isNotEmpty) {
      if (![
        spell.name,
        spell.description,
        ...spell.tags.map((t) => t.name),
        ...spell.tags.map((t) => t.value),
      ].any((el) => cleanStr(el ?? '').contains(cleanStr(search!)))) {
        return false;
      }
    }
    return true;
  }

  @override
  void setSearch(String search) => this.search = search;
}
