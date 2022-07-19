import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/data/services/character_service.dart';
import 'package:dungeon_paper/app/data/services/loading_service.dart';
import 'package:dungeon_paper/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController
    with AuthServiceMixin, LoadingServiceMixin, CharacterServiceMixin {
  final formKey = GlobalKey<FormState>(debugLabel: 'loginForm');
  final email = TextEditingController();
  final password = TextEditingController();
  final _valid = false.obs;

  bool get valid => _valid.value;

  void loginWithPassword() async {
    loadingService.loadingUser = true;
    loadingService.loadingCharacters = false;
    await authService.loginWithPassword(email: email.text, password: password.text);
    Get.offAllNamed(Routes.home);
  }

  void loginWithGoogle() async {
    loadingService.loadingUser = true;
    loadingService.loadingCharacters = false;
    await authService.loginWithGoogle();
    Get.offAllNamed(Routes.home);
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
