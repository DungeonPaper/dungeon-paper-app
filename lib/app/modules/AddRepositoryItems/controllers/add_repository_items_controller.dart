import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/model_utils/model_key.dart';
import 'package:get/get.dart';

class AddRepositoryItemsController<T> extends GetxController {
  final service = Get.find<RepositoryService>();
  final selected = <T>[].obs;

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
}
