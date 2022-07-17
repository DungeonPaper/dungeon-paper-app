import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/xp_bar.dart';
import 'package:dungeon_paper/app/widgets/atoms/hp_bar.dart';
import 'package:dungeon_paper/app/widgets/dialogs/xp_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/hp_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class HomeCharacterHpExpView extends GetView<CharacterService> {
  const HomeCharacterHpExpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            splashColor: Theme.of(context).splashColor,
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: HpBar(),
            ),
            borderRadius: BorderRadius.circular(10),
            onTap: () => Get.dialog(const HPDialog()),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: InkWell(
            splashColor: Theme.of(context).splashColor,
            child: const Padding(
              padding: EdgeInsets.all(4),
              child: ExpBar(),
            ),
            borderRadius: BorderRadius.circular(10),
            onTap: () => Get.dialog(const EXPDialog()),
          ),
        ),
      ],
    );
  }
}
