import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/buffer_progress_bar.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HpBar extends StatelessWidget with CharacterServiceMixin {
  const HpBar({
    super.key,
    this.currentHp,
    this.maxHp,
  });

  final int? currentHp;
  final int? maxHp;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final char = maybeChar;
      final curValue = currentHp ?? char?.currentHp;
      final maxValue = maxHp ?? char?.maxHp;
      final curPercent =
          curValue != null && maxValue != null ? curValue / maxValue : 1.0;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BufferProgressBar(
            value: curPercent,
            height: 17.5,
            color: Colors.red,
            backgroundColor: Colors.black,
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(tr.home.bars.hp),
              const SizedBox(width: 8),
              Text(
                curValue?.toString() ?? '-',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('/${maxValue?.toString() ?? '-'}'),
            ],
          )
        ],
      );
    });
  }
}
