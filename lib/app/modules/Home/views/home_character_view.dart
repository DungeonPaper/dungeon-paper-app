import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/modules/Home/views/local_widgets/home_character_extras.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/armor_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/damage_dice_dialog.dart';
import 'package:dungeon_paper/app/widgets/molecules/character_subtitle.dart';
import 'package:dungeon_paper/app/widgets/molecules/ability_scores_grid.dart';
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
        final char = controller.maybeCurrent;
        if (char == null) {
          return Container();
        }
        final abilityScores = char.abilityScores.stats;
        return ListView(
          padding: const EdgeInsets.only(bottom: 0),
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            pad(const HomeCharacterHeaderView()),
            const SizedBox(height: 8),
            Text(
              char.displayName,
              textScaleFactor: 1.4,
              textAlign: TextAlign.center,
            ),
            CharacterSubtitle(character: char),
            const SizedBox(height: 4),
            pad(const HomeCharacterExtras()),
            // p(Row(
            //   mainAxisSize: MainAxisSize.min,
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     // IconButton(
            //     //   iconSize: 20,
            //     //   icon: const Icon(Icons.library_books),
            //     //   onPressed: () => Get.dialog(const CharacterBioDialog()),
            //     // ),
            //     Column(
            //       mainAxisSize: MainAxisSize.min,
            //       // crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Text(
            //           char.displayName,
            //           textScaleFactor: 1.4,
            //           textAlign: TextAlign.center,
            //         ),
            //         Text(
            //           S.current.characterHeaderSubtitle(
            //             char.stats.level,
            //             char.characterClass.name,
            //             // "test",
            //             // char.bio.toRawJson() ?? 'test',
            //             S.current.alignment(char.bio.alignment.key),
            //           ),
            //           textAlign: TextAlign.center,
            //         ),
            //       ],
            //     ),
            //     // IconButton(
            //     //   iconSize: 20,
            //     //   icon: const Icon(Icons.edit),
            //     //   onPressed: () => null,
            //     // ),
            //   ],
            // )),
            pad(const SizedBox(height: 4)),
            pad(
              const Center(
                child: SizedBox(
                  width: 500,
                  child: HomeCharacterHpExpView(),
                ),
              ),
              8,
            ),
            pad(Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PrimaryChip(
                    icon: const Icon(DwIcons.swords),
                    // visualDensity: VisualDensity.compact,
                    label: char.damageDice.toString(),
                    tooltip: S.current.damageDice,
                    onPressed: () => Get.dialog(
                      DamageDiceDialog(
                        damage: char.stats.damageDice,
                        abilityScores: char.abilityScores,
                        onChanged: (damage) => controller.updateCharacter(
                          char.copyWith(
                            stats: char.stats.copyWithDamageDice(damage),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  PrimaryChip(
                    tooltip: S.current.armor,
                    icon: const Icon(DwIcons.armor),
                    // visualDensity: VisualDensity.compact,
                    label: char.armor.toString(),
                    onPressed: () => Get.dialog(
                      ArmorDialog(
                        armor: char.stats.armor,
                        onChanged: (armor) => controller.updateCharacter(
                          char.copyWith(
                            stats: char.stats.copyWithArmor(armor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
            pad(const SizedBox(height: 12)),
            pad(Center(
              child: AbilityScoresGrid(abilityScores: abilityScores),
            )),
            pad(const SizedBox(height: 16)),
            pad(Center(
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
                          onPressed: () =>
                              DiceUtils.openRollDialog(char.rollButtons[0].diceFor(char)),
                          style: ButtonThemes.primaryElevated(context),
                          label: Text(char.rollButtons[0].label),
                          icon: const Icon(DwIcons.dice_d6),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () =>
                              DiceUtils.openRollDialog(char.rollButtons[1].diceFor(char)),
                          style: ButtonThemes.primaryElevated(context),
                          label: Text(char.rollButtons[1].label),
                          icon: const Icon(DwIcons.dice_d6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            pad(const SizedBox(height: 12)),
            const HomeCharacterDynamicCards(),
          ],
        );
      },
    );
  }

  Widget pad(Widget child, [double? amount]) => Padding(
        padding: EdgeInsets.symmetric(horizontal: amount ?? 16),
        child: child,
      );
}
