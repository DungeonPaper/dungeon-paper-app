import 'package:get/get.dart';

import '../controllers/send_feedback_controller.dart';

class SendFeedbackBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendFeedbackController>(
      () => SendFeedbackController(),
    );
  }
}
