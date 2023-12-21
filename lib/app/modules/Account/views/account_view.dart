import 'package:dungeon_paper/app/widgets/atoms/help_text.dart';
import 'package:dungeon_paper/app/widgets/atoms/password_field.dart';
import 'package:dungeon_paper/app/widgets/atoms/user_avatar.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_delete_account_dialog.dart';
import 'package:dungeon_paper/app/widgets/dialogs/confirm_unlink_provider_dialog.dart';
import 'package:dungeon_paper/app/widgets/molecules/dialog_controls.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/core/utils/builder_utils.dart';
import 'package:dungeon_paper/core/utils/email_address_validator.dart';
import 'package:dungeon_paper/core/utils/password_validator.dart';
import 'package:dungeon_paper/core/utils/string_validator.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/dw_icons.dart';
import '../../../../core/http/api.dart';
import '../../../model_utils/user_utils.dart';
import '../controllers/account_controller.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    final builder = ItemBuilder.lazyChildren(
      children: [
        () => Center(
              child: Consumer<AccountController>(
                builder: (context, controller, _) => UserAvatar(
                  user: controller.user,
                  size: 100,
                ),
              ),
            ),
        () => const SizedBox(height: 8),
        () => const Divider(),
        () => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
              child: Text(
                tr.account.details.title,
                style: textTheme.bodySmall,
              ),
            ),
        () => Consumer<AccountController>(
              builder: (context, controller, _) => ListTile(
                title: Text(tr.account.details.displayName.title),
                subtitle: Text(controller.user.displayName),
                leading: const Icon(Icons.abc),
                onTap: () => _openNameDialog(context),
              ),
            ),
        () => Consumer<AccountController>(
              builder: (context, controller, _) => ListTile(
                title: Text(tr.account.details.image.title),
                subtitle: Text(tr.account.details.image.subtitle),
                leading: controller.uploading
                    ? const SizedBox.square(
                        dimension: 24,
                        child: CircularProgressIndicator.adaptive(
                          strokeWidth: 3,
                        ),
                      )
                    : const Icon(Icons.image),
                enabled: !controller.uploading,
                onTap:
                    !controller.uploading ? () => _uploadImage(context) : null,
              ),
            ),
        () => Consumer<AccountController>(
              builder: (context, controller, _) => ListTile(
                title: Text(tr.account.details.email.title),
                subtitle: Text(controller.user.email),
                onTap: () => _openEmailDialog(context),
                leading: const Icon(Icons.email),
              ),
            ),
        () => ListTile(
              title: Text(tr.account.details.password.title),
              subtitle: Text(tr.account.details.password.subtitle),
              onTap: () => _openPasswordDialog(context),
              leading: const Icon(Icons.key),
            ),
        () => const Divider(),
        () => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 8),
              child: Text(
                tr.account.providers.title,
                style: textTheme.bodySmall,
              ),
            ),
        // ...(controller.authProvider.fbUser?.providerData ?? []).map((provider) {
        ...([
          // ProviderName.password,
          // if (PlatformHelper.canUseGoogleSignIn)
          ProviderName.google,
          // if (PlatformHelper.canUseAppleSignIn)
          ProviderName.apple
        ]).map(
          (provider) {
            return () => Consumer<AccountController>(
                  builder: (context, controller, _) => ListTile(
                    title: Text(tr.auth.providers.name(provider.name)),
                    // subtitle: Text(provider.),
                    leading: Icon(DwIcons.providerIcon(provider)),
                    subtitle: !PlatformHelper.canUseProvider(provider)
                        ? Text(
                            tr.auth.providers.unusable(
                                tr.auth.providers.name(provider.name)),
                            textScaler: const TextScaler.linear(0.8),
                          )
                        : null,
                    trailing: ElevatedButton(
                      onPressed: providerCount(controller) > 1
                          ? isProviderLinked(controller, provider)
                              ? unlinkProvider(context, provider)
                              : PlatformHelper.canUseProvider(provider)
                                  ? linkProvider(context, provider)
                                  : null
                          : null,
                      child: Text(
                        isProviderLinked(controller, provider)
                            ? tr.auth.providers.unlink
                            : tr.auth.providers.link,
                      ),
                    ),
                  ),
                );
          },
        ),
        // delete account
        () => Consumer<AccountController>(
              builder: (context, controller, _) => ListTile(
                title: Text(tr.account.deleteAccount.title),
                leading: const Icon(Icons.delete_forever),
                onTap: () => awaitDeleteAccountConfirmation(
                  context,
                  () {
                    api.requests.sendFeedback(
                      email: controller.user.email,
                      subject: 'Account Deletion Request',
                      body:
                          'Automated: Request Account Deletion for ${controller.user.email}',
                      username: controller.user.username,
                    );
                    // A deletion request for your account was sent successfully
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(tr.account.deleteAccount.success)));
                  },
                ),
              ),
            ),
        // () => const SizedBox(height: 32),
        // () => Center(
        //       child: Padding(
        //         padding: const EdgeInsets.all(16.0),
        //         child: OutlinedButton(
        //           style: ButtonThemes.errorOutlined(context)!.copyWith(
        //             padding: const MaterialStatePropertyAll(
        //                 EdgeInsets.symmetric(horizontal: 16)),
        //             minimumSize: const MaterialStatePropertyAll(
        //               Size(100, 28),
        //             ),
        //           ),
        //           child: Text(tr.account.deleteAccount.title),
        //           onPressed: () =>
        //               awaitDeleteAccountConfirmation(context, () => null),
        //         ),
        //       ),
        //     ),
      ],
    );

    return Consumer<AccountController>(
      builder: (context, controller, _) => Scaffold(
        appBar: AppBar(
          title: Text(controller.user.username),
          centerTitle: true,
        ),
        body: builder.asListView(),
      ),
    );
  }

  int providerCount(AccountController controller) {
    return controller.authProvider.fbUser?.providerData.length ?? 0;
  }

  bool isProviderLinked(AccountController controller, ProviderName provider) =>
      controller.authProvider.fbUser?.providerData
          .any((pr) => pr.providerId == domainFromProviderName(provider)) ==
      true;

  void _openNameDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final controller =
            Provider.of<AccountController>(context, listen: false);
        return SingleTextFieldDialog(
          title: tr.account.details.displayName.title,
          inputLabel: tr.account.details.displayName.label,
          inputHint: tr.account.details.displayName.placeholder,
          value: controller.user.displayName,
          onSave: (displayName) {
            controller.userProvider.updateUser(
              controller.user.copyWith(displayName: displayName),
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr.account.details.displayName.success),
              ),
            );
          },
        );
      },
    );
  }

  void _openEmailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final controller =
            Provider.of<AccountController>(context, listen: false);
        return SingleTextFieldDialog(
          title: tr.account.details.email.title,
          inputLabel: tr.account.details.email.label,
          inputHint: tr.account.details.email.placeholder,
          value: controller.user.email,
          validator: EmailAddressValidator().validator,
          onSave: (email) => controller.updateEmail(context, email),
        );
      },
    );
  }

  void _openPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        final controller =
            Provider.of<AccountController>(context, listen: false);
        return PasswordFieldDialog(
          onSave: (password) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr.account.details.password.success),
              ),
            );
            controller.authProvider.fbUser!.updatePassword(password);
          },
        );
      },
    );
  }

  void _uploadImage(BuildContext context) {
    final controller = Provider.of<AccountController>(context, listen: false);
    controller.uploadPhoto(context);
  }

  Future<void> Function() unlinkProvider(
          BuildContext context, ProviderName provider) =>
      () => awaitUnlinkProviderConfirmation(
            context,
            provider,
            () {
              final controller =
                  Provider.of<AccountController>(context, listen: false);
              controller.authProvider.logoutFromProvider(provider);
              controller.authProvider.fbUser!
                  .unlink(domainFromProviderName(provider));
            },
          );

  Future<void> Function() linkProvider(
          BuildContext context, ProviderName provider) =>
      () async {
        final controller =
            Provider.of<AccountController>(context, listen: false);
        final cred =
            await controller.authProvider.getProviderCredential(provider);
        controller.authProvider.fbUser!.linkWithCredential(cred);
      };
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
          Navigator.of(context).pop();
        },
        onCancel: () => Navigator.of(context).pop(),
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
      title: Text(tr.account.details.password.title),
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
                  labelText: tr.account.details.password.label,
                  hintText: tr.account.details.password.placeholder,
                ),
              ),
              const SizedBox(height: 16),
              PasswordField(
                controller: passwordConfirm,
                validator: _passwordValidator,
                decoration: InputDecoration(
                  labelText: tr.account.details.password.confirm.label,
                  hintText: tr.account.details.password.confirm.placeholder,
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
                Navigator.of(context).pop();
              }
            : null,
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  void validate() {
    setState(() {
      valid = password.text == passwordConfirm.text;
    });
  }

  String? _passwordValidator(String? value) {
    if (password.text != passwordConfirm.text) {
      return tr.account.details.password.error;
    }
    return PasswordValidator().validator(value);
  }
}
