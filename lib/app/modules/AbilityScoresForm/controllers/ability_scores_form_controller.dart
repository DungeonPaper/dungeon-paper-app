import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbilityScoresFormController extends GetxController {
  final dirty = false.obs;

  final Rx<AbilityScores> abilityScores =
      AbilityScores.dungeonWorld(dex: 10, str: 10, wis: 10, con: 10, intl: 10, cha: 10).obs;
  final textControllers = <String, TextEditingController>{};
  late final void Function(AbilityScores abilityScores) onChanged;

  AbilityScoresFormController();

  @override
  void onReady() {
    super.onReady();
    final AbilityScoresFormArguments args = Get.arguments;
    if (args.abilityScores != null) {
      abilityScores.value = args.abilityScores!;
    }
    for (final ctrl in textControllers.values) {
      ctrl.removeListener(validate);
    }
    textControllers.clear();
    for (final stat in abilityScores.value.stats) {
      textControllers[stat.key] = TextEditingController(text: stat.value.toString())
        ..addListener(validate);
    }
    onChanged = args.onChanged;
  }

  void validate() {
    dirty.value = true;
    abilityScores.value = abilityScores.value.copyWithStatValues({
      for (final stat in abilityScores.value.stats)
        stat.key: int.tryParse(textControllers[stat.key]!.text) ?? stat.value
    });
  }

  void updateStat(AbilityScore stat) {
    abilityScores.value =
        abilityScores.value.copyWith(stats: updateByKey(abilityScores.value.stats, [stat]));
    textControllers[stat.key] ??= TextEditingController(text: stat.value.toString())
      ..addListener(validate);
    textControllers[stat.key]!.text = stat.value.toString();
  }

  void removeStat(AbilityScore stat) {
    abilityScores.value =
        abilityScores.value.copyWith(stats: removeByKey(abilityScores.value.stats, [stat]));
    textControllers.remove(stat.key);
  }

  void addStat(AbilityScore abilityScore) {
    if (textControllers.containsKey(abilityScore.key)) {
      return;
    }
    abilityScores.value =
        abilityScores.value.copyWith(stats: [...abilityScores.value.stats, abilityScore]);
    textControllers[abilityScore.key] = TextEditingController(text: abilityScore.value.toString())
      ..addListener(validate);
  }
}

class AbilityScoresFormArguments {
  final AbilityScores? abilityScores;
  final void Function(AbilityScores abilityScores) onChanged;

  AbilityScoresFormArguments({
    required this.abilityScores,
    required this.onChanged,
  });
}
