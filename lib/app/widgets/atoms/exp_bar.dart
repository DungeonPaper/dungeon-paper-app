import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/buffer_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';

class ExpBar extends StatelessWidget with CharacterServiceMixin {
  const ExpBar({
    Key? key,
    this.currentExp,
    this.maxExp,
    this.pendingExp,
  }) : super(key: key);

  final int? currentExp;
  final int? maxExp;
  final int? pendingExp;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final char = maybeChar;
        final maxValue = maxExp ?? char?.maxExp;
        final curValue = currentExp ?? char?.currentExp ?? 0;

        final curPercent = maxValue != null ? curValue / maxValue : 0.0;
        final curPending = char != null ? pendingExp ?? char.pendingExp : 0;
        final curBuffer = char != null ? curValue + (curPending) : 0;
        final curBufferPercent = curBuffer / (maxValue ?? double.infinity);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BufferProgressBar(
              value: curPercent,
              bufferValue: curBufferPercent,
              height: 17.5,
              color: const Color(0xff1e88e5),
              backgroundColor: Colors.blue[100],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.current.characterBarXp),
                const SizedBox(width: 8),
                Text(
                  curValue.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('/' + (maxValue?.toString() ?? '-')),
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
