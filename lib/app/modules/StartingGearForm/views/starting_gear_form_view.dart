import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/starting_gear_form_controller.dart';

class StartingGearFormView extends GetView<StartingGearFormController> {
  const StartingGearFormView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            title: Text(tr.generic.selectEntity(tr.entity(tn(GearSelection)))),
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: _save,
            label: Text(tr.generic.save),
            icon: const Icon(Icons.save),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16).copyWith(bottom: 80),
            children: controller.availableGear
                .map(
                  (choice) => Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ListTile(
                              title: Text(choice.description),
                              subtitle: Text(
                                choice.maxSelections != null
                                    ? tr.createCharacter.startingGear.count
                                        .withMax(
                                        controller.selectionCount(choice),
                                        choice.maxSelections!,
                                      )
                                    : tr.createCharacter.startingGear.count
                                        .noMax(
                                        controller.selectionCount(choice),
                                      ),
                              ),
                            ),
                            ...choice.selections.map(
                              (sel) => ListTile(
                                onTap: () {
                                  controller.toggleSelect(sel);
                                },
                                leading: Checkbox(
                                  value: controller.isSelected(sel),
                                  onChanged: (val) {
                                    controller.toggleSelect(sel);
                                  },
                                ),
                                title: Text(sel.description, maxLines: 1),
                                subtitle: Text(
                                  sel.options
                                      .map((opt) =>
                                          '${NumberFormat('#0.#').format(opt.amount)}x ${opt.item.name}')
                                      .join(', '),
                                ),
                                dense: true,
                                visualDensity: VisualDensity.compact,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  _save() {
    controller.onChanged(controller.selectedOptions);
    Get.back();
  }
}
