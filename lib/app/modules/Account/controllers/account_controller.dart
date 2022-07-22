// TODO remove this line
// ignore_for_file: unnecessary_overrides

import 'package:dungeon_paper/app/data/services/auth_service.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:get/get.dart';

class AccountController extends GetxController with UserServiceMixin, AuthServiceMixin {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
