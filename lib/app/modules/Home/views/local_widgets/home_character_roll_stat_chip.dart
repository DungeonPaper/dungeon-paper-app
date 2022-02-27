import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as m show TextDirection;

class HomeCharacterRollStatChip extends StatelessWidget {
  final RollStat stat;

  const HomeCharacterRollStatChip({Key? key, required this.stat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final valStr = stat.value.toString();
    final statKey = stat.key;
    // final statName = stat.name;
    final modSign = stat.modifier >= 0 ? '+' : '-';
    final modStr = stat.modifier.abs().toString();
    final theme = Theme.of(context);
    final brightness = ThemeData.estimateBrightnessForColor(theme.canvasColor);
    final isDark = brightness == Brightness.dark;
    final rollBadgeTextOpacity = isDark ? 0.5 : 0.5;
    final rollBadgeBgOpacity = isDark ? 0.8 : 0.1;

    return Material(
      borderRadius: BorderRadius.circular(10),
      color: theme.cardColor.withOpacity(0.5),
      clipBehavior: Clip.none,
      child: Stack(
        children: [
          InkWell(
            onTap: () => null,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTheme(
                    child: stat.icon,
                    data: IconThemeData(size: 16, color: theme.colorScheme.onSurface),
                  ),
                  // const SizedBox(width: 0),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: RichText(
                        textScaleFactor: 0.8,
                        text: TextSpan(
                          style: theme.textTheme.bodyText2,
                          children: [
                            TextSpan(text: statKey + ': '),
                            TextSpan(
                              text: valStr,
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.directional(
            textDirection: m.TextDirection.ltr,
            end: 2,
            top: 2,
            child: Material(
              color: theme.primaryColor.withOpacity(rollBadgeBgOpacity),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 0.5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconTheme(
                      child: const SvgIcon(DwIcons.dice_d6),
                      data: IconTheme.of(context).copyWith(
                        size: 10,
                        color: theme.colorScheme.onSurface.withOpacity(rollBadgeTextOpacity),
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      '$modSign$modStr',
                      textScaleFactor: 0.7,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withOpacity(rollBadgeTextOpacity),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
