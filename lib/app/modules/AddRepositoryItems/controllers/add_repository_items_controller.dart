import 'dart:async';

import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_json.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum FiltersGroup {
  playbook,
  my,
  // online,
}

class AddRepositoryItemsController<T, F extends EntityFilters> extends GetxController
    with GetSingleTickerProviderStateMixin {
  final repo = Get.find<RepositoryService>().obs;
  final chars = Get.find<CharacterService>().obs;
  final selected = <T>[].obs;
  final removed = <T>[].obs;
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

  void toggleItem(T item, bool state, Iterable<T> preSelections, bool multiple) {
    if (!multiple) {
      selected.clear();
      for (final sel in preSelections) {
        removed.addIf(
          removed.firstWhereOrNull((element) => keyFor(element) == keyFor(sel)) == null,
          sel,
        );
      }
    }

    if (state) {
      selected.addIf(
        selected.firstWhereOrNull((element) => keyFor(element) == keyFor(item)) == null,
        item,
      );
      removed.removeWhere((element) => keyFor(element) == keyFor(item));
    } else {
      selected.removeWhere((element) => keyFor(element) == keyFor(item));
      removed.addIf(
        removed.firstWhereOrNull((element) => keyFor(element) == keyFor(item)) == null,
        item,
      );
    }
  }

  void saveCustomItem(String storageKey, T item, Iterable<T> preSelections, bool multiple) {
    toggleItem(item, true, preSelections, multiple);
    debugPrint('Saving $item');
    StorageHandler.instance.create(storageKey, keyFor(item), toJsonFor(item));
  }

  void deleteCustomItem(String storageKey, T item, Iterable<T> preSelections, bool multiple) {
    toggleItem(item, false, preSelections, multiple);
    debugPrint('Deleting $item');
    StorageHandler.instance.delete(storageKey, keyFor(item));
  }

  bool isSelected(T item, Iterable<T> preSelections, bool multiple) => multiple
      ?
      // multiple: if is selected or pre-selected
      isInCurrentSelectedList(item) || isPreSelected(item, preSelections, multiple)
      :
      // single: if is pre-selected, then only if it was not removed,
      //         if not pre-selected, then only if nothing else is selected
      (isPreSelected(item, preSelections, multiple) && !isRemoved(item)) ||
          isInCurrentSelectedList(item);

  bool isInCurrentSelectedList(T item) =>
      selected.firstWhereOrNull((element) => keyFor(element) == keyFor(item)) != null;

  bool isRemoved(T item) =>
      removed.firstWhereOrNull((element) => keyFor(element) == keyFor(item)) != null;

  bool isPreSelected(T item, Iterable<T> preSelections, bool multiple) =>
      preSelections.toList().firstWhereOrNull((element) => keyFor(element) == keyFor(item)) != null;

  bool isEnabled(T item, Iterable<T> preSelections, bool multiple) => multiple
      ?
      // multiple: if is not pre-selected
      !isPreSelected(item, preSelections, multiple)
      : true;
  // single: if is pre-selected or nothing is selected
  // isPreSelected(item, preSelections, multiple) ||
  //     (preSelections.isEmpty || isRemoved(preSelections.first));

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
    search.refresh();
    repo.refresh();
  }

  void _updateMySearch() {
    filters[FiltersGroup.my]?.setSearch(search[FiltersGroup.my]!.text);
    search.refresh();
    repo.refresh();
  }
}

abstract class EntityFilters<T> {
  void setSearch(String search);
  bool filter(T item);

  final controller = StreamController<EntityFilters<T>>.broadcast();

  Stream get onChanged => controller.stream;

  List<bool?> get filterActiveList;

  int get activeFilterCount => filterActiveList.where((element) => element == true).length;

  int get totalFilterCount => filterActiveList.length;
}
