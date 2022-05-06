import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/svg_icon.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/content_generators/character_name_generator.dart';
import 'package:dungeon_paper/core/utils/platform_string.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/basic_info_form_controller.dart';

class BasicInfoFormView extends GetView<BasicInfoFormController> {
  const BasicInfoFormView({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final void Function(String name, String avatar) onChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO intl
        title: const Text('Basic Information'),
        centerTitle: true,
      ),
      floatingActionButton: AdvancedFloatingActionButton.extended(
        onPressed: _save,
        label: Text(S.current.save),
        icon: const Icon(Icons.save),
      ),
      body: Form(
        //   // key: controller.formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          shrinkWrap: true,
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: controller.name.value,
              textInputAction: TextInputAction.next,
              validator: (val) => val == null || val.isEmpty ? 'Cannot be empty' : null,
              // onChanged: (val) => updateControllers(),
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
                  icon: const SvgIcon(DwIcons.dice_d6_numbered),
                  onPressed: () {
                    controller.name.value.text = CharacterNameGenerator().generate();
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.avatarUrl.value,
              textInputAction: TextInputAction.done,
              // onChanged: (val) => updateControllers(),
              decoration: InputDecoration(
                labelText: S.current.createCharacterAvatarFieldLabel,
                hintText: S.current.createCharacterAvatarFieldPlaceholder,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ],
        ),
      ),
    );
  }

  _save() {
    onChanged(controller.name.value.text, controller.avatarUrl.value.text);
    Get.back();
  }
}
