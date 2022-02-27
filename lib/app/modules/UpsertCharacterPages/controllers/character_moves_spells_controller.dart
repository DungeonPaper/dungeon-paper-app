import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/char_class_select_controller.dart';
import 'package:get/get.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';

class CharacterMovesSpellsController extends GetxController {
  final moves = <Move>[].obs;
  final spells = <Spell>[].obs;

  @override
  void onInit() {
    super.onInit();
    final CharClassSelectController ctrl = Get.find();
    // moves.value = ctrl.selectedClass.
  }
}

class CharacterMovesSpells {
  final List<Move> moves;
  final List<Spell> spells;

  CharacterMovesSpells({
    required this.moves,
    required this.spells,
  });
}
