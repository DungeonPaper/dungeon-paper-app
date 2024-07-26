import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/core/route_arguments.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';

class AbilityScoresFormController extends ChangeNotifier {
  var dirty = false;

  AbilityScores abilityScores = AbilityScores.dungeonWorldAll(10);
  final textControllers = <String, TextEditingController>{};
  late final void Function(AbilityScores abilityScores) onChanged;

  AbilityScoresFormController(BuildContext context) {
    final AbilityScoresFormArguments args = getArgs(context);
    if (args.abilityScores != null) {
      abilityScores = args.abilityScores!;
    }
    for (final ctrl in textControllers.values) {
      ctrl.removeListener(validate);
    }
    textControllers.clear();
    for (final stat in abilityScores.stats) {
      textControllers[stat.key] =
          TextEditingController(text: stat.value.toString())
            ..addListener(validate);
    }
    onChanged = args.onChanged;
  }

  void validate() {
    dirty = true;
    abilityScores = abilityScores.copyWithStatValues({
      for (final stat in abilityScores.stats)
        stat.key: int.tryParse(textControllers[stat.key]!.text) ?? stat.value
    });
    notifyListeners();
  }

  void updateStat(AbilityScore stat) {
    abilityScores =
        abilityScores.copyWith(stats: updateByKey(abilityScores.stats, [stat]));
    textControllers[stat.key] ??=
        TextEditingController(text: stat.value.toString())
          ..addListener(validate);
    textControllers[stat.key]!.text = stat.value.toString();
  }

  void removeStat(AbilityScore stat) {
    abilityScores =
        abilityScores.copyWith(stats: removeByKey(abilityScores.stats, [stat]));
    textControllers.remove(stat.key);
  }

  void addStat(AbilityScore abilityScore) {
    if (textControllers.containsKey(abilityScore.key)) {
      return;
    }
    abilityScores =
        abilityScores.copyWith(stats: [...abilityScores.stats, abilityScore]);
    textControllers[abilityScore.key] =
        TextEditingController(text: abilityScore.value.toString())
          ..addListener(validate);
  }

  void onReorder(int oldIndex, int newIndex) {
    abilityScores = abilityScores.copyWith(
      stats: reorder(abilityScores.stats, oldIndex, newIndex),
    );
    notifyListeners();
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
