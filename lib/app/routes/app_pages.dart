import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../data/services/character_service.dart';
import '../model_utils/character_utils.dart';
import '../modules/AddRepositoryItems/bindings/add_repository_items_binding.dart';
import '../modules/AddRepositoryItems/views/add_moves_view.dart';
import '../modules/BasicInfoForm/bindings/basic_info_form_binding.dart';
import '../modules/BasicInfoForm/views/basic_info_form_view.dart';
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
      name: _Paths.characterListPage,
      page: () => const CharacterListPageView(),
      binding: CharacterListPageBinding(),
    ),
    GetPage(
      name: _Paths.addMoves,
      page: () => AddMovesView(
        rollStats: characterService.current!.rollStats,
        onAdd: (moves) => characterService.updateCharacter(
          CharacterUtils.updateMoves(characterService.current!, moves),
        ),
        selections: characterService.current!.moves,
        classKeys: [characterService.current!.characterClass.key],
      ),
      binding: AddRepositoryItemsBinding(),
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
      page: () => CreateCharacterView(),
      binding: CreateCharacterBinding(),
      opaque: false,
      fullscreenDialog: true,
    ),
    GetPage(
      name: _Paths.BASIC_INFO_FORM,
      page: () => BasicInfoFormView(),
      binding: BasicInfoFormBinding(),
    ),
  ];
}
