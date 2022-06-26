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

class CutomRollButtonsDialog extends StatefulWidget {
  CutomRollButtonsDialog({
    super.key,
    required this.character,
    required this.onChanged,
  });

  final Character character;
  final void Function(List<RollButton?> rollButtons) onChanged;

  @override
  State<CutomRollButtonsDialog> createState() => _CutomRollButtonsDialogState();
}

class _CutomRollButtonsDialogState extends State<CutomRollButtonsDialog> {
  late List<RollButton?> rollButtons;

  @override
  void initState() {
    rollButtons = widget.character.rollButtons;
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
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final button in enumerate(rollButtons)) ...[
              // TODO intl
              Text(
                button.index == 0 ? 'Left button' : 'Right button',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              _RollButtonListTile(
                rollButton: button.value,
                character: widget.character,
                defaultButton: widget.character.defaultRollButtons[button.index],
                onChanged: (val) => setState(() => rollButtons[button.index] = val),
              ),
              if (button.index == 0) const Divider(height: 24),
            ],
          ],
        ),
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
  late RollButtonType type;

  @override
  void initState() {
    super.initState();
    label = TextEditingController(text: widget.rollButton?.label ?? widget.defaultButton.label)
      ..addListener(listener);
    dice = ValueNotifier((widget.rollButton ?? widget.defaultButton).diceFor(widget.character))
      ..addListener(listener);
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
        TextFormField(
          controller: label,
        ),
        const SizedBox(height: 8),
        DiceListInput(
          controller: dice,
          abilityScores: widget.character.abilityScores,
          guessFrom: [],
        ),
      ],
    );
  }

  void listener() {
    setState(() {
      widget.onChanged(RollButton(
        dice: dice.value,
        label: label.text,
        type: RollButtonType.custom,
      ));
    });
  }
}
