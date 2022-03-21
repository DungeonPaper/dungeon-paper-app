import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/widgets/forms/add_move_form.dart';
import 'package:get/get.dart';

import 'package:dungeon_paper/app/modules/AddRepositoryItems/controllers/add_repository_items_controller.dart';

import '../views/filters/item_filters.dart';
import '../views/filters/move_filters.dart';
import '../views/filters/spell_filters.dart';

class RepositoryItemFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddMoveFormController>(
      () => AddMoveFormController(),
    );
  }
}
