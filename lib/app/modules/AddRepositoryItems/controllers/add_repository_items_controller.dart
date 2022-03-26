import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum FiltersGroup {
  playbook,
  my,
  // online,
}

class AddRepositoryItemsController<T, F extends EntityFilters> extends GetxController
    with GetSingleTickerProviderStateMixin {
  final repo = Get.find<RepositoryService>();
  final chars = Get.find<CharacterService>();
  final selected = <T>[].obs;
  final filters = <FiltersGroup, F?>{}.obs;
  final search = <FiltersGroup, TextEditingController>{}.obs;
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    filters.addAll(Get.arguments);
    search[FiltersGroup.playbook] ??= TextEditingController();
    search[FiltersGroup.playbook]!.addListener(_updatePlaybookSearch);
    search[FiltersGroup.my] ??= TextEditingController();
    search[FiltersGroup.my]!.addListener(_updateMySearch);
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    search[FiltersGroup.playbook]!.removeListener(_updatePlaybookSearch);
    search[FiltersGroup.my]!.removeListener(_updateMySearch);
    super.dispose();
  }

  void setFilters(FiltersGroup group, F? filters) {
    this.filters[group] = filters;
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
    FiltersGroup group,
    bool Function(T item, F filters)? filterFn, [
    F? initialFilters,
  ]) =>
      filterFn != null && (filters[group] != null || initialFilters != null)
          ? list.where((x) => filterFn(x, filters[group] ?? initialFilters!))
          : list;

  void _updatePlaybookSearch() {
    filters[FiltersGroup.playbook]?.setSearch(search[FiltersGroup.playbook]!.text);
    selected.refresh();
  }

  void _updateMySearch() {
    filters[FiltersGroup.my]?.setSearch(search[FiltersGroup.my]!.text);
    selected.refresh();
  }
}

abstract class EntityFilters<T> {
  void setSearch(String search);
  bool filter(T item);
}
