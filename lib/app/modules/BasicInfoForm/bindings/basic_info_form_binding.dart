import 'package:get/get.dart';

import '../controllers/basic_info_form_controller.dart';

class BasicInfoFormBinding extends Bindings {
  BasicInfoFormBinding({
    this.name = '',
    this.avatarUrl = '',
  });

  final String name;
  final String avatarUrl;
  @override
  void dependencies() {
    Get.lazyPut<BasicInfoFormController>(
      () => BasicInfoFormController(
        name: name,
        avatarUrl: avatarUrl,
      ),
    );
  }
}
