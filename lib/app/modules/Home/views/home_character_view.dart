import 'dart:math';

import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/character_stats.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_header_view.dart';
import 'package:dungeon_paper/app/modules/Home/views/home_character_hp_xp_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';
import '../../../data/models/character.dart';
import '../../../themes/button_themes.dart';
import '../../../widgets/atoms/labeled_icon_button.dart';
import '../controllers/home_controller.dart';

class HomeCharacterView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var char = controller.current;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HomeCharacterHeaderView(),
            Text(
              char?.displayName ?? "...",
              textScaleFactor: 1.4,
              textAlign: TextAlign.center,
            ),
            Text(
              S.current.characterHeaderSubtitle(
                char?.stats.level ?? 0,
                char?.characterClass.name ?? "...",
                // "test",
                // char?.bio.toRawJson() ?? 'test',
                S.current.alignment(char?.bio.alignment.key ?? 'good'),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            HomeCharacterHpExpView(),
            ElevatedButton(
              style: ButtonThemes.primaryElevated,
              onPressed: () => controller.updateCharacter(
                Character.empty().copyWith(
                  key: char?.key,
                  displayName: "Traveler",
                  characterClass: (char?.characterClass ?? CharacterClass.empty())
                      .copyInheritedWith(name: "Druid"),
                  stats: (char?.stats ??
                          CharacterStats(level: 1, currentHp: 20, currentExp: 0, armor: 0))
                      .copyWith(currentExp: Random().nextInt(7)),
                ),
              ),
              child: Text("Update data"),
            )
          ],
        );
      },
    );
  }
}
