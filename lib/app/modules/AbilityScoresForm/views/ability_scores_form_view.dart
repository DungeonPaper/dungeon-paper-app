import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/controllers/ability_scores_form_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AbilityScoresFormView extends GetView<AbilityScoresFormController> {
  const AbilityScoresFormView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            // TODO intl
            title: const Text('Ability Scores'),
            centerTitle: true,
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: _save,
            label: Text(S.current.save),
            icon: const Icon(Icons.save),
          ),
          body: Form(
            child: ReorderableListView(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              onReorder: (int oldIndex, int newIndex) {
                controller.abilityScores.value = controller.abilityScores.value.copyWith(
                    stats: reorder(controller.abilityScores.value.stats, oldIndex, newIndex));
              },
              children: sortByPredefined(
                controller.textControllers.keys.toList(),
                order: controller.abilityScores.value.stats.map((stat) => stat.key).toList(),
              ).map(
                (statKey) {
                  final stat = controller.abilityScores.value.stats
                      .firstWhere((stat) => stat.key == statKey);
                  return Padding(
                    key: Key('stat-$statKey'),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          visualDensity: VisualDensity.compact,
                          title: Row(
                            children: [
                              IconTheme.merge(
                                data: const IconThemeData(size: 16),
                                child: AbilityScore.iconFor(statKey),
                              ),
                              const SizedBox(width: 8),
                              Text(stat.name),
                            ],
                          ),
                          subtitle: Text(stat.description, style: textTheme.caption),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 150,
                                child: NumberTextField(
                                  controller: controller.textControllers[stat.key],
                                  minValue: 1,
                                  maxValue: 20,
                                  numberType: NumberType.int,
                                  textInputAction: TextInputAction.next,
                                  // onChanged: (val) => updateControllers(),
                                ),
                              ),
                              EntityEditMenu(onEdit: () => null, onDelete: () => null),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }

  _save() {
    controller.onChanged(controller.abilityScores.value);
    Get.back();
  }
}
