import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/app/widgets/atoms/password_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/user_avatar.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/core/utils/email_address_validator.dart';
import 'package:dungeon_paper/core/utils/password_validator.dart';
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

    final builder = ItemBuilder.lazyChildren(
      children: [
        () => Center(
              child: Obx(
                () => UserAvatar(
                  user: controller.user,
                  size: 100,
                ),
              ),
            ),
        () => const SizedBox(height: 8),
        () => const Divider(),
        () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
              child: Text(
                S.current.accountCategoryDetails,
                style: textTheme.caption,
              ),
            ),
        () => Obx(
              () => ListTile(
                title: Text(S.current.accountChangeDisplayNameTitle),
                subtitle: Text(controller.user.displayName),
                leading: const Icon(Icons.abc),
                onTap: _openNameDialog,
              ),
            ),
        () => Obx(
              () => ListTile(
                title: Text(S.current.accountChangeImageTitle),
                subtitle: Text(S.current.accountChangeImageSubtitle),
                leading: controller.uploading.value
                    ? const SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 3,
                        ),
                      )
                    : const Icon(Icons.image),
                enabled: !controller.uploading.value,
                onTap: !controller.uploading.value ? () => _uploadImage(context) : null,
              ),
            ),
        () => Obx(
              () => ListTile(
                title: Text(S.current.accountChangeEmailTitle),
                subtitle: Text(controller.user.email),
                onTap: _openEmailDialog,
                leading: const Icon(Icons.email),
              ),
            ),
        () => ListTile(
              title: Text(S.current.accountChangePasswordTitle),
              subtitle: Text(S.current.accountChangePasswordSubtitle),
              onTap: _openPasswordDialog,
              leading: const Icon(Icons.key),
            ),
        () => const Divider(),
        () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
              child: Text(
                S.current.accountCategorySocials,
                style: textTheme.caption,
              ),
            ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(controller.user.username),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemBuilder: builder.itemBuilder,
        itemCount: builder.itemCount,
      ),
    );
  }

  void _openNameDialog() {
    Get.dialog(
      SingleTextFieldDialog(
        title: S.current.accountChangeDisplayNameTitle,
        inputLabel: S.current.accountChangeDisplayNameLabel,
        inputHint: S.current.accountChangeDisplayNameHint,
        value: controller.user.displayName,
        onSave: (displayName) {
          Get.rawSnackbar(message: S.current.accountChangeDisplayNameSuccess);
          controller.userService.updateUser(
            controller.user.copyWith(displayName: displayName),
          );
        },
      ),
    );
  }

  void _openEmailDialog() {
    Get.dialog(
      SingleTextFieldDialog(
        title: S.current.accountChangeEmailTitle,
        inputLabel: S.current.accountChangeEmailLabel,
        inputHint: S.current.accountChangeEmailHint,
        value: controller.user.email,
        validator: EmailAddressValidator().validator,
        onSave: (email) {
          // TODO move user data to new document
          Get.rawSnackbar(message: S.current.accountChangeEmailSuccess);
          controller.authService.fbUser.value!.updateEmail(email);
          controller.userService.updateUser(
            controller.user.copyWith(email: email),
          );
        },
      ),
    );
  }

  void _openPasswordDialog() {
    Get.dialog(
      PasswordFieldDialog(
        onSave: (password) {
          Get.rawSnackbar(message: S.current.accountChangePasswordSuccess);
          controller.authService.fbUser.value!.updatePassword(password);
        },
      ),
    );
  }

  void _uploadImage(BuildContext context) {
    controller.uploadPhoto(context);
  }
}

class SingleTextFieldDialog extends StatefulWidget {
  SingleTextFieldDialog({
    super.key,
    required this.title,
    required this.inputLabel,
    required this.inputHint,
    required String value,
    required this.onSave,
    this.infoText,
    this.validator,
  }) : value = TextEditingController(text: value);

  final String title;
  final String inputLabel;
  final String inputHint;
  final String? infoText;
  final TextEditingController value;
  final void Function(String) onSave;
  final String? Function(String?)? validator;

  @override
  State<SingleTextFieldDialog> createState() => _SingleTextFieldDialogState();
}

class _SingleTextFieldDialogState extends State<SingleTextFieldDialog> {
  final GlobalKey<FormState> formKey = GlobalKey();
  late bool valid;

  @override
  initState() {
    super.initState();
    valid = formKey.currentState?.validate() ?? false;

    widget.value.addListener(() {
      valid = formKey.currentState?.validate() ?? false;
    });
  }

  @override
  void dispose() {
    widget.value.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: SizedBox(
        width: 400,
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            shrinkWrap: true,
            children: [
              TextFormField(
                controller: widget.value,
                validator: (value) {
                  if (widget.validator != null) {
                    final res = widget.validator!(value);
                    if (res != null) {
                      return res;
                    }
                  }
                  return StringValidator(minLength: 1).validator(value);
                },
                decoration: InputDecoration(
                  labelText: widget.inputLabel,
                  hintText: widget.inputHint,
                ),
              ),
              if (widget.infoText != null) HelpText(text: widget.infoText!),
            ],
          ),
        ),
      ),
      actions: DialogControls.save(
        context,
        onSave: () {
          widget.onSave(widget.value.text);
          Get.back();
        },
        onCancel: () => Get.back(),
      ),
    );
  }
}

@immutable
class PasswordFieldDialog extends StatefulWidget {
  const PasswordFieldDialog({
    super.key,
    required this.onSave,
  });

  final void Function(String) onSave;

  @override
  State<PasswordFieldDialog> createState() => _PasswordFieldDialogState();
}

class _PasswordFieldDialogState extends State<PasswordFieldDialog> {
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirm = TextEditingController();
  bool valid = false;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  initState() {
    super.initState();
    valid = formKey.currentState?.validate() ?? false;

    password.addListener(validate);
    passwordConfirm.addListener(validate);
  }

  @override
  void dispose() {
    password.dispose();
    passwordConfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.current.accountChangePasswordTitle),
      content: SizedBox(
        width: 400,
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            shrinkWrap: true,
            children: [
              PasswordField(
                controller: password,
                validator: PasswordValidator().validator,
                decoration: InputDecoration(
                  labelText: S.current.accountChangePasswordLabel,
                  hintText: S.current.accountChangePasswordHint,
                ),
              ),
              const SizedBox(height: 16),
              PasswordField(
                controller: passwordConfirm,
                validator: _passwordValidator,
                decoration: InputDecoration(
                  labelText: S.current.accountChangePasswordConfirmLabel,
                  hintText: S.current.accountChangePasswordConfirmHint,
                ),
              ),
            ],
          ),
        ),
      ),
      actions: DialogControls.save(
        context,
        onSave: valid
            ? () {
                widget.onSave(password.text);
                Get.back();
              }
            : null,
        onCancel: () => Get.back(),
      ),
    );
  }

  void validate() {
    setState(() {
      valid = password.text == passwordConfirm.text;
    });
  }

  String? _passwordValidator(String? _value) {
    if (password.text != passwordConfirm.text) {
      return S.current.signupPasswordValidationMatch;
    }
    return PasswordValidator().validator(_value);
  }
}
