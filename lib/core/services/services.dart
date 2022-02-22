import 'package:get/get.dart';

import 'character_service.dart';

Future<void> initServices() async {
  print('Starting services...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => Future.value(CharacterService().init()));
  print('All services started');
}
