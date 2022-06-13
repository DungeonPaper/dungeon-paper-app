import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>(debugLabel: 'loginForm');
  final username = TextEditingController();
  final password = TextEditingController();
  final _valid = false.obs;

  bool get valid => _valid.value;

  @override
  void onInit() {
    super.onInit();
    username.addListener(validate);
    password.addListener(validate);
  }

  @override
  void onClose() {
    username.removeListener(validate);
    password.removeListener(validate);
  }

  bool validate() => _valid.value = formKey.currentState?.validate() ?? false;
}
