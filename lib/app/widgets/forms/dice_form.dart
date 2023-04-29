import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:dungeon_paper/app/themes/button_themes.dart';
import 'package:dungeon_paper/app/themes/themes.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:get/get.dart';

enum ModifierType { stat, fixed }

class DiceForm extends StatefulWidget {
  const DiceForm({
    Key? key,
    this.dice,
    this.onChanged,
    required this.abilityScores,
    this.enabled = true,
  }) : super(key: key);

  final dw.Dice? dice;
  final void Function(dw.Dice dice)? onChanged;
  final AbilityScores abilityScores;
  final bool enabled;

  @override
  State<DiceForm> createState() => _DiceFormState();
}

class _DiceFormState extends State<DiceForm> {
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
    amount = TextEditingController(text: widget.dice?.amount.toString() ?? '2')..addListener(_onChanged);
    sides = widget.dice?.sides ?? 6;
    modifierNum = TextEditingController(text: (widget.dice?.modifierValue ?? 0).toString())..addListener(_onChanged);
    modifierStat = widget.dice?.modifierStat;
    modifierType = widget.dice?.modifierStat != null ? ModifierType.stat : ModifierType.fixed;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: NumberTextField(
                numberType: NumberType.int,
                controller: amount,
                enabled: widget.enabled,
                minValue: 1,
                decoration: InputDecoration(
                  label: Text(S.current.diceAmount),
                  alignLabelWithHint: true,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(S.current.diceSeparator),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              child: SelectBox<int>(
                value: sides,
                label: Text(S.current.diceSides),
                isExpanded: true,
                items: [
                  for (final i in [4, 6, 8, 10, 12, 20, 100]) DropdownMenuItem<int>(child: Text(i.toString()), value: i)
                ],
                onChanged: widget.enabled
                    ? (value) => setState(() {
                          if (value != null) {
                            sides = value;
                            _onChanged();
                          }
                        })
                    : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: (ButtonThemes.primaryElevated(
                          context,
                          backgroundOpacity: modifierType == ModifierType.fixed ? 1 : 0.4,
                        ) ??
                        ElevatedButton.styleFrom())
                    .copyWith(
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
                onPressed: () => setState(() {
                  modifierType = ModifierType.fixed;
                  _onChanged();
                }),
                child: Text(S.current.diceUseValue),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: (ButtonThemes.primaryElevated(
                          context,
                          backgroundOpacity: modifierType == ModifierType.stat ? 1 : 0.4,
                        ) ??
                        ElevatedButton.styleFrom())
                    .copyWith(
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
                onPressed: () => setState(() {
                  modifierType = ModifierType.stat;
                  _onChanged();
                }),
                child: Text(S.current.diceUseStat),
              ),
            ),
          ],
        ),
        if (modifierType == ModifierType.fixed)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: NumberTextField(
              numberType: NumberType.int,
              controller: modifierNum,
              enabled: widget.enabled,
              decoration: InputDecoration(
                hintText: S.current.diceUseValuePlaceholder,
                label: Text(S.current.diceUseValueLabel),
              ),
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
              onChanged: widget.enabled
                  ? (value) => setState(() {
                        modifierStat = value;
                        _onChanged();
                      })
                  : null,
              items: [
                for (final stat in widget.abilityScores.stats)
                  DropdownMenuItem<String>(
                    child: Text(S.current.diceUseStatValue(stat.name, stat.key)),
                    value: stat.key,
                  )
              ],
            ),
          ),
      ],
    );
  }

  dw.Dice createDice() => dw.Dice(
        amount: int.tryParse(amount.text) ?? 1,
        sides: sides,
        modifierStat: modifierType == ModifierType.stat ? modifierStat : null,
        modifierValue: modifierType == ModifierType.fixed ? int.tryParse(modifierNum.text) ?? 0 : null,
      );

  void _onChanged() {
    widget.onChanged?.call(createDice());
  }

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
