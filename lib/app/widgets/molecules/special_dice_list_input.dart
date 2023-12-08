import 'package:dungeon_paper/app/data/models/roll_button.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/chips/dice_chip.dart';
import 'package:dungeon_paper/app/widgets/molecules/chip_list_input.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';

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
      label: Text(tr.customRolls.specialDice.title),
      addValue: SpecialDice.damage,
      chipBuilder: (context, dice, {onDeleteChip, required onTapChip}) =>
          DiceChip(
        dice: dw.Dice.d6,
        backgroundColor: DwColors.warning,
        label: dice != null
            ? tr.customRolls.specialDice.button(dice.value.name)
            : tr.generic.addEntity(
                tr.customRolls.specialDice.button(SpecialDice.damage.name)),
        icon: dice != null ? null : const Icon(Icons.add),
        onPressed: onTapChip,
        onDeleted: onDeleteChip,
      ),
    );
  }
}
