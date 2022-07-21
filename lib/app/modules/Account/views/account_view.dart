import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/app/widgets/atoms/user_avatar.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/utils/string_validator.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final children = [
      Center(
        child: Obx(
          () => UserAvatar(
            user: controller.user,
            size: 100,
          ),
        ),
      ),
      const SizedBox(height: 8),
      const Divider(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
        child: Text(
          S.current.accountCategoryDetails,
          style: textTheme.caption,
        ),
      ),
      Obx(
        () => ListTile(
          title: Text(S.current.accountChangeDisplayNameTitle),
          subtitle: Text(controller.user.displayName),
          onTap: _openNameDialog,
        ),
      ),
      ListTile(
        title: Text(S.current.accountChangeImageTitle),
        subtitle: Text(S.current.accountChangeImageSubtitle),
      ),
      ListTile(
        title: Text(S.current.accountEmailTitle),
        subtitle: Text(controller.user.email),
      ),
      ListTile(
        title: Text(S.current.accountPasswordTitle),
        subtitle: Text(S.current.accountPasswordSubtitle),
      ),
      const Divider(),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
        child: Text(
          S.current.accountCategorySocials,
          style: textTheme.caption,
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.user.username),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => children[index],
        itemCount: children.length,
      ),
    );
  }

  void _openNameDialog() {
    Get.dialog(
      _SingleValueDialog(
        title: S.current.accountChangeDisplayNameTitle,
        inputLabel: S.current.accountChangeDisplayNameLabel,
        inputHint: S.current.accountChangeDisplayNameHint,
        value: controller.user.displayName,
        onSave: (displayName) => controller.userService.updateUser(
          controller.user.copyWith(displayName: displayName),
        ),
      ),
    );
  }
}

class _SingleValueDialog extends StatelessWidget {
  _SingleValueDialog({
    super.key,
    required this.title,
    required this.inputLabel,
    required this.inputHint,
    required String value,
    required this.onSave,
    this.infoText,
  }) : value = TextEditingController(text: value);

  final String title;
  final String inputLabel;
  final String inputHint;
  final String? infoText;
  final TextEditingController value;
  final void Function(String) onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SizedBox(
        width: 400,
        child: ListView(
          shrinkWrap: true,
          children: [
            TextFormField(
              controller: value,
              validator: StringValidator(minLength: 1).validator,
              decoration: InputDecoration(
                labelText: inputLabel,
                hintText: inputHint,
              ),
            ),
            if (infoText != null) HelpText(text: infoText!),
          ],
        ),
      ),
      actions: DialogControls.save(
        context,
        onSave: () {
          onSave(value.text);
          Get.back();
        },
        onCancel: () => Get.back(),
      ),
    );
  }
}
