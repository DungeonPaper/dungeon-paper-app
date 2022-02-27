import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_info_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/on_init_builder.dart';
import 'package:dungeon_paper/core/request_notifier.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';

class CharacterInfoView extends GetView<CharacterInfoController> {
  const CharacterInfoView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  final void Function(bool valid, CharInfo? info) onValidate;

  void updateControllers() {
    onValidate(controller.validate(), controller.isValid ? controller.charInfo : null);
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
            controller: controller.displayName.value,
            textInputAction: TextInputAction.next,
            validator: (val) => val == null || val.isEmpty ? 'Cannot be empty' : null,
            onChanged: (val) => updateControllers(),
            decoration: InputDecoration(
              labelText: S.current.createCharacterNameFieldLabel,
              hintText: S.current.createCharacterNameFieldPlaceholder,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            controller: controller.avatarUrl.value,
            textInputAction: TextInputAction.next,
            onChanged: (val) => updateControllers(),
            decoration: InputDecoration(
              labelText: S.current.createCharacterAvatarFieldLabel,
              hintText: S.current.createCharacterAvatarFieldPlaceholder,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ],
      ),
    );
  }
}
