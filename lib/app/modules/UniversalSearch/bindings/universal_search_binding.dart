import 'package:get/get.dart';

import '../controllers/universal_search_controller.dart';

class UniversalSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UniversalSearchController>(
      () => UniversalSearchController(),
    );
  }
}
