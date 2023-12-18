import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/buffer_progress_bar.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpBar extends StatelessWidget with CharacterServiceMixin {
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
    return Obx(
      () {
        final maybeCharacter = maybeChar;

        final curValue = currentXp ?? maybeCharacter?.currentXp ?? 0;
        final curPending = pendingXp ?? maybeCharacter?.pendingXp ?? 0;
        final maxValueNullable = maxXp ?? maybeCharacter?.maxXp;
        final maxValue = maxValueNullable ?? 1;
        final maxValueString = maxValueNullable?.toString() ?? '-';

        final curPercent = curValue / maxValue;
        final curBuffer = curValue + (curPending);
        final curBufferPercent = curBuffer / maxValue;

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
              color: const Color(0xff1e88e5),
              backgroundColor: Colors.blue[100],
            ),
              ),
              if (showPlusOneButton)
                PrimaryChip(
                  label: '+1',
                  onPressed: () {
                    charService.updateCharacter(
                      char.copyWith(
                        stats: char.stats.copyWith(
                          currentXp: 1 + (char.stats.currentXp),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(tr.home.bars.xp),
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
