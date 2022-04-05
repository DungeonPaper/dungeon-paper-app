import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class RollDiceController extends GetxController {
  final dice = <dw.Dice>[].obs;
  final results = <dw.DiceRoll>[].obs;

  CharacterService get charService => Get.find();

  @override
  void onInit() {
    super.onInit();
    dice.value = Get.arguments is List<dw.Dice> ? _applyMods(Get.arguments) : [];
    // dice.value = dw.Dice.flatten([dw.Dice.d6 * 10]);
    roll();
  }

  List<dw.Dice> _applyMods(List<dw.Dice> dice) {
    return dice
        .map(
          (d) => d.needsModifier
              ? d.copyWithModifierValue(
                  charService.current!.rollStats.getStat(d.modifierStat!).value,
                )
              : d,
        )
        .toList();
  }

  int get totalResult => results.fold(0, (previousValue, element) => previousValue + element.total);

  List<dw.Dice> get flat => dw.Dice.flatten(dice);

  roll() {
    results.value = dw.DiceRoll.rollMany(flat);
  }
}
