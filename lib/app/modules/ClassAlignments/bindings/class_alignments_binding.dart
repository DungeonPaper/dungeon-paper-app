import 'package:get/get.dart';

import '../controllers/class_alignments_controller.dart';

class ClassAlignmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassAlignmentsController>(
      () => ClassAlignmentsController(),
    );
  }
}
