import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/chips/dice_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/add_dice_dialog.dart';
import 'package:dungeon_paper/app/widgets/molecules/chip_list_input.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

class DiceListInput extends StatefulWidget {
  const DiceListInput({
    super.key,
    this.controller,
    required this.abilityScores,
    required this.guessFrom,
    this.label,
    this.labelColor,
    this.maxCount,
  });

  final ValueNotifier<List<dw.Dice>>? controller;
  final AbilityScores abilityScores;
  final List<ValueNotifier<TextEditingValue>> guessFrom;
  final Color? labelColor;
  final int? maxCount;
  final Widget? label;

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
    guesses = {};
    controller.addListener(_guessListener);
    for (var element in widget.guessFrom) {
      element.addListener(_guessListener);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isNotAtMax =
        widget.maxCount == null || controller.value.length < widget.maxCount!;

    return ChipListInput<dw.Dice>(
      label: widget.label,
      controller: controller,
      dialogBuilder: (context, dice, {required onSave}) => AddDiceDialog(
        dice: dice?.value,
        abilityScores: widget.abilityScores,
        onSave: onSave,
      ),
      chipBuilder: (context, dice, {onDeleteChip, required onTapChip}) =>
          DiceChip(
        dice: dice != null ? dice.value : dw.Dice.d6,
        label:
            dice != null ? null : tr.generic.addEntity(tr.entity(tn(dw.Dice))),
        icon: dice != null ? null : const Icon(Icons.add),
        onPressed: onTapChip,
        onDeleted: onDeleteChip,
      ),
      maxCount: widget.maxCount,
      labelColor: widget.labelColor,
      trailing: [
        if (isNotAtMax)
          for (final dice in guesses.where(
            (guess) => !controller.value
                .map((d) => d.toString())
                .contains(guess.toString()),
          ))
            DiceChip(
              dice: dice,
              label: tr.dice.suggestion(dice.toString()),
              onPressed: () => controller.value = [...controller.value, dice],
            ),
      ],
    );
  }

  void _refreshGuess() {
    if (widget.guessFrom.isNotEmpty) {
      final guessStr = widget.guessFrom.join(' ');
      setState(() {
        guesses = dw.Dice.guessFromString(guessStr).toSet();
        // controller.value = [...controller.value];
      });
    }
  }

  void _guessListener() {
    _refreshGuess();
  }

  @override
  void dispose() {
    controller.removeListener(_guessListener);
    for (var element in widget.guessFrom) {
      element.removeListener(_guessListener);
    }
    super.dispose();
  }
}
