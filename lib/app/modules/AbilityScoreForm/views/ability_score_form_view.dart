import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/ability_score_form_controller.dart';

class AbilityScoreFormView extends GetView<AbilityScoreFormController> {
  const AbilityScoreFormView({super.key});
  @override
  Widget build(BuildContext context) {
    const separator = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.formContext == FormContext.create
              ? tr.generic.addEntity(tr.entity(tn(AbilityScore)))
              : tr.generic.editEntity(tr.entity(tn(AbilityScore))),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Obx(
        () => AdvancedFloatingActionButton.extended(
          onPressed: controller.isValid ? controller.save : null,
          label: Text(tr.generic.save),
          icon: const Icon(Icons.save),
        ),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16).copyWith(bottom: 80),
          children: [
            TextFormField(
              controller: controller.key,
              decoration: InputDecoration(
                labelText: tr.abilityScores.form.key.label,
              ),
              validator: controller.keyValidator,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: HelpText(text: tr.abilityScores.form.key.description),
            ),
            separator,
            TextFormField(
              controller: controller.name,
              decoration: InputDecoration(
                labelText: tr.abilityScores.form.name.label,
                hintText: tr.abilityScores.form.name.description,
              ),
              validator: controller.requiredValidator,
            ),
            separator,
            TextFormField(
              controller: controller.description,
              minLines: 3,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: tr.abilityScores.form.description.label,
                hintText: tr.abilityScores.form.description.description,
              ),
              validator: controller.requiredValidator,
            ),
            const Divider(height: 48),
            TextFormField(
              controller: controller.debilityName,
              decoration: InputDecoration(
                labelText: tr.abilityScores.form.debilityName.label,
                hintText: tr.abilityScores.form.debilityName.description,
              ),
              validator: controller.requiredValidator,
            ),
            separator,
            TextFormField(
              controller: controller.debilityDescription,
              minLines: 3,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: tr.abilityScores.form.debilityDescription.label,
                hintText: tr.abilityScores.form.debilityDescription.description,
              ),
              validator: controller.requiredValidator,
            ),
            separator,
            Text(tr.abilityScores.form.icon.label),
            separator,
            Obx(
              () => Align(
                alignment: Alignment.centerLeft,
                child: Icon(controller.icon ??
                    AbilityScore.iconFor(controller.key.text)),
              ),
            ),
            separator,
            ElevatedButton(
              onPressed: () => controller.pickIcon(context),
              child: Text(
                tr.abilityScores.form.icon.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
