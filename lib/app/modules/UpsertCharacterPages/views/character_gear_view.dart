import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_gear_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CharacterGearView extends GetView<CharacterGearController> {
  final void Function(bool valid, CharGear? info) onValidate;

  const CharacterGearView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  void updateControllers() {
    onValidate(true, controller.charGear);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
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
                              updateControllers();
                            },
                            leading: Checkbox(
                              value: controller.isSelected(sel),
                              onChanged: (val) {
                                controller.toggleSelect(sel);
                                updateControllers();
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
    );
  }
}
