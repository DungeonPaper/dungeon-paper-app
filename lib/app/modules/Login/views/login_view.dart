import 'package:dungeon_paper/app/data/services/loading_provider.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:dungeon_paper/app/widgets/atoms/labeled_divider.dart';
import 'package:dungeon_paper/app/widgets/atoms/password_field.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/platform_helper.dart';
import 'package:dungeon_paper/core/utils/list_utils.dart';
import 'package:dungeon_paper/core/utils/password_validator.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.app.name),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Consumer<LoginController>(
              builder: (context, controller, _) => Form(
                key: controller.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: AutofillGroup(
                  child: SizedBox(
                    width: 400,
                    child: LoadingProvider.consumer(
                      (context, loadingProvider, _) {
                        final providerSignIns = <Widget>[
                          if (PlatformHelper.canUseGoogleSignIn) ...[
                            ElevatedButton.icon(
                              onPressed: !loadingProvider.loadingUser
                                  ? () => controller.loginWithGoogle(context)
                                  : null,
                              label: Text(
                                controller.isLogin
                                    ? tr.auth.providers.loginWith(
                                        tr.auth.providers.name('google'),
                                      )
                                    : tr.auth.providers.signupWith(
                                        tr.auth.providers.name('google'),
                                      ),
                              ),
                              icon: const Icon(DwIcons.google),
                            ),
                          ],
                          if (PlatformHelper.canUseAppleSignIn) ...[
                            ElevatedButton.icon(
                              onPressed: !loadingProvider.loadingUser
                                  ? () => controller.loginWithApple(context)
                                  : null,
                              label: Text(
                                controller.isLogin
                                    ? tr.auth.providers.loginWith(
                                        tr.auth.providers.name('apple'),
                                      )
                                    : tr.auth.providers.signupWith(
                                        tr.auth.providers.name('apple'),
                                      ),
                              ),
                              icon: const Icon(DwIcons.apple),
                            ),
                          ],
                        ];
                        return Column(
                          children: [
                            Text(
                              controller.isLogin
                                  ? tr.auth.login.title
                                  : tr.auth.signup.title,
                              style: textTheme.headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.isLogin
                                  ? tr.auth.login.subtitle
                                  : tr.auth.signup.subtitle,
                              style: textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 24),
                            ...providerSignIns
                                .joinObjects(const SizedBox(height: 8)),
                            if (providerSignIns.isNotEmpty) ...[
                              const SizedBox(height: 16),
                              LabeledDivider(label: Text(tr.auth.orSeparator)),
                            ],
                            TextFormField(
                              controller: controller.email,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              decoration: InputDecoration(
                                filled: true,
                                label: Text(tr.auth.signup.email.label),
                                enabled: !loadingProvider.loadingUser,
                                // floatingLabelBehavior: FloatingLabelBehavior.auto,
                                hintText: tr.auth.signup.email.placeholder,
                              ),
                              validator: (email) => email == null ||
                                      EmailValidator.validate(email)
                                  ? null
                                  : tr.auth.signup.email.error,
                            ),
                            const SizedBox(height: 16),
                            PasswordField(
                              controller: controller.password,
                              obscureText: true,
                              autofillHints: [
                                controller.isSignUp
                                    ? AutofillHints.newPassword
                                    : AutofillHints.password
                              ],
                              decoration: InputDecoration(
                                filled: true,
                                label: Text(tr.auth.signup.password.label),
                                hintText: tr.auth.signup.password.placeholder,
                                enabled: !loadingProvider.loadingUser,
                                // floatingLabelBehavior: FloatingLabelBehavior.auto,
                              ),
                              validator: PasswordValidator().validator,
                            ),
                            //
                            // SIGN UP
                            //
                            if (controller.isSignUp) ...[
                              const SizedBox(height: 16),
                              PasswordField(
                                controller: controller.passwordConfirm,
                                obscureText: true,
                                autofillHints: const [
                                  AutofillHints.newPassword
                                ],
                                decoration: InputDecoration(
                                  filled: true,
                                  label: Text(
                                      tr.auth.signup.password.confirm.label),
                                  hintText: tr
                                      .auth.signup.password.confirm.placeholder,
                                  enabled: !loadingProvider.loadingUser,
                                  // floatingLabelBehavior: FloatingLabelBehavior.auto,
                                ),
                                validator: (pwd) {
                                  final controller =
                                      Provider.of<LoginController>(context,
                                          listen: false);
                                  final res = PasswordValidator().validator(pwd) ??
                                      (pwd == controller.password.text
                                          ? null
                                          : tr.auth.signup.password.confirm
                                              .error);
                                              debugPrint('pwd: $res');
                                              return res;
                                },
                              ),
                            ],
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: controller.valid
                                  ? controller.isLogin
                                      ? () =>
                                          controller.loginWithPassword(context)
                                      : () => controller.signUp(context)
                                  : null,
                              label: Text(
                                controller.isLogin
                                    ? tr.auth.login.button
                                    : tr.auth.signup.button,
                                textScaler: const TextScaler.linear(1.5),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 12),
                              ),
                              icon: loadingProvider.loadingUser
                                  ? const SizedBox.square(
                                      dimension: 24,
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    )
                                  : const Icon(Icons.login, size: 24),
                            ),
                            const Divider(height: 48),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(tr.auth.login.noAccount.label),
                                ElevatedButton(
                                  onPressed: controller.toggleSignup,
                                  child: Text(tr.auth.login.noAccount.button),
                                )
                              ],
                            ),
                            const Divider(height: 48),
                            ElevatedButton.icon(
                              onPressed: () => launchUrl(
                                Uri.parse(
                                  'https://dungeonpaper.app/privacy-policy.html?utm_medium=app&utm_source=login',
                                ),
                              ),
                              label: Text(tr.auth.privacyPolicy),
                              icon: const Icon(Icons.lock),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: () => Navigator.of(context).pushNamed(
                                Routes.changelog,
                              ),
                              label: Text(tr.auth.changelog),
                              icon: const Icon(Icons.new_releases),
                            ),
                          ],
                        );
                      },
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

