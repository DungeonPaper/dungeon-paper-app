import 'dart:async';

import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/models/roll_button.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/chips/dice_chip.dart';
import 'package:dungeon_paper/app/widgets/dialogs/add_dice_dialog.dart';
import 'package:dungeon_paper/app/widgets/molecules/chip_list_input.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

import '../../../generated/l10n.dart';

class SpecialDiceListInput extends StatefulWidget {
  const SpecialDiceListInput({
    super.key,
    this.controller,
  });

  final ValueNotifier<List<SpecialDice>>? controller;

  @override
  State<SpecialDiceListInput> createState() => _SpecialDiceListInputState();
}

class _SpecialDiceListInputState extends State<SpecialDiceListInput> {
  late ValueNotifier<List<SpecialDice>> controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? ValueNotifier([]);
  }

  @override
  Widget build(BuildContext context) {
    return ChipListInput<SpecialDice>(
      controller: controller,
      label: Text(S.current.specialDice),
      addValue: SpecialDice.damage,
      chipBuilder: (context, dice, {onDeleteChip, required onTapChip}) => DiceChip(
        dice: dw.Dice.d6,
        backgroundColor: DwColors.warning,
        label: dice != null
            ? S.current.specialRollButton(dice.value)
            : S.current.addGeneric(S.current.specialRollButton(SpecialDice.damage)),
        icon: dice != null ? null : const Icon(Icons.add),
        onPressed: onTapChip,
        onDeleted: onDeleteChip,
      ),
    );
  }
}
