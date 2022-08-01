import 'dart:io';

import 'package:dungeon_paper/app/widgets/atoms/labeled_divider.dart';
import 'package:dungeon_paper/app/widgets/atoms/password_field.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/password_validator.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
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
                  child: Column(
                    children: [
                      Text(
                        S.current.signinTitle,
                        style: textTheme.headline4,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        S.current.signinSubtitle,
                        style: textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: controller.loginWithGoogle,
                        label: Text(S.current.signinWithGoogleButton),
                        icon: const Icon(DwIcons.google),
                      ),
                      if (!kIsWeb && Platform.isMacOS || Platform.isIOS) ...[
                        const SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: controller.loginWithApple,
                          label: Text(S.current.signinWithAppleButton),
                          icon: const Icon(DwIcons.apple),
                        ),
                      ],
                      const SizedBox(height: 16),
                      LabeledDivider(label: Text(S.current.separatorOr)),
                      TextFormField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        decoration: InputDecoration(
                          filled: true,
                          label: Text(S.current.signupEmail),
                          // floatingLabelBehavior: FloatingLabelBehavior.auto,
                          hintText: S.current.signupEmailPlaceholder,
                        ),
                        validator: (email) => email == null || EmailValidator.validate(email)
                            ? null
                            : S.current.signupEmailValidation,
                      ),
                      const SizedBox(height: 16),
                      PasswordField(
                        controller: controller.password,
                        obscureText: true,
                        autofillHints: const [AutofillHints.password],
                        decoration: InputDecoration(
                          filled: true,
                          label: Text(S.current.signupPassword),
                          hintText: S.current.signupPasswordPlaceholder,
                          // floatingLabelBehavior: FloatingLabelBehavior.auto,
                        ),
                        validator: PasswordValidator().validator,
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => ElevatedButton.icon(
                          onPressed: controller.valid ? controller.loginWithPassword : null,
                          label: Text(S.current.signinButton, textScaleFactor: 1.5),
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
                      ),
                      const Divider(height: 48),
                      ElevatedButton.icon(
                        onPressed: () => launch(
                          'https://dungeonpaper.app/privacy-policy.html?utm_medium=app&utm_source=login',
                        ),
                        label: Text(S.current.privacyPolicy),
                        icon: const Icon(Icons.lock),
                      ),
                      ElevatedButton.icon(
                        onPressed: () => launch(
                          // TODO make changelog view that uses current version
                          'https://dungeonpaper.app/changelog.html',
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
    );
  }
}
