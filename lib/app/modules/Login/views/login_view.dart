import 'package:dungeon_paper/app/widgets/atoms/labeled_divider.dart';
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
      appBar: AppBar(
        // title: Text('LoginView'),
        centerTitle: true,
      ),
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
                      decoration: const InputDecoration(
                        filled: true,
                        // TODO intl
                        label: Text('Email'),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      // TODO intl
                      validator: (email) => email == null || EmailValidator.validate(email)
                          ? null
                          : 'Email must be valid',
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: controller.password,
                      obscureText: true,
                      autofillHints: const [AutofillHints.password],
                      decoration: const InputDecoration(
                        filled: true,
                        // TODO intl
                        label: Text('Password'),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                      ),
                      validator: PasswordValidator.getMessage,
                    ),
                    Obx(
                      () => ElevatedButton(
                        onPressed: controller.valid ? controller.loginWithPassword : null,
                        // TODO intl
                        child: const Text('Sign in'),
                      ),
                    ),
                    LabeledDivider(label: Text(S.current.separatorOr)),
                    ElevatedButton(
                      onPressed: controller.loginWithGoogle,
                      child: const Text('Sign in with Google'),
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
