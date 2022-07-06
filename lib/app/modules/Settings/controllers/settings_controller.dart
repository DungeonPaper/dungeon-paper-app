import 'package:dungeon_paper/app/data/models/user_settings.dart';
import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController with UserServiceMixin {
  void updateSettings(UserSettings settings) {
    userService.updateUser(user.copyWith(settings: settings));
  }

  UserSettings get settings => user.settings;
}
