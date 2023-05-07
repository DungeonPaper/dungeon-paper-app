import 'package:dungeon_paper/app/widgets/atoms/labeled_divider.dart';
import 'package:dungeon_paper/app/widgets/atoms/password_field.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/password_validator.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.appName),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: AutofillGroup(
                child: SizedBox(
                  width: 400,
                  child: Obx(
                    () => Column(
                      children: [
                        Text(
                          controller.isLogin ? S.current.signinTitle : S.current.signupTitle,
                          style: textTheme.headlineMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.isLogin ? S.current.signinSubtitle : S.current.signupSubtitle,
                          style: textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        ...<Widget>[
                          if (PlatformHelper.canUseGoogleSignIn) ...[
                            ElevatedButton.icon(
                              onPressed: !controller.loadingService.loadingUser ? controller.loginWithGoogle : null,
                              label: Text(controller.isLogin
                                  ? S.current.signinWithButton(S.current.signinProvider('google'))
                                  : S.current.signupWithButton(S.current.signinProvider('google'))),
                              icon: const Icon(DwIcons.google),
                            ),
                          ],
                          if (PlatformHelper.canUseAppleSignIn) ...[
                            ElevatedButton.icon(
                              onPressed: !controller.loadingService.loadingUser ? controller.loginWithApple : null,
                              label: Text(controller.isLogin
                                  ? S.current.signinWithButton(S.current.signinProvider('apple'))
                                  : S.current.signupWithButton(S.current.signinProvider('apple'))),
                              icon: const Icon(DwIcons.apple),
                            ),
                          ],
                        ].joinObjects(const SizedBox(height: 8)),
                        const SizedBox(height: 16),
                        LabeledDivider(label: Text(S.current.separatorOr)),
                        TextFormField(
                          controller: controller.email,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          decoration: InputDecoration(
                            filled: true,
                            label: Text(S.current.signupEmail),
                            enabled: !controller.loadingService.loadingUser,
                            // floatingLabelBehavior: FloatingLabelBehavior.auto,
                            hintText: S.current.signupEmailPlaceholder,
                          ),
                          validator: (email) =>
                              email == null || EmailValidator.validate(email) ? null : S.current.signupEmailValidation,
                        ),
                        const SizedBox(height: 16),
                        PasswordField(
                          controller: controller.password,
                          obscureText: true,
                          autofillHints: [controller.isSignUp ? AutofillHints.newPassword : AutofillHints.password],
                          decoration: InputDecoration(
                            filled: true,
                            label: Text(S.current.signupPassword),
                            hintText: S.current.signupPasswordPlaceholder,
                            enabled: !controller.loadingService.loadingUser,
                            // floatingLabelBehavior: FloatingLabelBehavior.auto,
                          ),
                          validator: PasswordValidator().validator,
                        ),
                        if (controller.isSignUp) ...[
                          const SizedBox(height: 16),
                          PasswordField(
                            controller: controller.passwordConfirm,
                            obscureText: true,
                            autofillHints: const [AutofillHints.newPassword],
                            decoration: InputDecoration(
                              filled: true,
                              label: Text(S.current.signupPasswordConfirm),
                              hintText: S.current.signupPasswordConfirmPlaceholder,
                              enabled: !controller.loadingService.loadingUser,
                              // floatingLabelBehavior: FloatingLabelBehavior.auto,
                            ),
                            validator: (pwd) =>
                                PasswordValidator().validator(pwd) ??
                                (pwd == controller.password.text ? null : S.current.signupPasswordValidationMatch),
                          ),
                        ],
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: controller.valid
                              ? controller.isLogin
                                  ? controller.loginWithPassword
                                  : controller.signUp
                              : null,
                          label: Text(
                            controller.isLogin ? S.current.signinButton : S.current.signupButton,
                            textScaleFactor: 1.5,
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          icon: controller.loadingService.loadingUser
                              ? const SizedBox.square(
                                  dimension: 24,
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : const Icon(Icons.login, size: 24),
                        ),
                        const Divider(height: 48),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Text(S.current.signinGoToSignupLabel),
                            ElevatedButton(
                              onPressed: controller.toggleSignup,
                              child: Text(
                                S.current.signinGoToSignupButton,
                              ),
                            )
                          ],
                        ),
                        const Divider(height: 48),
                        ElevatedButton.icon(
                          onPressed: () => launchUrl(
                            Uri.parse('https://dungeonpaper.app/privacy-policy.html?utm_medium=app&utm_source=login'),
                          ),
                          label: Text(S.current.privacyPolicy),
                          icon: const Icon(Icons.lock),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () => launchUrl(
                            // TODO make changelog view that uses current version
                            Uri.parse('https://dungeonpaper.app/changelog.html'),
                          ),
                          label: Text(S.current.whatsNew),
                          icon: const Icon(Icons.new_releases),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
