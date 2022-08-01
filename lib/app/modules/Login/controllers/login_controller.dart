import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class LoginController extends GetxController
    with AuthServiceMixin, LoadingServiceMixin, CharacterServiceMixin {
  final formKey = GlobalKey<FormState>(debugLabel: 'loginForm');
  final email = TextEditingController();
  final password = TextEditingController();
  final _valid = false.obs;

  bool get valid => _valid.value;

  void _loginWrapper(Future<void> Function() cb) async {
    try {
      loadingService.loadingUser = true;
      loadingService.loadingCharacters = false;
      await cb();
      Get.offAllNamed(Routes.home);
    } catch (e) {
      Sentry.captureException(e);
      printError(info: e.toString());
      loadingService.loadingUser = false;
      loadingService.loadingCharacters = false;
      // TODO intl
      Get.rawSnackbar(message: 'Login failed');
    }
  }

  void loginWithPassword() async {
    _loginWrapper(
      () => authService.loginWithPassword(email: email.text, password: password.text),
    );
  }

  void loginWithGoogle() async {
    _loginWrapper(
      () => authService.loginWithGoogle(),
    );
  }

  void loginWithApple() async {
    _loginWrapper(
      () => authService.loginWithApple(),
    );
  }

  @override
  void onInit() {
    super.onInit();
    email.addListener(validate);
    password.addListener(validate);
  }

  @override
  void onClose() {
    email.removeListener(validate);
    password.removeListener(validate);
  }

  bool validate() {
    _valid.value = formKey.currentState?.validate() ?? false;
    _valid.refresh();
    return _valid.value;
  }
}
