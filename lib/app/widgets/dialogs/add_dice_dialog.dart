import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

enum ModifierType { stat, fixed }

class AddDiceDialog extends StatefulWidget {
  const AddDiceDialog({
    Key? key,
    this.dice,
    this.onSave,
    required this.rollStats,
  }) : super(key: key);

  final dw.Dice? dice;
  final void Function(dw.Dice dice)? onSave;
  final RollStats rollStats;

  @override
  State<AddDiceDialog> createState() => _AddDiceDialogState();
}

class _AddDiceDialogState extends State<AddDiceDialog> {
  final RepositoryService repo = Get.find();
  // late int amount;
  late final TextEditingController amount;
  late int sides;
  late final TextEditingController modifierNum;
  late String? modifierStat;
  late ModifierType modifierType;

  @override
  void initState() {
    super.initState();
    // amount = widget.dice?.amount ?? 2;
    amount = TextEditingController(text: widget.dice?.amount.toString() ?? '2');
    sides = widget.dice?.sides ?? 6;
    modifierNum = TextEditingController(text: (widget.dice?.modifierValue ?? 0).toString());
    modifierStat = widget.dice?.modifierStat;
    modifierType = widget.dice?.modifierStat != null ? ModifierType.stat : ModifierType.fixed;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.createGeneric(dw.Dice)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextFormField(
                  controller: amount,
                  keyboardType: const TextInputType.numberWithOptions(decimal: false),
                  decoration: InputDecoration(
                    filled: true,
                    label: Text(S.current.diceAmount),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(S.current.diceSeparator),
              const SizedBox(width: 8),
              Expanded(
                child: SelectBox<int>(
                  value: sides,
                  label: Text(S.current.diceSides),
                  items: [
                    for (final i in [4, 6, 8, 10, 12, 20, 100])
                      DropdownMenuItem<int>(child: Text(i.toString()), value: i)
                  ],
                  onChanged: (value) => setState(() {
                    if (value != null) {
                      sides = value;
                    }
                  }),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ButtonThemes.primaryElevated(
                    context,
                    backgroundOpacity: modifierType == ModifierType.fixed ? 1 : 0.4,
                  ).copyWith(
                    elevation: MaterialStateProperty.resolveWith(
                      (_) => modifierType == ModifierType.fixed ? 1 : 0,
                    ),
                    shape: MaterialStateProperty.resolveWith(
                      (_) => rRectShape.copyWith(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(8),
                          right: Radius.circular(0),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => setState(() => modifierType = ModifierType.fixed),
                  child: Text(S.current.diceUseValue),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ButtonThemes.primaryElevated(
                    context,
                    backgroundOpacity: modifierType == ModifierType.stat ? 1 : 0.4,
                  ).copyWith(
                    elevation: MaterialStateProperty.resolveWith(
                      (_) => modifierType == ModifierType.stat ? 1 : 0,
                    ),
                    shape: MaterialStateProperty.resolveWith(
                      (_) => rRectShape.copyWith(
                        borderRadius: const BorderRadius.horizontal(
                          left: Radius.circular(0),
                          right: Radius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () => setState(() => modifierType = ModifierType.stat),
                  child: Text(S.current.diceUseStat),
                ),
              ),
            ],
          ),
          if (modifierType == ModifierType.fixed)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  hintText: S.current.diceUseValuePlaceholder,
                  label: Text(S.current.diceUseValueLabel),
                ),
                controller: modifierNum,
                keyboardType: const TextInputType.numberWithOptions(decimal: false),
              ),
            ),
          if (modifierType == ModifierType.stat)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: SelectBox<String>(
                value: modifierStat,
                isExpanded: true,
                label: Text(S.current.diceUseStatPlaceholder),
                hint: Text(S.current.diceUseStatLabel),
                onChanged: (value) => setState(() => modifierStat = value),
                items: [
                  for (final stat in widget.rollStats.stats)
                    DropdownMenuItem<String>(
                      child: Text(S.current.diceUseStatValue(stat.name, stat.key)),
                      value: stat.key,
                    )
                ],
              ),
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            widget.onSave?.call(createDice());
            Get.back();
          },
          child: Text(S.current.save),
        ),
      ],
    );
  }

  dw.Dice createDice() => dw.Dice(
        amount: int.tryParse(amount.text) ?? 1,
        sides: sides,
        modifierStat: modifierType == ModifierType.stat ? modifierStat : null,
        modifierValue:
            modifierType == ModifierType.fixed ? int.tryParse(modifierNum.text) ?? 0 : null,
      );

  dynamic tryParse(String text) {
    if (RegExp(r'[a-z]').hasMatch(text)) {
      return text;
    }
    if (RegExp(r'[.]').hasMatch(text)) {
      return double.tryParse(text);
    }

    return int.tryParse(text);
  }
}
