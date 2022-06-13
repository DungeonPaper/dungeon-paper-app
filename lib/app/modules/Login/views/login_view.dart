import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/widgets/atoms/LabeledDivider.dart';
import 'package:dungeon_paper/generated/l10n.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> with AuthServiceMixin {
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
                      controller: controller.username,
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
                      // TODO extract to password validator (or use old one)
                      validator: (password) => password == null || password.length >= 8
                          ? null
                          : 'Password must contain at least 8 characters',
                    ),
                    Obx(
                      () => ElevatedButton(
                        onPressed: controller.valid
                            ? () => authService.loginWithPassword(
                                  email: controller.username.text,
                                  password: controller.password.text,
                                )
                            : null,
                        // TODO intl
                        child: const Text('Sign in'),
                      ),
                    ),
                    LabeledDivider(label: Text(S.current.separatorOr)),
                    ElevatedButton(
                      onPressed: () => authService.loginWithGoogle(),
                      child: Text('Sign in with Google'),
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
