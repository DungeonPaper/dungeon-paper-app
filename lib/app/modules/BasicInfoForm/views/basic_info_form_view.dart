import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/themes/colors.dart';
import 'package:dungeon_paper/app/widgets/atoms/advanced_floating_action_button.dart';
import 'package:dungeon_paper/app/widgets/atoms/character_avatar.dart';
import 'package:dungeon_paper/app/widgets/atoms/confirm_exit_view.dart';
import 'package:dungeon_paper/app/widgets/atoms/hyperlink.dart';
import 'package:dungeon_paper/app/widgets/atoms/labeled_divider.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/core/utils/content_generators/character_name_generator.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/basic_info_form_controller.dart';

class BasicInfoFormView extends GetView<BasicInfoFormController>
    with UserServiceMixin {
  const BasicInfoFormView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Obx(
      () => ConfirmExitView(
        dirty: controller.dirty.value,
        child: Scaffold(
          appBar: AppBar(
            title: Text(tr.basicInfo.title),
            centerTitle: true,
          ),
          floatingActionButton: AdvancedFloatingActionButton.extended(
            onPressed: _save,
            label: Text(tr.generic.save),
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
                  validator: (val) =>
                      val == null || val.isEmpty ? 'Cannot be empty' : null,
                  // onChanged: (val) => updateControllers(),
                  textCapitalization: TextCapitalization.words,
                  decoration: InputDecoration(
                    labelText: tr.basicInfo.form.name.label,
                    hintText: tr.basicInfo.form.name.placeholder,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: IconButton(
                      tooltip: PlatformHelper.byInteractionType(
                        context,
                        touch: tr.basicInfo.form.name.random.tooltip.touch,
                        mouse: tr.basicInfo.form.name.random.tooltip.click,
                      ),
                      icon: const Icon(DwIcons.dice_d6_numbered),
                      onPressed: () {
                        controller.name.value.text =
                            CharacterNameGenerator().generate();
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
                            onPressed: controller.isUploading
                                ? null
                                : () => controller.startUploadFlow(context),
                            icon: const Icon(Icons.upload_file),
                            label: Text(tr.basicInfo.form.photo.change),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: controller.isUploading
                                ? null
                                : controller.resetPhoto,
                            icon: const Icon(Icons.close),
                            label: Text(tr.basicInfo.form.photo.remove),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (!controller.hasPhotoFile)
                  SizedBox(
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed:
                          !controller.isUploading && userService.isLoggedIn
                              ? () => controller.startUploadFlow(context)
                              : null,
                      icon: const Icon(Icons.upload_file),
                      label: Text(tr.basicInfo.form.photo.choose),
                    ),
                  ),
                if (userService.isGuest) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          const WidgetSpan(
                            child: Padding(
                              padding: EdgeInsets.only(right: 4),
                              child: Icon(Icons.warning,
                                  color: DwColors.warning, size: 16),
                            ),
                          ),
                          TextSpan(
                              text: tr.basicInfo.form.photo.guest.prefix),
                          Hyperlink.textSpan(
                            context,
                            tr.basicInfo.form.photo.guest.label,
                            onTap: () => Get.toNamed(Routes.login),
                          ),
                          TextSpan(text: tr.basicInfo.form.photo.guest.suffix),
                        ],
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  )
                ],
                LabeledDivider(
                  label: controller.isUploading
                      ? Row(
                          children: [
                            const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 3),
                            ),
                            const SizedBox(width: 8),
                            Text(tr.basicInfo.form.photo.uploading),
                          ],
                        )
                      : Text(tr.basicInfo.form.photo.orSeparator),
                ),
                TextFormField(
                  controller: controller.avatarUrl.value,
                  textInputAction: TextInputAction.done,
                  enabled: !controller.isUploading,
                  // onChanged: (val) => updateControllers(),
                  decoration: InputDecoration(
                    labelText: tr.basicInfo.form.photo.url.label,
                    hintText: tr.basicInfo.form.photo.url.placeholder,
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
    controller.onChanged(
        controller.name.value.text, controller.avatarUrl.value.text);
    Get.back();
  }
}

