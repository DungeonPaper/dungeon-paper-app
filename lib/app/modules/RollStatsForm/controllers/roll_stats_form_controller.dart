import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RollStatsFormController extends GetxController {
  final Rx<RollStats> rollStats;
  final textControllers = <String, TextEditingController>{};
  final dirty = false.obs;

  RollStatsFormController({
    RollStats? rollStats,
  }) : rollStats = (rollStats ??
                RollStats.dungeonWorld(dex: 10, str: 10, wis: 10, con: 10, intl: 10, cha: 10))
            .obs {
    _initTextControllers();
  }

  void _initTextControllers() {
    for (final ctrl in textControllers.values) {
      ctrl.removeListener(validate);
    }
    textControllers.clear();
    for (final stat in rollStats.value.stats) {
      textControllers[stat.key] = TextEditingController(text: stat.value.toString())
        ..addListener(validate);
    }
  }

  void validate() {
    dirty.value = true;
    rollStats.value = rollStats.value.copyWithStatValues({
      for (final stat in rollStats.value.stats)
        stat.key: int.tryParse(textControllers[stat.key]!.text) ?? stat.value
    });
  }
}
