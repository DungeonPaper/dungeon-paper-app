import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddRepositoryItemsController<T, F extends EntityFilters> extends GetxController
    with GetSingleTickerProviderStateMixin {
  final repo = Get.find<RepositoryService>();
  final chars = Get.find<CharacterService>();
  final selected = <T>[].obs;
  final filters = Rx<F?>(null);
  final search = TextEditingController();
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    filters.value = Get.arguments;
    search.addListener(_updateSearch);
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    search.removeListener(_updateSearch);
    super.dispose();
  }

  void setFilters(F? filters) {
    this.filters.value = filters;
    this.filters.refresh();
  }

  void toggle(T item, bool state) {
    if (state) {
      selected.addIf(
          selected.firstWhereOrNull((element) => keyFor(element) == keyFor(item)) == null, item);
    } else {
      selected.removeWhere((element) => keyFor(element) == keyFor(item));
    }
  }

  bool isSelected(T item) =>
      selected.firstWhereOrNull((element) => keyFor(element) == keyFor(item)) != null;

  bool isSelectable(T item, Iterable<T> selections) =>
      selections.toList().firstWhereOrNull((element) => keyFor(element) == keyFor(item)) == null;

  Iterable<T> filterList(
    Iterable<T> list,
    bool Function(T item, F filters)? filterFn, [
    F? initialFilters,
  ]) =>
      filterFn != null && (filters.value != null || initialFilters != null)
          ? list.where((x) => filterFn(x, filters.value ?? initialFilters!))
          : list;

  void _updateSearch() {
    debugPrint('Updating search ${search.text}');
    filters.value?.setSearch(search.text);
    selected.refresh();
  }
}

abstract class EntityFilters<T> {
  void setSearch(String search);
  bool filter(T item);
}
