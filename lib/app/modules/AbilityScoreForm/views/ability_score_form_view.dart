import 'package:dungeon_paper/app/data/models/ability_scores.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ability_score_form_controller.dart';

class AbilityScoreFormView extends GetView<AbilityScoreFormController> {
  const AbilityScoreFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const separator = SizedBox(height: 16);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          controller.formContext == FormContext.create
              ? S.current.addGeneric(S.current.entity(AbilityScore))
              : S.current.editGeneric(S.current.entity(AbilityScore)),
        ),
        centerTitle: true,
      ),
      floatingActionButton: Obx(
        () => AdvancedFloatingActionButton.extended(
          onPressed: controller.isValid ? controller.save : null,
          label: Text(S.current.save),
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
                labelText: S.current.abilityScoreFormKeyLabel,
              ),
              validator: controller.keyValidator,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: HelpText(text: S.current.abilityScoreFormKeyDescription),
            ),
            separator,
            TextFormField(
              controller: controller.name,
              decoration: InputDecoration(
                labelText: S.current.abilityScoreFormNameLabel,
                hintText: S.current.abilityScoreFormNameDescription,
              ),
              validator: controller.requiredValidator,
            ),
            separator,
            TextFormField(
              controller: controller.description,
              minLines: 3,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: S.current.abilityScoreFormDescriptionLabel,
                hintText: S.current.abilityScoreFormDescriptionDescription,
              ),
              validator: controller.requiredValidator,
            ),
            const Divider(height: 48),
            TextFormField(
              controller: controller.debilityName,
              decoration: InputDecoration(
                labelText: S.current.abilityScoreFormDebilityNameLabel,
                hintText: S.current.abilityScoreFormDebilityNameDescription,
              ),
              validator: controller.requiredValidator,
            ),
            separator,
            TextFormField(
              controller: controller.debilityDescription,
              minLines: 3,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: S.current.abilityScoreFormDebilityDescriptionLabel,
                hintText: S.current.abilityScoreFormDebilityDescriptionDescription,
              ),
              validator: controller.requiredValidator,
            ),
            separator,
            Text(S.current.abilityScoreFormIconLabel),
            separator,
            Obx(
              () => Align(
                alignment: Alignment.centerLeft,
                child: Icon(controller.icon ?? AbilityScore.iconFor(controller.key.text)),
              ),
            ),
            separator,
            ElevatedButton(
              onPressed: () => controller.pickIcon(context),
              child: Text(
                S.current.abilityScoreFormPickIconLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
