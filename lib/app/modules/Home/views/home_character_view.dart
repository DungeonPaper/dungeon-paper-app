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
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'local_widgets/home_character_dynamic_cards.dart';
import 'local_widgets/home_character_header_view.dart';
import 'local_widgets/home_character_hp_xp_view.dart';

class HomeCharacterView extends GetView<CharacterService> with HomeCharacterPaddingMixin {
  const HomeCharacterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final char = controller.maybeCurrent;
        if (char == null) {
          return Container();
        }
        return HomeCharacterLayout(
          leftCol: _buildLeftCol(context),
          rightCol: const HomeCharacterDynamicCards(),
        );
      },
    );
  }

  List<Widget> _buildLeftCol(BuildContext context) {
    final char = controller.current;
    final abilityScores = char.abilityScores.stats;

    return [
      pad(const HomeCharacterHeaderView()),
      const SizedBox(height: 8),
      pad(Text(
        char.displayName,
        textScaleFactor: 1.4,
        textAlign: TextAlign.center,
      )),
      CharacterSubtitle(character: char),
      const SizedBox(height: 4),
      pad(const HomeCharacterExtras()),
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
                  defaultDamage: char.defaultDamageDice,
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
                  defaultArmor: char.defaultArmor,
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
                    onPressed: () => DiceUtils.openRollDialog(char.rollButtons[0].diceFor(char)),
                    style: ButtonThemes.primaryElevated(context),
                    label: Text(char.rollButtons[0].label),
                    icon: const Icon(DwIcons.dice_d6),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => DiceUtils.openRollDialog(char.rollButtons[1].diceFor(char)),
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
    ];
  }
}

class HomeCharacterLayout extends StatelessWidget with HomeCharacterPaddingMixin {
  const HomeCharacterLayout({
    super.key,
    required this.leftCol,
    required this.rightCol,
  });

  final List<Widget> leftCol;
  final Widget rightCol;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isWide = width > 750;
        if (isWide) {
          return SingleChildScrollView(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: clamp(width / 2, 350, 500),
                  child: ListView(children: leftCol, shrinkWrap: true),
                ),
                const SizedBox(width: 16),
                Expanded(child: rightCol),
              ],
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.only(bottom: 0),
          children: [
            ...leftCol,
            pad(const SizedBox(height: 12)),
            rightCol,
          ],
        );
      },
    );
  }
}

mixin HomeCharacterPaddingMixin {
  Widget pad(Widget child, [double? amount]) => Padding(
        padding: EdgeInsets.symmetric(horizontal: amount ?? 16),
        child: child,
      );
}
