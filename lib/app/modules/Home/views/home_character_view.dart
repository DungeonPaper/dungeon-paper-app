import 'dart:math';

import 'package:dungeon_paper/app/modules/Home/views/home_character_dynamic_cards.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/character_class.dart';
import '../../../data/models/character_stats.dart';
import '../../../data/models/move.dart';
import '../../../modules/Home/views/home_character_header_view.dart';
import '../../../modules/Home/views/home_character_hp_xp_view.dart';
import '../../../modules/Home/views/home_character_roll_stat_chip.dart';
import '../../../../generated/l10n.dart';
import '../../../data/models/character.dart';
import '../../../data/models/meta.dart';
import '../../../themes/button_themes.dart';
import '../../../themes/themes.dart';
import '../controllers/home_controller.dart';

class HomeCharacterView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        var char = controller.current;
        return ListView(
          padding: const EdgeInsets.only(bottom: 0),
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            p(HomeCharacterHeaderView()),
            p(Text(
              char?.displayName ?? "...",
              textScaleFactor: 1.4,
              textAlign: TextAlign.center,
            )),
            p(Text(
              S.current.characterHeaderSubtitle(
                char?.stats.level ?? 0,
                char?.characterClass.name ?? "...",
                // "test",
                // char?.bio.toRawJson() ?? 'test',
                S.current.alignment(char?.bio.alignment.key ?? 'good'),
              ),
              textAlign: TextAlign.center,
            )),
            p(const SizedBox(height: 8)),
            p(HomeCharacterHpExpView()),
            p(const SizedBox(height: 16)),
            p(Center(
              child: SizedBox(
                width: 320,
                child: GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  childAspectRatio: 2.7,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    for (var stat in char?.rollStats.stats ?? [])
                      HomeCharacterRollStatChip(stat: stat),
                  ],
                ),
              ),
            )),
            p(const SizedBox(height: 16)),
            p(IconTheme(
              data: IconTheme.of(context).copyWith(size: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => null,
                      style: ButtonThemes.primaryElevated(context),
                      label: Text(S.current.rollBasicActionButton),
                      icon: SvgIcon(DwIcons.dice_d6),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => null,
                      style: ButtonThemes.primaryElevated(context),
                      label: Text(S.current.rollAttackDamageButton),
                      icon: SvgIcon(DwIcons.dice_d6),
                    ),
                  ),
                ],
              ),
            )),
            p(const SizedBox(height: 12)),
            const HomeCharacterDynamicCards(),
          ],
        );
      },
    );
  }

  Widget p(Widget child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: child,
      );
}
