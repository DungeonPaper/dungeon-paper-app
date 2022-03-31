import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/app/widgets/molecules/roll_stats_grid.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'local_widgets/home_character_dynamic_cards.dart';
import 'local_widgets/home_character_header_view.dart';
import 'local_widgets/home_character_hp_xp_view.dart';

class HomeCharacterView extends GetView<CharacterService> {
  const HomeCharacterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final char = controller.current;
        final rollStats = char?.rollStats.stats ?? [];
        return ListView(
          padding: const EdgeInsets.only(bottom: 0),
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            p(const HomeCharacterHeaderView()),
            p(Text(
              char?.displayName ?? '...',
              textScaleFactor: 1.4,
              textAlign: TextAlign.center,
            )),
            p(Text(
              S.current.characterHeaderSubtitle(
                char?.stats.level ?? 0,
                char?.characterClass.name ?? '...',
                // "test",
                // char?.bio.toRawJson() ?? 'test',
                S.current.alignment(char?.bio.alignment.key ?? 'good'),
              ),
              textAlign: TextAlign.center,
            )),
            p(const SizedBox(height: 8)),
            p(const Center(
              child: SizedBox(
                width: 500,
                child: HomeCharacterHpExpView(),
              ),
            )),
            p(const SizedBox(height: 16)),
            p(Center(
              child: RollStatsGrid(rollStats: rollStats),
            )),
            p(const SizedBox(height: 16)),
            p(Center(
              child: IconTheme(
                data: IconTheme.of(context).copyWith(size: 16),
                child: SizedBox(
                  width: 500,
                  height: 48,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => null,
                          style: ButtonThemes.primaryElevated(context),
                          label: Text(S.current.rollBasicActionButton),
                          icon: const SvgIcon(DwIcons.dice_d6),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => null,
                          style: ButtonThemes.primaryElevated(context),
                          label: Text(S.current.rollAttackDamageButton),
                          icon: const SvgIcon(DwIcons.dice_d6),
                        ),
                      ),
                    ],
                  ),
                ),
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
