import 'dart:math';

import 'package:dungeon_paper/app/data/models/user.dart';
import 'package:dungeon_paper/core/pref_keys.dart';
import 'package:dungeon_paper/core/shared_preferences.dart';
import 'package:dungeon_paper/core/storage_handler/storage_handler.dart';
import 'package:dungeon_paper/core/utils/date_utils.dart';
import 'package:dungeon_paper/core/utils/enums.dart';
import 'package:dungeon_world_data/dungeon_world_data.dart' as dw;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/character.dart';
import '../models/character_stats.dart';
import '../models/meta.dart';
import '../models/move.dart';
import '../models/spell.dart';
import '../models/user.dart';

class UserService extends GetxService {
  final _current = User.guest().obs;
  User get current => _current.value;

  Future<UserService> init() async => this;
}

mixin UserServiceMixin {
  static UserService get userService => Get.find();
}
