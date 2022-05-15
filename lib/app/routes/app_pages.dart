import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../data/services/character_service.dart';
import '../model_utils/character_utils.dart';
import '../modules/LibraryList/bindings/library_list_binding.dart';
import '../modules/LibraryList/views/moves_library_list_view.dart';
import '../modules/CharacterList/bindings/character_list_binding.dart';
import '../modules/CharacterList/views/character_list_view.dart';
import '../modules/CreateCharacter/bindings/create_character_binding.dart';
import '../modules/CreateCharacter/views/create_character_view.dart';
import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/ImportExport/bindings/import_export_binding.dart';
import '../modules/ImportExport/views/import_export_view.dart';
import '../modules/Settings/bindings/settings_binding.dart';
import '../modules/Settings/views/settings_view.dart';
import '../widgets/views/roll_dice_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pageController = PageController();

  static final CharacterService characterService = Get.find();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.characterList,
      page: () => const CharacterListPageView(),
      binding: CharacterListPageBinding(),
    ),
    GetPage(
      name: _Paths.addMoves,
      page: () => MovesLibraryListView(
        abilityScores: characterService.current!.abilityScores,
        onAdd: (moves) => characterService.updateCharacter(
          CharacterUtils.updateMoves(characterService.current!, moves),
        ),
        selections: characterService.current!.moves,
        classKeys: [characterService.current!.characterClass.key],
      ),
      binding: LibraryListBinding(),
    ),
    GetPage(
      name: _Paths.rollDice,
      page: () => RollDiceView(dice: Get.arguments),
      opaque: false,
    ),
    GetPage(
      name: _Paths.settings,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.importExport,
      page: () => const ImportExportView(),
      binding: ImportExportBinding(),
    ),
    GetPage(
      name: _Paths.createCharacter,
      page: () => const CreateCharacterView(),
      binding: CreateCharacterBinding(),
      opaque: false,
      fullscreenDialog: true,
      preventDuplicates: false,
    ),
    // GetPage(
    //   name: _Paths.editBasicInfo,
    //   page: () => BasicInfoFormView(),
    //   binding: BasicInfoFormBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ROLL_STATS_FORM,
    //   page: () => AbilityScoresFormView(),
    //   binding: AbilityScoresFormBinding(),
    // ),
    // GetPage(
    //   name: _Paths.startingGear,
    //   page: () => StartingGearFormView(),
    //   binding: StartingGearFormBinding(),
    // ),
    // GetPage(
    //   name: _Paths.SELECT_MOVES_SPELLS,
    //   page: () => SelectMovesSpellsView(),
    //   binding: SelectMovesSpellsBinding(),
    // ),
  ];
}
