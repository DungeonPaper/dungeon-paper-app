import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicInfoFormController extends GetxController {
  BasicInfoFormController({
    String name = '',
    String avatarUrl = '',
  })  : name = TextEditingController(text: name).obs,
        avatarUrl = TextEditingController(text: avatarUrl).obs;

  final Rx<TextEditingController> name;
  final Rx<TextEditingController> avatarUrl;
}
