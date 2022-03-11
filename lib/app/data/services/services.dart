import 'package:dungeon_paper/app/data/services/repository_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'character_service.dart';

Future<void> initServices() async {
  debugPrint('Starting services...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => Future.value(CharacterService().init()));
  await Get.putAsync(() => Future.value(RepositoryService().init()));
  debugPrint('All services started');
}
