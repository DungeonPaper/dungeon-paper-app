import 'package:dungeon_paper/app/widgets/forms/add_move_form.dart';
import 'package:get/get.dart';

class RepositoryItemFormBinding extends Bindings {
  RepositoryItemFormBinding({required this.item});

  final dynamic item;

  @override
  void dependencies() {
    Get.lazyPut<AddMoveFormController>(
      () => AddMoveFormController(move: item),
    );
  }
}
