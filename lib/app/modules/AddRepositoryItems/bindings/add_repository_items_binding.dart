import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:get/get.dart';

import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';

class AddRepositoryItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRepositoryItemsController<Move>>(
      () => AddRepositoryItemsController<Move>(),
    );
    Get.lazyPut<AddRepositoryItemsController<Spell>>(
      () => AddRepositoryItemsController<Spell>(),
    );
    Get.lazyPut<AddRepositoryItemsController<Item>>(
      () => AddRepositoryItemsController<Item>(),
    );
    //
  }
}
