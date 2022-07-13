import 'dart:math';

import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/controllers/ability_scores_form_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/dice_icon.dart';
import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/round_icon_button.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;

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
            title: Text(S.current.entityPlural(AbilityScore)),
            centerTitle: true,
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: _save,
            label: Text(S.current.save),
            icon: const Icon(Icons.save),
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 8),
                  child: HelpText(text: S.current.abilityScoreInfo),
                ),
                Form(
                  child: ReorderableListView(
                    padding: const EdgeInsets.all(16).copyWith(bottom: 80),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
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
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    visualDensity: VisualDensity.compact,
                                    title: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(AbilityScore.iconFor(statKey), size: 16),
                                        const SizedBox(width: 8),
                                        Text(stat.name),
                                      ],
                                    ),
                                    subtitle: Text(stat.description, style: textTheme.caption),
                                    minVerticalPadding: 8,
                                  ),
                                  const Divider(height: 8),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: NumberTextField(
                                            controller: controller.textControllers[stat.key],
                                            minValue: 1,
                                            maxValue: 20,
                                            numberType: NumberType.int,
                                            textInputAction: TextInputAction.next,
                                            // onChanged: (val) => updateControllers(),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: Text(S.current
                                            .abilityScoreModifierValueLabel(stat.modifier)),
                                      ),
                                      const SizedBox(width: 8),
                                      RoundIconButton(
                                        icon: DiceIcon.from(dw.Dice.d6),
                                        onPressed: () => controller.textControllers[stat.key]!
                                            .text = Random().nextInt(21).toString(),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8),
                                        child: EntityEditMenu(
                                            onEdit: () => null, onDelete: () => null),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ],
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
