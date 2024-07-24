import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/modules/StartingGearEditForm/starting_gear_edit_form_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/help_tooltip_icon.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:flutter/material.dart';

import 'package:dungeon_paper/app/data/services/user_provider.dart';
import 'package:dungeon_paper/app/data/services/character_provider.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:provider/provider.dart';

class StartingGearEditFormView extends StatelessWidget
    with CharacterProviderMixin, UserProviderMixin {
  const StartingGearEditFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final borderBox = BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
        width: 1,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(tr.startingGear.title),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () =>
                StartingGearEditFormController.of(context).addChoice(),
          ),
        ],
      ),
      body: Consumer<StartingGearEditFormController>(
        builder: (context, ctrl, _) => ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: ctrl.choices.length,
          itemBuilder: (context, i) {
            final choice = ctrl.choices[i];
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr.startingGear.choice.title(i + 1),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(width: 16),
                        HelpTooltipIcon(
                          tooltipText: tr.startingGear.choice.helpText,
                        ),
                        const Expanded(child: SizedBox.shrink()),
                        IconButton(
                          icon: const Icon(Icons.arrow_upward),
                          onPressed: i > 0
                              ? () => ctrl.moveChoiceBy(choice.data, -1)
                              : null,
                          tooltip: tr.startingGear.choice.moveUp,
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_downward),
                          onPressed: i < ctrl.choices.length - 1
                              ? () => ctrl.moveChoiceBy(choice.data, 1)
                              : null,
                          tooltip: tr.startingGear.choice.moveDown,
                        ),
                        const SizedBox(width: 16),
                        IconButton.filled(
                          icon: const Icon(Icons.delete),
                          onPressed: () => awaitDeleteConfirmation<GearChoice>(
                              context,
                              choice.description.text,
                              () => ctrl.removeChoice(choice.data)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        label: Text(tr.startingGear.choice.description.label),
                        hintText: tr.startingGear.choice.description.hintText,
                      ),
                      controller: choice.description,
                    ),
                    const SizedBox(height: 16),
                    _buildSuggestedMaxAllowance(context, choice),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Text(
                          tr.startingGear.selection.title,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(width: 8),
                        HelpTooltipIcon(
                          tooltipText: tr.startingGear.selection.helpText,
                          size: 20,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    for (final selection in choice.selections)
                      Builder(
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: borderBox,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            label: Text(tr.startingGear
                                                .selection.description.label),
                                            hintText: tr.startingGear.selection
                                                .description.hintText,
                                          ),
                                          controller: selection.description,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      IconButton.filled(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () => ctrl.removeSelection(
                                            choice.data, selection.data),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  SizedBox(
                                    width: 200,
                                    child: NumberTextField(
                                      numberType: NumberType.double,
                                      decoration: InputDecoration(
                                        label: Text(tr.startingGear.selection
                                            .coins.label),
                                        hintText: tr.startingGear.selection
                                            .coins.hintText,
                                      ),
                                      controller: selection.coins,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Text(
                                        tr.startingGear.option.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      const SizedBox(width: 8),
                                      HelpTooltipIcon(
                                        tooltipText:
                                            tr.startingGear.option.helpText,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                  if (selection.options.isNotEmpty)
                                    const SizedBox(height: 16),
                                  for (final option in selection.options)
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: borderBox,
                                        child: Builder(
                                          builder: _buildOptionRow(context,
                                              ctrl, choice, selection, option),
                                        ),
                                      ),
                                    ),
                                  if (selection.options.isEmpty)
                                    const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () => ctrl.selectItemsToAdd(
                                            choice.data, selection.data),
                                        icon: const Icon(Icons.add),
                                        label: Text(tr.startingGear.option.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ElevatedButton.icon(
                      onPressed: () => ctrl.addSelection(choice.data),
                      icon: const Icon(Icons.add),
                      label: Text(tr.startingGear.selection.add),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => StartingGearEditFormController.of(context).save(),
        label: Text(tr.generic.save),
        icon: const Icon(Icons.save),
      ),
    );
  }

  Widget _buildSuggestedMaxAllowance(
      BuildContext context, GearChoiceData choice) {
    final listTile = ListTile(
      title: Text(tr.startingGear.choice.maxSelections.label),
      subtitle: Text(
        tr.startingGear.choice.maxSelections.helpText,
      ),
    );
    final input = SizedBox(
      width: 200,
      child: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: NumberTextField(
          numberType: NumberType.int,
          minValue: 0,
          decoration: const InputDecoration(
            hintText: '0',
          ),
          controller: choice.maxAllowance,
        ),
      ),
    );
    if (MediaQuery.of(context).size.width < 630) {
      return Column(
        children: [
          listTile,
          Align(alignment: Alignment.centerLeft, child: input)
        ],
      );
    }
    return Row(children: [Expanded(child: listTile), input]);
  }

  Widget Function(BuildContext) _buildOptionRow(
    BuildContext context,
    StartingGearEditFormController ctrl,
    GearChoiceData choice,
    GearSelectionData selection,
    GearOptionData option,
  ) {
    return (context) {
      final label = [
        Icon(Item.genericIcon),
        const SizedBox(width: 8),
        Expanded(
          child: Text(option.data.item.name),
        ),
      ];
      final input = SizedBox(
        width: 150,
        child: NumberTextField(
          numberType: NumberType.double,
          decoration: InputDecoration(
            label: Text(tr.startingGear.option.amount.label),
            hintText: tr.startingGear.option.amount.hintText,
          ),
          minValue: 1,
          controller: option.amount,
        ),
      );
      final deleteButton = IconButton.filled(
        icon: const Icon(Icons.delete),
        onPressed: () => ctrl.removeOption(
          choice.data,
          selection.data,
          option.data,
        ),
      );
      final mq = MediaQuery.of(context).size;
      if (mq.width < 550) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(children: [...label, deleteButton]),
            const SizedBox(height: 16),
            input,
          ],
        );
      }
      return Row(
        children: [
          ...label,
          const SizedBox(width: 8),
          input,
          const SizedBox(width: 16),
          deleteButton,
        ],
      );
    };
  }
}

