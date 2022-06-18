import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';

class HpBar extends StatelessWidget {
  const HpBar({Key? key, this.currentHp, this.maxHp}) : super(key: key);

  final int? currentHp;
  final int? maxHp;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final CharacterService controller = Get.find();
      final char = controller.current;
      final curValue = currentHp ?? char?.currentHp;
      final maxValue = maxHp ?? char?.maxHp;
      final curPercent = curValue != null && maxValue != null ? curValue / maxValue : 1.0;

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: curPercent,
              minHeight: 17.5,
              color: Colors.red,
              backgroundColor: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(S.current.characterBarHp),
              const SizedBox(width: 8),
              Text(
                curValue?.toString() ?? '-',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('/' + (maxValue?.toString() ?? '-')),
            ],
          )
        ],
      );
    });
  }
}
