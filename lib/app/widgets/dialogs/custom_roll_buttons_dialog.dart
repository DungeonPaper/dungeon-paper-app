import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/roll_button.dart';
import 'package:dungeon_paper/app/widgets/forms/dynamic_form/form_input_data.dart';
import 'package:dungeon_paper/app/widgets/molecules/dice_list_input.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
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
            tabs: [
              Tab(text: S.current.customButtonLeft),
              Tab(text: S.current.customButtonRight),
            ],
          ),
          ConstrainedBox(
            constraints: BoxConstraints.tightFor(width: 400, height: 200),
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
                        defaultButton: widget.character.defaultRollButtons[button.index],
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
        ElevatedButton(
          onPressed:
              isDefault ? null : () => setState(() => updateFields(widget.defaultButton, true)),
          child: Text(S.current.resetToDefault),
        ),
        TextFormField(
          controller: label,
        ),
        const SizedBox(height: 8),
        DiceListInput(
          controller: dice,
          abilityScores: widget.character.abilityScores,
          guessFrom: const [],
        ),
      ],
    );
  }

  void listener() {
    setState(() {
      final defaultDice = widget.defaultButton.dice;
      final defaultSpecialDice = widget.defaultButton.dice;
      if (label.text != widget.defaultButton.label) {
        isDefault = false;
      }
      isDefault = label.text == widget.defaultButton.label &&
          enumerate(dice.value).every(
            (element) {
              return defaultDice.length >= element.index + 1 &&
                  defaultDice[element.index].toString() == element.value.toString();
            },
          ) &&
          enumerate(specialDice.value).every(
            (element) {
              return defaultSpecialDice.length >= element.index + 1 &&
                  defaultSpecialDice[element.index].toString() == element.value.toString();
            },
          );
      widget.onChanged(RollButton(
        label: label.text,
        dice: dice.value,
        specialDice: specialDice.value,
      ));
    });
  }
}
