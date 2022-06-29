import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UniversalSearchController extends GetxController {
  final search = TextEditingController(text: '');

  @override
  void onInit() {
    super.onInit();
    search.addListener(update);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    search.removeListener(update);
  }
}
