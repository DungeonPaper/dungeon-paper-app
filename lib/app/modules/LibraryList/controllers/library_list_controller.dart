import 'dart:async';

import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/data/services/library_provider.dart';
import 'package:dungeon_paper/app/data/services/repository_provider.dart';
import 'package:dungeon_paper/core/global_keys.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';

enum FiltersGroup {
  playbook,
  my,
  // online,
}

class LibraryListController<T extends WithMeta, F extends EntityFilters<T>>
    extends ChangeNotifier
    with CharacterProviderMixin, RepositoryProviderMixin {
  final LibraryListArguments<T, F> arguments;

  final selected = <T>[];
  final removed = <T>[];
  final filters = <FiltersGroup, F?>{};
  final search = <FiltersGroup, TextEditingController>{};
  late final TabController tabController;

  bool get selectable => arguments.onSelected != null;

  Iterable<T> get builtInList => filterList(builtInListRaw,
      FiltersGroup.playbook, arguments.filterFn, arguments.sortFn);

  Iterable<T> get builtInListRaw =>
      repo.builtIn.listByType<T>().values.toList();

  Iterable<T> get myList => filterList(
      myListRaw, FiltersGroup.my, arguments.filterFn, arguments.sortFn);

  Iterable<T> get myListRaw => repo.my.listByType<T>().values.toList();
  String get storageKey => Meta.storageKeyFor(T);

  bool get multiple => arguments.multiple;
  Map<String, dynamic> get extraData => arguments.extraData;
  void Function(Iterable<T> items)? get onSelected => arguments.onSelected;

  LibraryListController(
      {required this.arguments, required TickerProvider vsync}) {
    filters.addAll(arguments.filters.cast<FiltersGroup, F?>());
    search[FiltersGroup.playbook] ??= TextEditingController();
    search[FiltersGroup.playbook]!.addListener(_updatePlaybookSearch);
    search[FiltersGroup.my] ??= TextEditingController();
    search[FiltersGroup.my]!.addListener(_updateMySearch);
    tabController = TabController(
      initialIndex: FiltersGroup.values.indexOf(arguments.initialTab),
      // length: 3,
      length: 2,
      vsync: vsync,
    );
  }

  @override
  void dispose() {
    search[FiltersGroup.playbook]!.removeListener(_updatePlaybookSearch);
    search[FiltersGroup.my]!.removeListener(_updateMySearch);
    super.dispose();
  }

  void setFilters(FiltersGroup group, F? filters) {
    this.filters[group] = filters;
    notifyListeners();
  }

  void toggleItem(T item, bool state) {
    if (!selectable) {
      return;
    }

    if (!arguments.multiple) {
      selected.clear();
      for (final sel in arguments.preSelections) {
        if (removed.firstWhereOrNull(_compare(sel)) == null) {
          removed.add(sel);
        }
      }
    }

    if (state) {
      if (selected.firstWhereOrNull(_compare(item)) == null) {
        selected.add(item);
      }
      removed.removeWhere(_compare(item));
    } else {
      selected.removeWhere(_compare(item));
      if (removed.firstWhereOrNull(_compare(item)) == null) {
        removed.add(item);
      }
    }
    notifyListeners();
  }

  _compare(T item) {
    return (T element) {
      return (element.meta.sharing?.sourceKey ?? element.key) == item.key ||
          element.key == item.key;
    };
  }

  void saveCustomItem(String storageKey, T item) {
    toggleItem(item, true);
    debugPrint('Saving $item');
    final library = LibraryProvider.of(appGlobalKey.currentContext!);
    library.upsertToLibrary<T>([item]);
    notifyListeners();
  }

  void deleteCustomItem(String storageKey, T item) {
    toggleItem(item, false);
    debugPrint('Deleting $item');
    final library = LibraryProvider.of(appGlobalKey.currentContext!);
    library.removeFromLibrary<T>([item]);
    notifyListeners();
  }

  List<T> get selectedWithMeta => selected;
  // selected.map((e) => forkMeta<T>(e, Get.find<UserService>().current)).toList();

  bool isSelected(T item) => arguments.multiple
      ?
      // multiple: if is selected or pre-selected
      isInCurrentSelectedList(item) || isPreSelected(item)
      :
      // single: if is pre-selected, then only if it was not removed,
      //         if not pre-selected, then only if nothing else is selected
      (isPreSelected(item) && !isRemoved(item)) ||
          isInCurrentSelectedList(item);

  bool isInCurrentSelectedList(T item) =>
      selected.firstWhereOrNull((element) =>
          [element.meta.sharing?.sourceKey, element.key].contains(item.key)) !=
      null;

  bool isRemoved(T item) => removed.firstWhereOrNull(_compare(item)) != null;

  bool isPreSelected(T item) =>
      arguments.preSelections.toList().firstWhereOrNull(_compare(item)) != null;

  bool isEnabled(T item) => arguments.multiple
      ?
      // multiple: if is not pre-selected
      !isPreSelected(item)
      : true;
  // single: if is pre-selected or nothing is selected
  // isPreSelected(item, preSelections, multiple) ||
  //     (preSelections.isEmpty || isRemoved(preSelections.first));

  Iterable<T> filterList(
    Iterable<T> list,
    FiltersGroup group,
    bool Function(T item, F filters)? filterFn, [
    int Function(T a, T b) Function(F filters)? sortFn,
    F? initialFilters,
  ]) {
    final filtered =
        filterFn != null && (filters[group] != null || initialFilters != null)
            ? list
                .where((x) => filterFn(x, filters[group] ?? initialFilters!))
                .toList()
            : list.toList();
    return sortFn != null
        ? (filtered..sort(sortFn(filters[group] ?? initialFilters!)))
        : filtered;
  }

  void _updatePlaybookSearch() {
    filters[FiltersGroup.playbook]
        ?.setSearch(search[FiltersGroup.playbook]!.text);
    notifyListeners();
  }

  void _updateMySearch() {
    filters[FiltersGroup.my]?.setSearch(search[FiltersGroup.my]!.text);
    notifyListeners();
  }
}

abstract class EntityFilters<T> {
  void setSearch(String search);
  bool filter(T item);
  double getScore(T item);

  final controller = StreamController<EntityFilters<T>>.broadcast();

  Stream get onChanged => controller.stream;

  List<bool?> get filterActiveList;

  int get activeFilterCount =>
      filterActiveList.where((element) => element == true).length;

  int get totalFilterCount => filterActiveList.length;

  bool get isEmpty => activeFilterCount == 0;
  bool get isNotEmpty => !isEmpty;

  int sortByScore(T a, T b) => getScore(b).compareTo(getScore(a));
}

abstract class LibraryListArguments<T extends WithMeta,
    F extends EntityFilters<T>> {
  final Map<FiltersGroup, F?> filters;

  final void Function(Iterable<T> items)? onSelected;
  final bool Function(T item, F filters) filterFn;
  final int Function(T a, T b) Function(F filters) sortFn;
  final bool multiple;
  final Iterable<T> preSelections;
  final Map<String, dynamic> extraData;
  final FiltersGroup initialTab;

  LibraryListArguments({
    required this.filters,
    required this.onSelected,
    required this.filterFn,
    required this.sortFn,
    this.multiple = true,
    required this.preSelections,
    required this.extraData,
    FiltersGroup? initialTab = FiltersGroup.playbook,
  }) : initialTab = initialTab ?? FiltersGroup.playbook;
}
