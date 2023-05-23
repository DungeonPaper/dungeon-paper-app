import 'package:get/get.dart';

import '../controllers/campaigns_list_controller.dart';

class CampaignsListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CampaignsListController>(
      () => CampaignsListController(),
    );
  }
}
