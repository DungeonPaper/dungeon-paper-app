import 'package:dungeon_paper/core/http/api_requests/migration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MigrationController extends GetxController {
  final _username = TextEditingController(text: '').obs;
  final _language = 'EN'.obs;
  late final String email;

  TextEditingController get username => _username.value;
  String get language => _language.value;

  bool get isValid => username.text.isNotEmpty && language.isNotEmpty;

  void done() {
    Get.back(
      result: MigrationDetails(
        email: email,
        username: username.text,
        language: language,
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as MigrationArguments;
    email = args.email;
    username.addListener(_refreshUsername);
  }

  @override
  onClose() {
    username.removeListener(_refreshUsername);
    username.dispose();
    super.onClose();
  }

  _refreshUsername() {
    _username.refresh();
  }
}

class MigrationArguments {
  final String email;

  MigrationArguments({required this.email});
}
