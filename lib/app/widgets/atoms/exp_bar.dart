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
    return Obx(() {
      final char = maybeChar;
      final curValue = currentExp ?? char?.currentExp;
      final maxValue = maxExp ?? char?.maxExp;
      final curPercent = curValue != null && maxValue != null ? curValue / maxValue : 1.0;
      final curBuffer = char != null ? curPercent + (pendingExp ?? char.pendingExpPercent) : 0.0;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BufferProgressBar(
            value: curPercent,
            bufferValue: curBuffer,
            height: 17.5,
            color: const Color(0xff1e88e5),
            backgroundColor: Colors.blue[100],
          ),
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(10),
          //   child: LinearProgressIndicator(
          //     value: char != null ? char.currentExpPercent : 1,
          //     minHeight: 17.5,
          //     color: const Color(0xff1e88e5),
          //     backgroundColor: Colors.blue[100],
          //   ),
          // ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.current.characterBarXp),
              const SizedBox(width: 8),
              Text(
                char?.currentExp.toString() ?? '-',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('/' + (char?.maxExp.toString() ?? '-')),
            ],
          )
        ],
      );
    });
  }
}
