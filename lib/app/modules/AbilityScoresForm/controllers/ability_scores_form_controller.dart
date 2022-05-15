import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbilityScoresFormController extends GetxController {
  final Rx<AbilityScores> abilityScores;
  final textControllers = <String, TextEditingController>{};
  final dirty = false.obs;

  AbilityScoresFormController({
    AbilityScores? abilityScores,
  }) : abilityScores = (abilityScores ??
                AbilityScores.dungeonWorld(dex: 10, str: 10, wis: 10, con: 10, intl: 10, cha: 10))
            .obs {
    _initTextControllers();
  }

  void _initTextControllers() {
    for (final ctrl in textControllers.values) {
      ctrl.removeListener(validate);
    }
    textControllers.clear();
    for (final stat in abilityScores.value.stats) {
      textControllers[stat.key] = TextEditingController(text: stat.value.toString())
        ..addListener(validate);
    }
  }

  void validate() {
    dirty.value = true;
    abilityScores.value = abilityScores.value.copyWithStatValues({
      for (final stat in abilityScores.value.stats)
        stat.key: int.tryParse(textControllers[stat.key]!.text) ?? stat.value
    });
  }
}
