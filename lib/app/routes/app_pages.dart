import 'package:flutter/widgets.dart';

import 'package:get/get.dart';

import '../data/models/item.dart';
import '../data/models/meta.dart';
import '../data/models/move.dart';
import '../data/models/spell.dart';
import '../data/services/character_service.dart';
import '../modules/AbilityScoresForm/bindings/ability_scores_form_binding.dart';
import '../modules/AbilityScoresForm/views/ability_scores_form_view.dart';
import '../modules/BasicInfoForm/bindings/basic_info_form_binding.dart';
import '../modules/BasicInfoForm/views/basic_info_form_view.dart';
import '../modules/BioForm/bindings/bio_form_binding.dart';
import '../modules/BioForm/views/bio_form_view.dart';
import '../modules/BondsFlagsForm/bindings/bonds_flags_form_binding.dart';
import '../modules/BondsFlagsForm/views/bonds_flags_form_view.dart';
import '../modules/CharacterList/bindings/character_list_binding.dart';
import '../modules/CharacterList/views/character_list_view.dart';
import '../modules/ClassAlignments/bindings/class_alignments_binding.dart';
import '../modules/ClassAlignments/views/class_alignments_view.dart';
import '../modules/CreateCharacter/SelectMovesSpells/bindings/select_moves_spells_binding.dart';
import '../modules/CreateCharacter/SelectMovesSpells/views/select_moves_spells_view.dart';
import '../modules/CreateCharacter/bindings/create_character_binding.dart';
import '../modules/CreateCharacter/views/create_character_view.dart';
import '../modules/Home/bindings/home_binding.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/ImportExport/bindings/import_export_binding.dart';
import '../modules/ImportExport/views/import_export_view.dart';
import '../modules/LibraryList/bindings/library_collection_binding.dart';
import '../modules/LibraryList/bindings/library_list_binding.dart';
import '../modules/LibraryList/views/character_classes_library_list_view.dart';
import '../modules/LibraryList/views/items_library_list_view.dart';
import '../modules/LibraryList/views/library_collection_view.dart';
import '../modules/LibraryList/views/moves_library_list_view.dart';
import '../modules/LibraryList/views/spells_library_list_view.dart';
import '../modules/Login/bindings/login_binding.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Settings/bindings/settings_binding.dart';
import '../modules/Settings/views/settings_view.dart';
import '../modules/StartingGearForm/bindings/starting_gear_form_binding.dart';
import '../modules/StartingGearForm/views/starting_gear_form_view.dart';
import '../widgets/views/roll_dice_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pageController = PageController();

  static final CharacterService characterService = Get.find();

  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: _Paths.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.characterList,
      page: () => const CharacterListPageView(),
      binding: CharacterListPageBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.settings,
      page: () => SettingsView(),
      binding: SettingsBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.importExport,
      page: () => const ImportExportView(),
      binding: ImportExportBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.rollDice,
      page: () => RollDiceView(dice: Get.arguments),
      opaque: false,
    ),

    //

    GetPage(
      name: Routes.library,
      page: () => const LibraryCollectionView(),
      binding: LibraryCollectionBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.moves,
      page: () => const MovesLibraryListView(),
      binding: LibraryListBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.spells,
      page: () => const SpellsLibraryListView(),
      binding: LibraryListBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.items,
      page: () => const ItemsLibraryListView(),
      binding: LibraryListBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.characterClass,
      page: () => const CharacterClassesLibraryListView(),
      binding: LibraryListBinding(),
      preventDuplicates: false,
    ),

    //

    GetPage(
      name: Routes.bondsFlags,
      page: () => const BondsFlagsFormView(),
      binding: BondsFlagsFormBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.bio,
      page: () => const BioFormView(),
      binding: BioFormBinding(),
    ),
    GetPage(
      name: Routes.basicInfo,
      page: () => const BasicInfoFormView(),
      binding: BasicInfoFormBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.abilityScores,
      page: () => const AbilityScoresFormView(),
      binding: AbilityScoresFormBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.bondsFlags,
      page: () => const BondsFlagsFormView(),
      binding: AbilityScoresFormBinding(),
      preventDuplicates: false,
    ),

    //

    GetPage(
      name: Routes.createCharacter,
      page: () => const CreateCharacterView(),
      binding: CreateCharacterBinding(),
      preventDuplicates: false,
      opaque: false,
      fullscreenDialog: true,
    ),
    GetPage(
      name: Routes.createCharacterSelectClass,
      page: () => const CharacterClassesLibraryListView(),
      binding: LibraryListBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.createCharacterStartingGear,
      page: () => const StartingGearFormView(),
      binding: StartingGearFormBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.createCharacterMovesSpells,
      page: () => const SelectMovesSpellsView(),
      binding: SelectMovesSpellsBinding(),
      preventDuplicates: false,
    ),

    GetPage(
      name: Routes.createCharacterBasicInfo,
      page: () => const BasicInfoFormView(),
      binding: BasicInfoFormBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: Routes.createCharacterAbilityScores,
      page: () => const AbilityScoresFormView(),
      binding: AbilityScoresFormBinding(),
      preventDuplicates: false,
    ),
    GetPage(
      name: _Paths.classAlignments,
      page: () => const ClassAlignmentsView(),
      binding: ClassAlignmentsBinding(),
    ),
  ];
}
