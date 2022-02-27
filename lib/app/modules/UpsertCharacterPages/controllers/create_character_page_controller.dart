import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/core/request_notifier.dart';
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
  final pageController = PageController(
    initialPage: 0,
  ).obs;

  final lastAvailablePage = 0.obs;
  CreateCharStep get lastAvailableStep => CreateCharStep.values.elementAt(lastAvailablePage.value);

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

  // final notifiers = <CreateCharStep, RequestNotifier?>{
  //   CreateCharStep.information: null,
  //   CreateCharStep.charClass: null,
  //   CreateCharStep.stats: null,
  //   CreateCharStep.moves: null,
  //   CreateCharStep.background: null,
  //   CreateCharStep.gear: null,
  //   CreateCharStep.review: null,
  // }.obs;

  int get page => pageController.value.page?.round() ?? 0;
  CreateCharStep get step => CreateCharStep.values.elementAt(page);

  bool get canProceed {
    return isValid[step]!;
  }

  void proceed() {
    // final notifier = notifiers[step];
    // if (notifier != null) {
    //   final map = <CreateCharStep, void Function(dynamic data)>{
    //     CreateCharStep.information: (data) => info.value = data,
    //   };
    //   debugPrint('requesting data from RequestNotifier for $step');
    //   final data = notifier.request();
    //   debugPrint('got: $data');
    //   map[step]?.call(data);
    // }
    final firstInvalid = CreateCharStep.values.indexWhere((s) => isValid[s] == false);
    if (firstInvalid > lastAvailablePage.value) {
      lastAvailablePage.value += 1;
    }
    goToPage(lastAvailablePage.value);
  }

  @override
  void onInit() {
    super.onInit();
    pageController.value.addListener(updatePage);
    // currentStep.value.jumpToPage(0);
  }

  setValid(CreateCharStep step, bool valid, dynamic dataToSave) {
    isValid[step] = valid;
    // if (valid) {
    final map = <CreateCharStep, void Function()>{
      CreateCharStep.information: () => info.value = dataToSave,
      CreateCharStep.charClass: () => charClass.value = dataToSave,
    };
    map[step]?.call();
    // }
  }

  // setNotifier(CreateCharStep step, RequestNotifier notifier) {
  //   notifiers[step] = notifier;
  // }

  bool get allValid => isValid.values.every((v) => v);

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
}
