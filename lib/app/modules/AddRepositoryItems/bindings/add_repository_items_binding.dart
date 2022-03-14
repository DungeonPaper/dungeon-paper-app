import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:get/get.dart';

import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';

import '../views/add_items_view.dart';
import '../views/add_moves_view.dart';
import '../views/add_spells_view.dart';

class AddRepositoryItemsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRepositoryItemsController<Move, MoveFilters>>(
      () => AddRepositoryItemsController<Move, MoveFilters>(),
    );
    Get.lazyPut<AddRepositoryItemsController<Spell, SpellFilters>>(
      () => AddRepositoryItemsController<Spell, SpellFilters>(),
    );
    Get.lazyPut<AddRepositoryItemsController<Item, ItemFilters>>(
      () => AddRepositoryItemsController<Item, ItemFilters>(),
    );
    //
  }
}
