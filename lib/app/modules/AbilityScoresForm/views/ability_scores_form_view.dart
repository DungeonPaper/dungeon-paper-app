import 'dart:math';

import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/modules/AbilityScoreForm/controllers/ability_score_form_controller.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/controllers/ability_scores_form_controller.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/dice_icon.dart';
import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/app/widgets/atoms/number_text_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/round_icon_button.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:dungeon_paper/app/widgets/menus/entity_edit_menu.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AbilityScoresFormView extends GetView<AbilityScoresFormController> {
  const AbilityScoresFormView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            title: Text(tr.entityPlural(tn(AbilityScore))),
            centerTitle: true,
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: _save,
            label: Text(tr.generic.save),
            icon: const Icon(Icons.save),
          ),
          body: ListView(
            padding: const EdgeInsets.all(16).copyWith(bottom: 80),
            children: [
              HelpText(text: tr.abilityScores.info),
              const SizedBox(height: 8),
              Form(
                child: ReorderableListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.abilityScores.value.stats.length,
                  onReorder: (int oldIndex, int newIndex) {
                    controller.abilityScores.value =
                        controller.abilityScores.value.copyWith(
                            stats: reorder(controller.abilityScores.value.stats,
                                oldIndex, newIndex));
                  },
                  itemBuilder: (context, index) => _buildCard(context, index),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () => Get.toNamed(Routes.abilityScoreForm,
                    arguments: AbilityScoreFormArguments(
                      abilityScore: null,
                      onSave: controller.addStat,
                    )),
                icon: const Icon(Icons.add),
                label: Text(
                  tr.generic.addEntity(
                    tr.entity(tn(AbilityScore)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final statKey = sortByPredefined(
      controller.textControllers.keys.toList(),
      order:
          controller.abilityScores.value.stats.map((stat) => stat.key).toList(),
    ).elementAt(index);
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
                subtitle: Text(stat.description, style: textTheme.bodySmall),
                minVerticalPadding: 8,
              ),
              const Divider(height: 8),
              const SizedBox(height: 16),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 170,
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
                    padding: const EdgeInsets.symmetric(horizontal: 8)
                        .copyWith(right: 16),
                    child: Text(
                      tr.abilityScores.form
                          .modifierValueLabel(stat.modifier.toString()),
                    ),
                  ),
                  RoundIconButton(
                    icon: DiceIcon.from(dw.Dice.d6),
                    onPressed: () => controller.textControllers[stat.key]!
                        .text = Random().nextInt(21).toString(),
                    tooltip: tr.abilityScores.rollButton.randStat,
                  ),
                  Expanded(child: Container()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: EntityEditMenu(
                      onEdit: () => Get.toNamed(
                        Routes.abilityScoreForm,
                        arguments: AbilityScoreFormArguments(
                          abilityScore: stat,
                          onSave: (stat) => controller.updateStat(stat),
                        ),
                      ),
                      onDelete: () => deleteDialog.confirm(
                        context,
                        DeleteDialogOptions(
                            entityName: stat.name,
                            entityKind: tr.entity(tn(AbilityScore))),
                        () => controller.removeStat(stat),
                      ),
                    ),
                  ),
                ],
              ),
            ],
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
