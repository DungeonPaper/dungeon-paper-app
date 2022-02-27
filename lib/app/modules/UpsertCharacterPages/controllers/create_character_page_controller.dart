import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/core/utils/input_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'character_info_controller.dart';

enum CreateCharStep {
  information,
  charClass,
  stats,
  moves,
  background,
  gear,
  review,
}

class CreateCharacterPageController extends GetxController {
  final pageController = PageController(initialPage: 0).obs;
  final lastAvailablePage = 0.obs;
  final Rx<CharInfo?> info = Rx(null);
  final Rx<CharacterClass?> charClass = Rx(null);
  final isValid = <CreateCharStep, bool>{
    CreateCharStep.information: false,
    CreateCharStep.charClass: false,
    CreateCharStep.stats: true,
    CreateCharStep.moves: false,
    CreateCharStep.background: false,
    CreateCharStep.gear: false,
    CreateCharStep.review: true,
  }.obs;

  int get page => pageController.value.page?.round() ?? 0;
  CreateCharStep get step => stepAt(page);
  CreateCharStep get lastAvailableStep => stepAt(lastAvailablePage.value);
  CreateCharStep stepAt(int index) => CreateCharStep.values.elementAt(index);
  int get firstInvalidPage => CreateCharStep.values.indexWhere((s) => isValid[s] == false);
  CreateCharStep get firstInvalidStep => stepAt(firstInvalidPage);
  bool get allValid => isValid.values.every((v) => v);
  bool get canProceed => firstInvalidPage > lastAvailablePage.value;

  void proceed(BuildContext context) {
    hideKeyboard(context);
    if (firstInvalidPage > lastAvailablePage.value) {
      lastAvailablePage.value += 1;
    }
    goToPage(lastAvailablePage.value);
  }

  setValid(CreateCharStep step, bool valid, dynamic dataToSave) {
    isValid[step] = valid;
    final map = <CreateCharStep, void Function()>{
      CreateCharStep.information: () => info.value = dataToSave,
      CreateCharStep.charClass: () => charClass.value = dataToSave,
    };
    map[step]?.call();
  }

  Character createChar() {
    return Character.empty().copyWith(
      displayName: info.value?.displayName,
      avatarUrl: info.value?.avatarUrl,
      characterClass: charClass.value,
    );
  }

  void goToPage(int page) {
    pageController.value.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void updatePage() {
    pageController.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    pageController.value.addListener(updatePage);
  }
}
