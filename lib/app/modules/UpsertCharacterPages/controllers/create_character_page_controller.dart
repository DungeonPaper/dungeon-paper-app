import 'package:dungeon_paper/app/data/models/alignment.dart';
import 'package:dungeon_paper/app/data/models/bio.dart';
import 'package:dungeon_paper/app/data/models/character.dart';
import 'package:dungeon_paper/app/data/models/character_class.dart';
import 'package:dungeon_paper/app/data/models/gear_choice.dart';
import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/race.dart';
import 'package:dungeon_paper/app/data/models/roll_stats.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_background_controller.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_gear_controller.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/character_moves_spells_controller.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/controllers/create_character_preview_controller.dart';
import 'package:dungeon_paper/app/modules/UpsertCharacterPages/views/create_character_preview_view.dart';
import 'package:dungeon_paper/core/utils/input_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'character_info_controller.dart';

enum CreateCharStep {
  information,
  charClass,
  stats,
  movesSpells,
  background,
  gear,
}

class CreateCharacterPageController extends GetxController {
  final pageController = PageController(initialPage: 0).obs;
  final lastAvailablePage = 0.obs;

  final info = Rx<CharInfo?>(null);
  final charClass = Rx<CharacterClass?>(null);
  final stats = Rx<RollStats?>(null);
  final movesSpells = Rx<CharMovesSpells?>(null);
  final background = Rx<CharBackground?>(null);
  final gear = Rx<CharGear?>(null);

  final char = Character.empty().obs;

  final isValid = <CreateCharStep, bool>{
    CreateCharStep.information: false,
    CreateCharStep.charClass: false,
    CreateCharStep.stats: true,
    CreateCharStep.movesSpells: true,
    CreateCharStep.background: false,
    CreateCharStep.gear: true,
  }.obs;

  int get page => pageController.value.page?.round() ?? 0;
  CreateCharStep get step => stepAt(page);
  CreateCharStep get lastAvailableStep => stepAt(lastAvailablePage.value);
  CreateCharStep stepAt(int index) => CreateCharStep.values.elementAt(index);
  int get firstInvalidPage => CreateCharStep.values.indexWhere((s) => isValid[s] == false);
  CreateCharStep get firstInvalidStep => stepAt(firstInvalidPage);
  bool get allValid => isValid.values.every((v) => v);
  bool get canProceed =>
      firstInvalidPage == -1 ||
      firstInvalidPage > lastAvailablePage.value ||
      lastAvailablePage.value == maxStep;
  bool get isLastStep => page == maxStep;
  bool get allStepsDone => allValid && lastAvailablePage.value == maxStep;
  int get maxStep => isValid.keys.length - 1;

  void proceed(BuildContext context) {
    hideKeyboard(context);
    if (firstInvalidPage == -1 || firstInvalidPage > lastAvailablePage.value) {
      lastAvailablePage.value += 1;
    }
    char.value = createChar();
    goToPage(lastAvailablePage.value);
  }

  void openPreview(BuildContext context) {
    hideKeyboard(context);
    char.value = createChar();
    Get.lazyPut<CreateCharacterPreviewController>(() => CreateCharacterPreviewController());
    Get.to(const CreateCharacterPreviewView());
  }

  setValid(CreateCharStep step, bool valid, dynamic dataToSave) {
    isValid[step] = valid;
    _updateData(dataToSave);
  }

  void _updateData(dynamic dataToSave) {
    final map = <CreateCharStep, void Function()>{
      CreateCharStep.information: () => info.value = dataToSave,
      CreateCharStep.charClass: () => charClass.value = dataToSave,
      CreateCharStep.stats: () => stats.value = dataToSave,
      CreateCharStep.movesSpells: () => movesSpells.value = dataToSave,
      CreateCharStep.background: () => background.value = dataToSave,
      CreateCharStep.gear: () => gear.value = dataToSave,
    };
    map[step]?.call();
    char.value = createChar();
  }

  Character createChar() {
    return Character.empty().copyWith(
      displayName: info.value?.displayName,
      avatarUrl: info.value?.avatarUrl,
      characterClass: charClass.value,
      bio: background.value?.bio,
      bonds: background.value?.bonds,
      items: GearChoice.selectionToItems(gear.value?.selections ?? []),
      coins: GearChoice.selectionToCoins(gear.value?.selections ?? []),
      moves: movesSpells.value?.moves,
      spells: movesSpells.value?.spells,
      rollStats: stats.value,
      // TODO add all race fields to create?
      race: Race.empty().copyWithInherited(
        description: background.value?.raceDesc,
        name: background.value?.raceName,
      ),
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
