import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/model_utils/character_utils.dart';
import 'package:dungeon_paper/app/widgets/atoms/buffer_progress_bar.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/core/utils/color_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

class ExpBar extends StatelessWidget {
  const ExpBar({
    super.key,
    this.currentXp,
    this.maxXp,
    this.pendingXp,
    this.showPlusOneButton = false,
  });

  final int? currentXp;
  final int? maxXp;
  final int? pendingXp;
  final bool showPlusOneButton;

  @override
  Widget build(BuildContext context) {
    return CharacterProvider.consumer(
      (context, charProvider, char) {
        final maybeCharacter = charProvider.maybeCurrent;

        final curValue = currentXp ?? maybeCharacter?.currentXp ?? 0;
        final curPending = pendingXp ?? maybeCharacter?.pendingXp ?? 0;
        final maxValueNullable = maxXp ?? maybeCharacter?.maxXp;
        final maxValue = maxValueNullable ?? 1;
        final maxValueString = maxValueNullable?.toString() ?? '-';

        final curPercent = curValue / maxValue;
        final curBuffer = curValue + (curPending);
        final curBufferPercent = curBuffer / maxValue;

        final xpColor = ColorUtils.fromHex6String('#1e88e5');
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: BufferProgressBar(
                    value: curPercent,
                    bufferValue: curBufferPercent,
                    bufferColor: const Color.fromARGB(255, 117, 188, 251),
                    height: 17.5,
                    color: xpColor,
                    backgroundColor: Colors.blue[100],
                  ),
                ),
                if (showPlusOneButton)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Tooltip(
                      message: tr.xp.bar
                          .plusOneTooltip(PlatformHelper.interactionString(context)),
                      preferBelow: false,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: xpColor,
                        ),
                        width: 30,
                        height: 30,
                        child: IconButton(
                          icon: const Icon(Icons.plus_one, size: 18),
                          padding: const EdgeInsets.all(0),
                          visualDensity: VisualDensity.compact,
                          onPressed: () {
                            final char = charProvider.current;
                            CharacterUtils.addXP(context, char, 1);
                          },
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(tr.xp.bar.label),
                const SizedBox(width: 8),
                Text(
                  curValue.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('/$maxValueString'),
                if (curPending > 0)
                  Text(
                    '(+$curPending)',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            )
          ],
        );
      },
    );
  }
}