import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class AbilityScoreChip extends StatelessWidget {
  final AbilityScore stat;
  final bool showDice;

  const AbilityScoreChip({super.key, required this.stat, this.showDice = true});

  @override
  Widget build(BuildContext context) {
    final valStr = stat.value.toString();
    final statKey = stat.key;
    final modSign = stat.modifier >= 0 ? '+' : '-';
    final modStr = stat.modifier.abs().toString();
    final theme = Theme.of(context);
    final brightness = ThemeData.estimateBrightnessForColor(theme.canvasColor);
    final isDark = brightness == Brightness.dark;
    final rollBadgeModifierOpacity = isDark ? 0.5 : 0.4;
    final isLight = theme.brightness == Brightness.light;
    final cardColor = stat.isDebilitated
        ? Color.alphaBlend(DwColors.error.withOpacity(isLight ? 0.4 : 0.2),
            theme.scaffoldBackgroundColor)
        : theme.cardColor;

    return Card(
      margin: EdgeInsets.zero,
      color: cardColor,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        onTap: () => DiceUtils.openRollDialog(
            context, [dw.Dice(amount: 2, sides: 6, modifierStat: stat.key)]),
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTheme(
                    data: IconThemeData(
                      size: 18,
                      color: theme.colorScheme.onSurface,
                    ),
                    child: Icon(stat.icon),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 32,
                    child: Text(
                      valStr,
                      textScaler: const TextScaler.linear(1.5),
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
                                data: IconTheme.of(context).copyWith(
                                  size: 12,
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(rollBadgeModifierOpacity),
                                ),
                                child: const Icon(DwIcons.dice_d6),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                '$modSign$modStr',
                                style: TextStyle(
                                    color: theme.colorScheme.onSurface),
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
