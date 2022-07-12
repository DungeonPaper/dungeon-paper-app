import 'package:dungeon_paper/app/data/models/gear_selection.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/starting_gear_form_controller.dart';

class StartingGearFormView extends GetView<StartingGearFormController> {
  const StartingGearFormView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            title: Text(S.current.selectGeneric(S.current.entity(GearSelection))),
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: _save,
            label: Text(S.current.save),
            icon: const Icon(Icons.save),
          ),
          body: ListView(
            children: controller.availableGear
                .map((choice) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(choice.description),
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
                    ))
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
