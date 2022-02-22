import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/l10n.dart';

class ExpBar extends StatelessWidget {
  const ExpBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final CharacterService controller = Get.find();
      var char = controller.current;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: char != null ? char.currentExpPercent : 1,
              minHeight: 17.5,
              color: const Color(0xff1e88e5),
              backgroundColor: Colors.blue[100],
            ),
          ),
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
