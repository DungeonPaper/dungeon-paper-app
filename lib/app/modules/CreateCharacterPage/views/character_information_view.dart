import 'package:dungeon_paper/app/modules/CreateCharacterPage/controllers/create_character_page_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../generated/l10n.dart';

class CharacterInformationView extends GetView<CreateCharacterPageController> {
  CharacterInformationView({Key? key}) : super(key: key);

  late final displayName = TextEditingController.fromValue(
    TextEditingValue(text: controller.displayName.value),
  );
  late final bioDesc = TextEditingController.fromValue(
    TextEditingValue(text: controller.bioDesc.value),
  );
  late final avatarUrl = TextEditingController.fromValue(
    TextEditingValue(text: controller.avatarUrl.value),
  );

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        TextFormField(
          controller: displayName,
          decoration: InputDecoration(
            labelText: S.current.createCharacterNameFieldLabel,
            hintText: S.current.createCharacterNameFieldPlaceholder,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        TextFormField(
          controller: avatarUrl,
          decoration: InputDecoration(
            labelText: S.current.createCharacterAvatarFieldLabel,
            hintText: S.current.createCharacterAvatarFieldPlaceholder,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
        TextFormField(
          controller: bioDesc,
          maxLines: 10,
          decoration: InputDecoration(
            labelText: S.current.createCharacterDescFieldLabel,
            hintText: S.current.createCharacterDescFieldPlaceholder,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
        ),
      ],
    );
  }
}
