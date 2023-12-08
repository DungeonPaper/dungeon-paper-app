import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/round_icon_button.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/material.dart';

class RoundRollButton extends StatelessWidget {
  const RoundRollButton({
    super.key,
    required this.dice,
    required this.abilityScores,
    this.size = 50,
  });

  final List<Dice> dice;
  final double size;
  final AbilityScores? abilityScores;

  @override
  Widget build(BuildContext context) {
    final isRollingWithDebility = dice.any(
      (d) => isDebilitated(d),
    );
    final diceStr = dice
        .map((d) => d.toString() + (isDebilitated(d) ? ' (-1)*' : ''))
        .join(', ');
    return RoundIconButton(
      icon: const Icon(DwIcons.dice_d6),
      backgroundColor: abilityScores != null && isRollingWithDebility
          ? DwColors.error.withOpacity(0.5)
          : null,
      onPressed: () => DiceUtils.openRollDialog(dice),
      tooltip: isRollingWithDebility
          ? tr.customRolls.tooltip.rollWithDebility(diceStr)
          : tr.customRolls.tooltip.rollNormal(diceStr),
    );
  }

  bool isDebilitated(Dice d) =>
      d.modifierStat != null &&
      abilityScores!.getStat(d.modifierStat!).isDebilitated;
}
