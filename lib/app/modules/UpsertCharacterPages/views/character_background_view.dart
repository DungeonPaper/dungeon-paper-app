import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_background_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';

class CharacterBackgroundView extends GetView<CharacterBackgroundController> {
  const CharacterBackgroundView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  final void Function(bool valid, CharBackground? info) onValidate;

  void updateControllers() {
    onValidate(controller.validate(), controller.isValid ? controller.charBackground : null);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        children: [
          Obx(() => Text('Valid: ${controller.isValid}')),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller.bio.value,
            textInputAction: TextInputAction.next,
            onChanged: (val) => updateControllers(),
            maxLines: 5,
            decoration: InputDecoration(
              labelText: S.current.createCharacterBioFieldLabel,
              hintText: S.current.createCharacterBioFieldPlaceholder,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            controller: controller.raceName.value,
            textInputAction: TextInputAction.next,
            onChanged: (val) => updateControllers(),
            decoration: InputDecoration(
              labelText: S.current.createCharacterRaceNameFieldLabel,
              hintText: S.current.createCharacterRaceNameFieldPlaceholder,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            controller: controller.raceDesc.value,
            textInputAction: TextInputAction.done,
            onChanged: (val) => updateControllers(),
            maxLines: 3,
            decoration: InputDecoration(
              labelText: S.current.createCharacterRaceDescFieldLabel,
              hintText: S.current.createCharacterRaceDescFieldPlaceholder,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ],
      ),
    );
  }
}
