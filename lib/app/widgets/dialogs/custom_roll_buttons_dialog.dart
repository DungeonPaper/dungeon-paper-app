import 'dart:math';

import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/roll_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/select_box.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/molecules/dice_list_input.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/app/widgets/molecules/special_dice_list_input.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

class CustomRollButtonsDialog extends StatefulWidget {
  const CustomRollButtonsDialog({
    super.key,
    required this.character,
    required this.onChanged,
  });

  final Character character;
  final void Function(List<RollButton?> rollButtons) onChanged;

  @override
  State<CustomRollButtonsDialog> createState() => _CustomRollButtonsDialogState();
}

class _CustomRollButtonsDialogState extends State<CustomRollButtonsDialog>
    with SingleTickerProviderStateMixin {
  late List<RollButton?> rollButtons;
  late TabController tabController;

  @override
  void initState() {
    rollButtons = [widget.character.rawRollButtons[0], widget.character.rawRollButtons[1]];
    tabController = TabController(length: rollButtons.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(DwIcons.dice_d6_numbered, size: 24),
          const SizedBox(width: 8),
          Text(S.current.customRollButtons),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TabBar(
            controller: tabController,
            labelColor: Theme.of(context).colorScheme.onSurface,
            tabs: [
              Tab(text: S.current.customButtonLeft),
              Tab(text: S.current.customButtonRight),
            ],
          ),
          SizedBox(
            width: 400,
            height: min(
              MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom - 310,
              300,
            ),
            child: TabBarView(
              controller: tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final button in enumerate(rollButtons))
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _RollButtonListTile(
                        rollButton: button.value,
                        character: widget.character,
                        defaultButton: Character.defaultRollButtons[button.index],
                        onChanged: (val) => setState(() => rollButtons[button.index] = val),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      actions: DialogControls.save(
        context,
        onSave: save,
        onCancel: () => Get.back(),
      ),
    );
  }

  void save() {
    widget.onChanged(rollButtons);
    Get.back();
  }
}

class _RollButtonListTile extends StatefulWidget {
  const _RollButtonListTile({
    super.key,
    required this.rollButton,
    required this.defaultButton,
    required this.onChanged,
    required this.character,
  });

  final RollButton? rollButton;
  final RollButton defaultButton;
  final Character character;
  final void Function(RollButton? button) onChanged;

  @override
  State<_RollButtonListTile> createState() => _RollButtonListTileState();
}

class _RollButtonListTileState extends State<_RollButtonListTile> {
  late TextEditingController label;
  late ValueNotifier<List<dw.Dice>> dice;
  late ValueNotifier<List<SpecialDice>> specialDice;
  late bool isDefault;

  @override
  void initState() {
    super.initState();
    initFields(widget.rollButton ?? widget.defaultButton, widget.rollButton == null);
    label.addListener(listener);
    dice.addListener(listener);
    specialDice.addListener(listener);
  }

  void initFields(RollButton rollButton, bool isDefault) {
    label = TextEditingController(text: rollButton.label);
    dice = ValueNotifier(rollButton.dice);
    specialDice = ValueNotifier(rollButton.specialDice);
    this.isDefault = isDefault;
  }

  void updateFields(RollButton rollButton, bool isDefault) {
    label.text = rollButton.label;
    dice.value = rollButton.dice;
    specialDice.value = rollButton.specialDice;
    this.isDefault = isDefault;
  }

  @override
  void dispose() {
    dice.removeListener(listener);
    label.removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: SelectBox<RollButton>(
                isExpanded: true,
                hint: Text(S.current.rollButtonUsePreset),
                items: [
                  for (final button in [
                    Character.basicActionRollButton,
                    Character.hackAndSlashRollButton,
                    Character.volleyRollButton,
                    Character.discernRealitiesRollButton,
                    for (final move in widget.character.moves.where((move) => move.dice.isNotEmpty))
                      RollButton(label: move.name, dice: move.dice, specialDice: []),
                    for (final spell
                        in widget.character.spells.where((spell) => spell.dice.isNotEmpty))
                      RollButton(label: spell.name, dice: spell.dice, specialDice: []),
                  ])
                    DropdownMenuItem(
                      value: button,
                      child: Text(
                        button.label,
                        textScaleFactor: 0.85,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                ],
                onChanged: (button) {
                  setState(() {
                    if (button != null) {
                      updateFields(button, isSameAsDefault(button));
                    }
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: isDefault
                      ? null
                      : () => setState(() => updateFields(widget.defaultButton, true)),
                  child: Text(S.current.resetToDefault),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: label,
          decoration: InputDecoration(
            labelText: S.current.rollButtonLabel,
          ),
        ),
        const SizedBox(height: 16),
        DiceListInput(
          controller: dice,
          abilityScores: widget.character.abilityScores,
          guessFrom: const [],
        ),
        const SizedBox(height: 16),
        SpecialDiceListInput(controller: specialDice),
      ],
    );
  }

  void listener() {
    setState(() {
      if (label.text != widget.defaultButton.label) {
        isDefault = false;
      }
      final rollButton = RollButton(
        label: label.text,
        dice: dice.value,
        specialDice: specialDice.value,
      );
      isDefault = isSameAsDefault(rollButton);
      widget.onChanged(rollButton);
    });
  }

  bool isSameAsDefault(RollButton rollButton) {
    final defaultDice = widget.defaultButton.dice;
    final defaultSpecialDice = widget.defaultButton.specialDice;

    final conditions = [
      rollButton.label == widget.defaultButton.label,
      compareArrays(defaultDice, rollButton.dice),
      compareArrays(defaultSpecialDice, rollButton.specialDice),
    ];

    debugPrint('conditions: $conditions');

    return conditions.every((element) => element == true);
  }

  bool compareArrays<T>(List<T> defaultDice, List<T> dice) {
    return defaultDice.length == dice.length &&
        enumerate(dice).every(
          (element) {
            debugPrint(
                'index: ${element.index} value ${element.value} == ${defaultDice[element.index]}');
            return defaultDice[element.index].toString() == element.value.toString();
          },
        );
  }
}
