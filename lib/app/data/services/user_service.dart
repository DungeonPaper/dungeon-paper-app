
import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:get/get.dart';

import '../models/user.dart';

class UserService extends GetxService {
  final _current = User.guest().obs;
  User get current => _current.value;

  Future<UserService> init() async => this;
}

mixin UserServiceMixin {
  static UserService get userService => Get.find();
}
