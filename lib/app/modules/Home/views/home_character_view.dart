import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_header_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_hp_xp_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../data/models/character.dart';
import '../../../widgets/atoms/labeled_icon_button.dart';
import '../controllers/home_controller.dart';

class HomeCharacterView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeCharacterHeaderView(),
          Text(
            controller.current?.displayName ?? "...",
            textScaleFactor: 1.4,
            textAlign: TextAlign.center,
          ),
          Text(
            S.current.characterHeaderSubtitle(
              controller.current?.stats.level ?? 0,
              controller.current?.characterClass.name ?? "...",
              // "test",
              // controller.current?.bio.toRawJson() ?? 'test',
              S.current.alignment(controller.current?.bio.alignment.key ?? 'good'),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          HomeCharacterHpXpView(),
          ElevatedButton(
            onPressed: () => controller.updateCharacter(
              Character.empty().copyWith(
                key: controller.current != null ? controller.current!.key : null,
                displayName: "Traveler",
                characterClass: (controller.current?.characterClass ?? CharacterClass.empty())
                    .copyInheritedWith(name: "Druid"),
              ),
            ),
            child: Text("Update data"),
          )
        ],
      ),
    );
  }
}
