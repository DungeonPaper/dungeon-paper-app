import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/app/widgets/chips/primary_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/coins_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/load_dialog.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'home_character_actions_filters.dart';

class HomeCharacterActionsSummary extends StatelessWidget {
  const HomeCharacterActionsSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return CharacterProvider.consumer(
      (context, charProvider, _) {
        final char = charProvider.current;
        return Row(
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
                    label: tr.home.summary.load.label(
                        NumberFormat('#.#').format(char.currentLoad),
                        NumberFormat('#.#').format(char.maxLoad)),
                    tooltip: tr.home.summary.load.tooltip,
                    backgroundColor: _loadColor(char.currentLoad, char.maxLoad),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => LoadDialog(
                        load: char.stats.load,
                        defaultLoad: char.defaultMaxLoad,
                        onChanged: (load) => charProvider.updateCharacter(
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
                    label: tr.home.summary.coins.label(
                      NumberFormat.compact().format(char.coins),
                    ),
                    tooltip: tr.home.summary.coins.tooltip,
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => CoinsDialog(
                        coins: char.coins,
                        onChanged: (coins) => charProvider
                            .updateCharacter(char.copyWith(coins: coins)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            HomeCharacterActionsFilters(
              hidden: char.settings.actionCategories.hidden,
              onUpdateHidden: (filters) {
                charProvider.updateCharacter(
                  char.copyWith(
                    settings: char.settings.copyWith(
                      actionCategories:
                          char.settings.actionCategories.copyWithInherited(
                        hidden: filters,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Color? _loadColor(double currentLoad, int maxLoad) {
    final perc = currentLoad / maxLoad;
    if (perc > 1) {
      return Colors.red;
    } else if (perc >= 0.75) {
      return Colors.orange;
    }
    return null;
  }
}

