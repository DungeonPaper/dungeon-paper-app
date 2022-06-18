import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ValueChange { positive, neutral, negative }

class HPDialogController extends GetxController with CharacterServiceMixin {
  final overrideHP = 0.obs;
  final shouldOverrideMaxHP = false.obs;
  final overrideMaxHp = TextEditingController();

  int get currentHP => char.currentHp;
  int get maxHP => shouldOverrideMaxHP.value
      ? int.tryParse(overrideMaxHp.text) ?? char.defaultMaxHp
      : char.defaultMaxHp;

  ValueChange get change => currentHP == overrideHP.value
      ? ValueChange.neutral
      : currentHP > overrideHP.value
          ? ValueChange.negative
          : ValueChange.positive;

  int get changeAmount => (overrideHP.value - currentHP).abs();

  bool get isChangePositive => change == ValueChange.positive;
  bool get isChangeNegative => change == ValueChange.negative;
  bool get isChangeNeutral => change == ValueChange.neutral;

  void save() {
    Get.back();
    charService.updateCharacter(
      char.copyWith(
        stats: char.stats
            .copyWith(
              currentHp: overrideHP.value,
            )
            .copyWithMaxHp(shouldOverrideMaxHP.value ? maxHP : null),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    overrideHP.value = char.currentHp;
    shouldOverrideMaxHP.value = char.stats.maxHp != null;
    overrideMaxHp.text = char.maxHp.toString();
    // if (shouldOverrideMaxHP.value) {
    // }
    overrideMaxHp.addListener(listener);
  }

  listener() {
    overrideHP.refresh();
  }

  @override
  void onClose() {
    super.onClose();
    overrideMaxHp.removeListener(listener);
  }
}
