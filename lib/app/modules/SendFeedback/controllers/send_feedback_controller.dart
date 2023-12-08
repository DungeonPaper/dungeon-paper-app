import 'package:dungeon_paper/app/data/services/user_service.dart';
import 'package:dungeon_paper/core/http/api.dart';
import 'package:dungeon_paper/i18n.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendFeedbackController extends GetxController with UserServiceMixin {
  final email = TextEditingController().obs;
  final title = TextEditingController().obs;
  final body = TextEditingController().obs;
  final sending = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey();

  Future<void> send() async {
    sending.value = true;
    await api.requests.sendFeedback(
      email: user.isLoggedIn ? user.email : email.value.text,
      subject: title.value.text,
      body: body.value.text,
      username: user.isLoggedIn ? user.username : null,
    );
    Get.back();
    Get.rawSnackbar(
      title: tr.feedback.success.title,
      message: tr.feedback.success.message,
    );
  }

  @override
  void onInit() {
    super.onInit();
    for (var element in [email, title, body]) {
      element.value.addListener(() {
        element.refresh();
      });
    }
  }

  @override
  void onClose() {
    for (var element in [email, title, body]) {
      element.value.dispose();
    }
    super.onClose();
  }
}
