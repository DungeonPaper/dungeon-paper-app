import 'dart:async';
import 'dart:math';

import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ValueChange { positive, neutral, negative }

class HPDialogController extends GetxController with CharacterServiceMixin {
  final overrideHP = 0.obs;
  final shouldOverrideMaxHP = false.obs;
  final overrideMaxHp = TextEditingController();

  late StreamSubscription<bool> sub;

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
    charService.updateCharacter(
      char.copyWith(
        stats: char.stats
            .copyWith(
              currentHp: overrideHP.value,
            )
            .copyWithMaxHp(shouldOverrideMaxHP.value ? maxHP : null),
      ),
    );
    close();
  }

  void close() async {
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    overrideHP.value = char.currentHp;
    sub = shouldOverrideMaxHP.stream.listen(listener);
    shouldOverrideMaxHP.value = char.stats.maxHp != null;
    overrideMaxHp.text = char.maxHp.toString();
    overrideMaxHp.addListener(listener);
  }

  listener([dynamic value]) {
    overrideHP.value = min(maxHP, overrideHP.value);
    overrideHP.refresh();
  }

  @override
  void onClose() {
    super.onClose();
    overrideMaxHp.removeListener(listener);
    sub.cancel();
  }
}
