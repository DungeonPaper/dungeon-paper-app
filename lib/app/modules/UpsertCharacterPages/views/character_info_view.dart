import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_info_controller.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/content_generators/character_name_generator.dart';
import 'package:dungeon_paper/core/utils/platform_string.dart';
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
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            controller: controller.displayName.value,
            textInputAction: TextInputAction.next,
            validator: (val) => val == null || val.isEmpty ? 'Cannot be empty' : null,
            onChanged: (val) => updateControllers(),
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              labelText: S.current.createCharacterNameFieldLabel,
              hintText: S.current.createCharacterNameFieldPlaceholder,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: IconButton(
                tooltip: PlatformString.byInteractionType(
                  context,
                  touch: S.current.createCharRandomizeNameTooltipTouch,
                  mouse: S.current.createCharRandomizeNameTooltipClick,
                ),
                icon: const SvgIcon(DwIcons.dice_d6),
                onPressed: () {
                  controller.displayName.value.text = CharacterNameGenerator().generate();
                  updateControllers();
                },
              ),
            ),
          ),
          TextFormField(
            controller: controller.avatarUrl.value,
            textInputAction: TextInputAction.done,
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
