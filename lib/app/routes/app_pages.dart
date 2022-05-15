import 'package:dungeon_paper/app/data/models/item.dart';
import 'package:dungeon_paper/app/data/models/meta.dart';
import 'package:dungeon_paper/app/data/models/move.dart';
import 'package:dungeon_paper/app/data/models/spell.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/bindings/ability_scores_form_binding.dart';
import 'package:dungeon_paper/app/modules/AbilityScoresForm/views/ability_scores_form_view.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/bindings/basic_info_form_binding.dart';
import 'package:dungeon_paper/app/modules/BasicInfoForm/views/basic_info_form_view.dart';
import 'package:dungeon_paper/app/modules/CreateCharacter/SelectMovesSpells/bindings/select_moves_spells_binding.dart';
import 'package:dungeon_paper/app/modules/CreateCharacter/SelectMovesSpells/views/select_moves_spells_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/items_library_list_view.dart';
import 'package:dungeon_paper/app/modules/LibraryList/views/spells_library_list_view.dart';
import 'package:dungeon_paper/app/modules/StartingGearForm/bindings/starting_gear_form_binding.dart';
import 'package:dungeon_paper/app/modules/StartingGearForm/views/starting_gear_form_view.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../data/services/character_service.dart';
import '../modules/BondsFlagsForm/bindings/bonds_flags_form_binding.dart';
import '../modules/BondsFlagsForm/views/bonds_flags_form_view.dart';
import '../modules/CharacterList/bindings/character_list_binding.dart';
import '../modules/CharacterList/views/character_list_view.dart';
import '../modules/CreateCharacter/bindings/create_character_binding.dart';
import '../modules/CreateCharacter/views/create_character_view.dart';
import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/ImportExport/bindings/import_export_binding.dart';
import '../modules/ImportExport/views/import_export_view.dart';
import '../modules/LibraryList/bindings/library_list_binding.dart';
import '../modules/LibraryList/views/moves_library_list_view.dart';
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
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.characterList,
      page: () => const CharacterListPageView(),
      binding: CharacterListPageBinding(),
    ),
    GetPage(
      name: Routes.settings,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.importExport,
      page: () => const ImportExportView(),
      binding: ImportExportBinding(),
    ),
    GetPage(
      name: Routes.rollDice,
      page: () => RollDiceView(dice: Get.arguments),
      opaque: false,
    ),

    //

    GetPage(
      name: Routes.moves,
      page: () => const MovesLibraryListView(),
      binding: LibraryListBinding(),
    ),
    GetPage(
      name: Routes.spells,
      page: () => const SpellsLibraryListView(),
      binding: LibraryListBinding(),
    ),
    GetPage(
      name: Routes.items,
      page: () => const ItemsLibraryListView(),
      binding: LibraryListBinding(),
    ),
    GetPage(
      name: Routes.bondsFlags,
      page: () => const BondsFlagsFormView(),
      binding: BondsFlagsFormBinding(),
    ),
    GetPage(
      name: Routes.basicInfo,
      page: () => const BasicInfoFormView(),
      binding: BasicInfoFormBinding(),
    ),
    GetPage(
      name: Routes.abilityScores,
      page: () => const AbilityScoresFormView(),
      binding: AbilityScoresFormBinding(),
    ),
    GetPage(
      name: Routes.bondsFlags,
      page: () => const BondsFlagsFormView(),
      binding: AbilityScoresFormBinding(),
    ),

    //

    GetPage(
      name: Routes.createCharacter,
      page: () => const CreateCharacterView(),
      binding: CreateCharacterBinding(),
      opaque: false,
      fullscreenDialog: true,
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.createCharacterStartingGear,
      page: () => const StartingGearFormView(),
      binding: StartingGearFormBinding(),
    ),
    GetPage(
      name: Routes.createCharacterMovesSpells,
      page: () => const SelectMovesSpellsView(),
      binding: SelectMovesSpellsBinding(),
    ),

    GetPage(
      name: Routes.createCharacterBasicInfo,
      page: () => const BasicInfoFormView(),
      binding: BasicInfoFormBinding(),
    ),
    GetPage(
      name: Routes.createCharacterAbilityScores,
      page: () => const AbilityScoresFormView(),
      binding: AbilityScoresFormBinding(),
    ),
  ];
}
