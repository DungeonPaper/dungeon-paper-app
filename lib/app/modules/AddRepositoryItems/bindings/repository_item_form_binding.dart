import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/widgets/forms/add_item_form.dart';
import 'package:dungeon_paper/app/widgets/forms/add_move_form.dart';
import 'package:dungeon_paper/app/widgets/forms/add_spell_form.dart';
import 'package:get/get.dart';

class RepositoryItemFormBinding extends Bindings {
  RepositoryItemFormBinding({
    required this.item,
    this.extraData = const {},
  });

  final dynamic item;
  final Map<String, dynamic> extraData;

  @override
  void dependencies() {
    switch (item.runtimeType) {
      case Move:
        Get.put<AddMoveFormController>(
          AddMoveFormController(move: item, rollStats: extraData['rollStats']),
        );
        break;
      case Spell:
        Get.put<AddSpellFormController>(
          AddSpellFormController(spell: item, rollStats: extraData['rollStats']),
        );
        break;
      case Item:
        Get.put<AddItemFormController>(AddItemFormController(item: item));
        break;
    }
  }
}
