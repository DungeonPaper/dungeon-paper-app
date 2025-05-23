import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/model_utils/dice_utils.dart';
import 'package:dungeon_paper/app/modules/Home/views/local_widgets/home_character_extras.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/armor_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/damage_dice_dialog.dart';
import 'package:dungeon_paper/app/widgets/molecules/character_subtitle.dart';
import 'package:dungeon_paper/app/widgets/molecules/ability_scores_grid.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/core/utils/math_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'local_widgets/home_character_dynamic_cards.dart';
import 'local_widgets/home_character_header_view.dart';
import 'local_widgets/home_character_hp_xp_view.dart';

class HomeCharacterView extends StatelessWidget with HomeCharacterPaddingMixin {
  const HomeCharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return CharacterProvider.consumer((context, controller, _) {
      final char = controller.maybeCurrent;
      if (char == null) {
        return Container();
      }
      return HomeCharacterLayout(
        leftCol: _buildLeftCol(context, controller),
        rightCol: const HomeCharacterDynamicCards(),
      );
    });
  }

  List<Widget> _buildLeftCol(
    BuildContext context,
    CharacterProvider controller,
  ) {
    final char = controller.current;
    final abilityScores = char.abilityScores.stats;

    return [
      pad(const HomeCharacterHeaderView()),
      const SizedBox(height: 8),
      pad(
        Text(
          char.displayName,
          textScaler: const TextScaler.linear(1.4),
          textAlign: TextAlign.center,
        ),
      ),
      CharacterSubtitle(character: char),
      const SizedBox(height: 4),
      pad(const HomeCharacterExtras()),
      pad(const SizedBox(height: 4)),
      pad(
        const Center(
          child: SizedBox(width: 500, child: HomeCharacterHpExpView()),
        ),
        8,
      ),
      pad(
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryChip(
                icon: const Icon(DwIcons.swords),
                // visualDensity: VisualDensity.compact,
                label: char.damageDice.toString(),
                tooltip: tr.character.data.damageDice,
                onPressed:
                    () => showDialog(
                      context: context,
                      builder:
                          (context) => DamageDiceDialog(
                            damage: char.stats.damageDice,
                            defaultDamage: char.defaultDamageDice,
                            abilityScores: char.abilityScores,
                            onChanged:
                                (damage) => controller.updateCharacter(
                                  char.copyWith(
                                    stats: char.stats.copyWithDamageDice(
                                      damage,
                                    ),
                                  ),
                                ),
                          ),
                    ),
              ),
              const SizedBox(width: 8),
              PrimaryChip(
                tooltip: tr.armor.title,
                icon: const Icon(DwIcons.armor),
                // visualDensity: VisualDensity.compact,
                label: char.armor.toString(),
                onPressed:
                    () => showDialog(
                      context: context,
                      builder:
                          (context) => ArmorDialog(
                            armor: char.stats.armor,
                            defaultArmor: char.defaultArmor,
                            onChanged:
                                (armor) => controller.updateCharacter(
                                  char.copyWith(
                                    stats: char.stats.copyWithArmor(armor),
                                  ),
                                ),
                          ),
                    ),
              ),
            ],
          ),
        ),
      ),
      pad(const SizedBox(height: 12)),
      pad(Center(child: AbilityScoresGrid(abilityScores: abilityScores))),
      pad(const SizedBox(height: 16)),
      pad(
        Center(
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
                      onPressed:
                          () => DiceUtils.openRollDialog(
                            context,
                            char.rollButtons[0].diceFor(char),
                          ),
                      style: ButtonThemes.primaryElevated(context),
                      label: Text(char.rollButtons[0].label),
                      icon: const Icon(DwIcons.dice_d6),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed:
                          () => DiceUtils.openRollDialog(
                            context,
                            char.rollButtons[1].diceFor(char),
                          ),
                      style: ButtonThemes.primaryElevated(context),
                      label: Text(char.rollButtons[1].label),
                      icon: const Icon(DwIcons.dice_d6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];
  }
}

class HomeCharacterLayout extends StatelessWidget
    with HomeCharacterPaddingMixin {
  const HomeCharacterLayout({
    super.key,
    required this.leftCol,
    required this.rightCol,
    this.scrollable = true,
  });

  final List<Widget> leftCol;
  final Widget rightCol;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final isWide = width > 1100;
        if (isWide) {
          final leftChild = Row(
            children: [Expanded(child: Container()), Column(children: leftCol)],
          );
          final leftContainer =
              width > 1600
                  ? Expanded(child: leftChild)
                  : SizedBox(width: 600, child: leftChild);
          final row = SizedBox(
            width: width,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                leftContainer,
                const SizedBox(width: 16),
                Expanded(child: rightCol),
              ],
            ),
          );
          if (scrollable) {
            return SingleChildScrollView(child: row);
          }
          return row;
        }

        final builder = ItemBuilder.lazyChildren(
          children: [
            ...leftCol.map(((e) => () => e)),
            () => pad(const SizedBox(height: 12)),
            () => rightCol,
          ],
        );

        if (!scrollable) {
          return Column(
            children: [
              for (final i in range(builder.itemCount))
                builder.itemBuilder(context, i),
            ],
          );
        }

        return ListView.builder(
          shrinkWrap: !scrollable,
          itemBuilder: builder.itemBuilder,
          itemCount: builder.itemCount,
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
