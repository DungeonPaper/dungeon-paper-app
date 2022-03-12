import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:get/get.dart';

import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';

class AddRepositoryItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRepositoryItemsController<Move>>(
      () => AddRepositoryItemsController<Move>(),
    );
    //
  }
}
