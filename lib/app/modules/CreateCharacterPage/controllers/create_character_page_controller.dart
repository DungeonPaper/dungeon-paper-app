import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CreateCharStep {
  information,
  charClass,
  stats,
  moves,
  alignment,
  gear,
  review,
}

class CreateCharacterPageController extends GetxController {
  final currentStep = PageController();
  final displayName = ''.obs;
  final bioDesc = ''.obs;
  final avatarUrl = ''.obs;

  final isValid = <CreateCharStep, bool>{
    CreateCharStep.information: false,
    CreateCharStep.charClass: false,
    CreateCharStep.stats: false,
    CreateCharStep.moves: false,
    CreateCharStep.alignment: false,
    CreateCharStep.gear: false,
    CreateCharStep.review: true,
  }.obs;

  void updateCharInfo({
    required String displayName,
    required String bioDesc,
    required String avatarUrl,
  }) {
    this.displayName.value = displayName;
    this.bioDesc.value = bioDesc;
    this.avatarUrl.value = avatarUrl;
  }

  static bool isCharInfoValid({
    required String displayName,
    required String bioDesc,
    required String avatarUrl,
  }) {
    return displayName.isNotEmpty;
  }

  @override
  void onClose() {}

  setValid(CreateCharStep step, bool valid) {
    isValid[step] = valid;
  }
}
