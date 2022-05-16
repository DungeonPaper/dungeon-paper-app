import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class AbilityScoreChip extends StatelessWidget {
  final AbilityScore stat;
  final bool showDice;

  const AbilityScoreChip({Key? key, required this.stat, this.showDice = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valStr = stat.value.toString();
    final statKey = stat.key;
    final statName = stat.name;
    final modSign = stat.modifier >= 0 ? '+' : '-';
    final modStr = stat.modifier.abs().toString();
    final theme = Theme.of(context);
    final brightness = ThemeData.estimateBrightnessForColor(theme.canvasColor);
    final isDark = brightness == Brightness.dark;
    final rollBadgeModifierOpacity = isDark ? 0.5 : 0.4;
    final rollBadgeBgOpacity = isDark ? 0.8 : 0.1;
    final cardColor =
        stat.isDebilitated ? theme.errorColor.withOpacity(0.15) : theme.cardColor.withOpacity(0.5);

    return InkWell(
      onTap: () => DiceUtils.openRollDialog([dw.Dice(amount: 2, sides: 6, modifierStat: stat.key)]),
      borderRadius: BorderRadius.circular(10),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: cardColor,
        clipBehavior: Clip.none,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTheme(
                    child: stat.icon,
                    data: IconThemeData(size: 16, color: theme.colorScheme.onSurface),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 32,
                    child: Text(
                      valStr,
                      textScaleFactor: 1.5,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(statKey),
                        if (showDice)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconTheme(
                                child: const SvgIcon(DwIcons.dice_d6),
                                data: IconTheme.of(context).copyWith(
                                  size: 12,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(rollBadgeModifierOpacity),
                                ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '$modSign$modStr',
                                // textScaleFactor: 0.8,
                                style: TextStyle(color: theme.colorScheme.onSurface),
                                //.withOpacity(rollBadgeModifierOpacity),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
