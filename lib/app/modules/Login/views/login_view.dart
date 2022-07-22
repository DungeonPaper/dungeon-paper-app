import 'package:dungeon_paper/app/widgets/atoms/labeled_divider.dart';
import 'package:dungeon_paper/app/widgets/atoms/password_field.dart';
import 'package:dungeon_paper/core/dw_icons.dart';
import 'package:dungeon_paper/core/utils/password_validator.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: AutofillGroup(
                child: Column(
                  children: [
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
                    LabeledDivider(label: Text(S.current.separatorOr)),
                    ElevatedButton.icon(
                      onPressed: controller.loginWithGoogle,
                      label: Text(S.current.signinWithGoogleButton),
                      icon: const Icon(DwIcons.google),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
