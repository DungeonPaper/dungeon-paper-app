import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/chips/dice_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/add_dice_dialog.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

import '../../../generated/l10n.dart';

class DiceListInput extends StatefulWidget {
  DiceListInput({
    super.key,
    this.controller,
    required this.abilityScores,
  });

  DiceListInput.builder({
    super.key,
    this.controller,
    required this.abilityScores,
  });

  final ValueNotifier<List<dw.Dice>>? controller;
  final AbilityScores abilityScores;

  @override
  State<DiceListInput> createState() => _ChipListInputState();
}

class _ChipListInputState extends State<DiceListInput> {
  late ValueNotifier<List<dw.Dice>> controller;

  @override
  void initState() {
    controller = widget.controller ?? ValueNotifier([]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.current.entityPlural(dw.Dice), style: Theme.of(context).textTheme.caption),
        const SizedBox(height: 6),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (final dice in enumerate(controller.value))
              DiceChip(
                dice: dice.value,
                onPressed: () => Get.dialog(
                  AddDiceDialog(
                    dice: dice.value,
                    abilityScores: widget.abilityScores,
                    onSave: (_dice) {
                      setState(() =>
                          controller.value = updateByIndex(controller.value, _dice, dice.index));
                    },
                  ),
                ),
                onDeleted: () =>
                    setState(() => controller.value = [...controller.value..removeAt(dice.index)]),
              ),
            DiceChip(
              dice: dw.Dice.d6,
              label: S.current.addGeneric(dw.Dice),
              icon: const Icon(Icons.add),
              backgroundColor: Theme.of(context).primaryColor,
              onPressed: () => Get.dialog(
                AddDiceDialog(
                  abilityScores: widget.abilityScores,
                  onSave: (dice) {
                    setState(() => controller.value = [...controller.value, dice]);
                  },
                ),
              ),
            ),
            // for (final dice in guesses.where(
            //     (guess) => !controller.value.map((d) => d.toString()).contains(guess.toString())))
            //   DiceChip(
            //     dice: dice,
            //     label: S.current.diceSuggestion(dice.toString()),
            //     onPressed: () => setState(() => controller.value = [...controller.value, dice]),
            //   ),
          ],
        ),
      ],
    );
  }
}
