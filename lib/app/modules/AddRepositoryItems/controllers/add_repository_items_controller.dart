import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:get/get.dart';

class AddRepositoryItemsController<T, F> extends GetxController {
  final repo = Get.find<RepositoryService>();
  final chars = Get.find<CharacterService>();
  final selected = <T>[].obs;
  final filters = Rx<F?>(null);

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

  Iterable<T> filterList(
    Iterable<T> list,
    bool Function(T item, F filters)? filterFn, [
    F? initialFilters,
  ]) =>
      filterFn != null && (filters.value != null || initialFilters != null)
          ? list.where((x) => filterFn(x, filters.value ?? initialFilters!))
          : list;
}
