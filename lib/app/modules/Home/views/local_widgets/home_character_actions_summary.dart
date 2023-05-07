import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/coins_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/load_dialog.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'home_character_actions_filters.dart';

class HomeCharacterActionsSummary extends GetView<CharacterService> {
  const HomeCharacterActionsSummary({
    Key? key,
  }) : super(key: key);

  Character get char => controller.current;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 4,
              runSpacing: 4,
              children: [
                PrimaryChip(
                  // visualDensity: VisualDensity.compact,
                  icon: const Icon(DwIcons.dumbbell, size: 16),
                  label: S.current.actionSummaryChipLoad(char.currentLoad, char.maxLoad),
                  tooltip: S.current.maxLoad,
                  onPressed: () => Get.dialog(
                    LoadDialog(
                      load: char.stats.load,
                      defaultLoad: char.defaultMaxLoad,
                      onChanged: (load) => controller.updateCharacter(
                        char.copyWith(
                          stats: char.stats.copyWithLoad(load),
                        ),
                      ),
                    ),
                  ),
                ),
                PrimaryChip(
                  // visualDensity: VisualDensity.compact,
                  icon: const Icon(DwIcons.coin_stack, size: 16),
                  label: S.current.actionSummaryChipCoins(
                    NumberFormat.compact().format(char.coins),
                  ),
                  tooltip: S.current.coins,
                  onPressed: () => Get.dialog(
                    CoinsDialog(
                      coins: char.coins,
                      onChanged: (coins) => controller.updateCharacter(char.copyWith(coins: coins)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          HomeCharacterActionsFilters(
            hidden: char.settings.actionCategories.hidden,
            onUpdateHidden: (filters) {
              controller.updateCharacter(
                char.copyWith(
                  settings: char.settings.copyWith(
                    actionCategories: char.settings.actionCategories.copyWithInherited(
                      hidden: filters,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
