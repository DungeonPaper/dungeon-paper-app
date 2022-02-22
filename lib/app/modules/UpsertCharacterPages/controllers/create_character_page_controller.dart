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

  final isValid = <CreateCharStep, bool>{
    CreateCharStep.information: false,
    CreateCharStep.charClass: false,
    CreateCharStep.stats: false,
    CreateCharStep.moves: false,
    CreateCharStep.alignment: false,
    CreateCharStep.gear: false,
    CreateCharStep.review: true,
  }.obs;

  setValid(CreateCharStep step, bool valid) {
    isValid[step] = valid;
  }
}
