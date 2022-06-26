import 'dart:async';

import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/chips/dice_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/add_dice_dialog.dart';
import 'package:dungeon_paper/app/widgets/molecules/chip_list_input.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import '../../../generated/l10n.dart';

class DiceListInput extends StatefulWidget {
  const DiceListInput({
    super.key,
    this.controller,
    required this.abilityScores,
    required this.guessFrom,
  });

  final ValueNotifier<List<dw.Dice>>? controller;
  final AbilityScores abilityScores;
  final List<ValueNotifier<String>> guessFrom;

  @override
  State<DiceListInput> createState() => _DiceListInputState();
}

class _DiceListInputState extends State<DiceListInput> {
  late Set<dw.Dice> guesses;
  late ValueNotifier<List<dw.Dice>> controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? ValueNotifier([]);
    for (var element in widget.guessFrom) {
      element.addListener(_guessListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChipListInput<dw.Dice>(
      controller: controller,
      dialogBuilder: (context, dice, {required onSave}) => AddDiceDialog(
        dice: dice?.value,
        abilityScores: widget.abilityScores,
        onSave: onSave,
      ),
      chipBuilder: (context, dice, {onDeleteChip, required onTapChip}) => DiceChip(
        dice: dice != null ? dice.value : dw.Dice.d6,
        label: dice != null ? null : S.current.addGeneric(dw.Dice),
        icon: dice != null ? null : const Icon(Icons.add),
        onPressed: onTapChip,
        onDeleted: onDeleteChip,
      ),
      trailing: [
        for (final dice in guesses.where(
          (guess) => !controller.value.map((d) => d.toString()).contains(guess.toString()),
        ))
          DiceChip(
            dice: dice,
            label: S.current.diceSuggestion(dice.toString()),
            onPressed: () => controller.value = [...controller.value, dice],
          ),
      ],
    );
  }

  void _refreshGuess() {
    final guessStr = widget.guessFrom.join(' ');
    guesses = dw.Dice.guessFromString(guessStr).toSet();
    controller.value = [...controller.value];
  }

  void _guessListener() {
    _refreshGuess();
  }

  @override
  void dispose() {
    for (var element in widget.guessFrom) {
      element.removeListener(_guessListener);
    }
    super.dispose();
  }
}
