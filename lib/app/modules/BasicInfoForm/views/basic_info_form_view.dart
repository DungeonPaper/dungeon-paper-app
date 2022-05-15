import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            // TODO intl
            title: const Text('Basic Information'),
            centerTitle: true,
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: _save,
            // TODO intl
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
                const SizedBox(height: 48),
                Center(
                  child: CharacterAvatar.squircle(
                    size: 174,
                    character: Character.empty().copyWith(
                      avatarUrl: controller.avatarUrl.value.text,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if (controller.hasPhotoFile)
                  SizedBox(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: controller.pickPhoto,
                            icon: const Icon(Icons.upload_file),
                            // TODO intl
                            label: const Text('Choose New Photo...'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => null,
                            icon: const Icon(Icons.close),
                            // TODO intl
                            label: const Text('Remove Photo'),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!controller.hasPhotoFile)
                  SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: controller.pickPhoto,
                      icon: const Icon(Icons.upload_file),
                      // TODO intl
                      label: const Text('Choose Photo...'),
                    ),
                  ),
                Row(
                  children: const [
                    Expanded(child: Divider(height: 48)),
                    SizedBox(width: 8),
                    // TODO intl
                    Text('OR'),
                    SizedBox(width: 8),
                    Expanded(child: Divider(height: 48)),
                  ],
                ),
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
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _save() {
    controller.onChanged(controller.name.value.text, controller.avatarUrl.value.text);
    Get.back();
  }
}
