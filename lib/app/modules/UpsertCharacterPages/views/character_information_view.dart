import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/char_info_controller.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/create_character_page_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';

class CharacterInformationView extends GetView<CharInfoController> {
  CharacterInformationView({
    Key? key,
    required this.onValidate,
  }) : super(key: key);

  final void Function(bool valid) onValidate;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final displayName = TextEditingController.fromValue(
    TextEditingValue(text: controller.displayName.value),
  )..addListener(validate);
  late final bioDesc = TextEditingController.fromValue(
    TextEditingValue(text: controller.bioDesc.value),
  )..addListener(validate);
  late final avatarUrl = TextEditingController.fromValue(
    TextEditingValue(text: controller.avatarUrl.value),
  )..addListener(validate);

  void validate() {
    onValidate(controller.isValid);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        shrinkWrap: true,
        children: [
          Obx(
            () => Text('Valid: ${controller.isValid}'),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: displayName,
            textInputAction: TextInputAction.next,
            validator: (val) => val == null || val.isEmpty ? 'Cannot be empty' : null,
            decoration: InputDecoration(
              labelText: S.current.createCharacterNameFieldLabel,
              hintText: S.current.createCharacterNameFieldPlaceholder,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            controller: avatarUrl,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: S.current.createCharacterAvatarFieldLabel,
              hintText: S.current.createCharacterAvatarFieldPlaceholder,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
          TextFormField(
            controller: bioDesc,
            maxLines: 10,
            textInputAction: TextInputAction.newline,
            decoration: InputDecoration(
              labelText: S.current.createCharacterDescFieldLabel,
              hintText: S.current.createCharacterDescFieldPlaceholder,
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
          ),
        ],
      ),
    );
  }
}
