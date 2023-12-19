import 'package:dungeon_world_data/dice.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../data/models/character_class.dart';
import '../data/models/item.dart';
import '../data/models/meta.dart';
import '../data/models/move.dart';
import '../data/models/note.dart';
import '../data/models/race.dart';
import '../data/models/spell.dart';
import '../data/services/character_service.dart';
import '../modules/AbilityScoreForm/controllers/ability_score_form_controller.dart';
import '../modules/AbilityScoreForm/views/ability_score_form_view.dart';
import '../modules/AbilityScoresForm/controllers/ability_scores_form_controller.dart';
import '../modules/AbilityScoresForm/views/ability_scores_form_view.dart';
import '../modules/About/views/about_view.dart';
import '../modules/Account/views/account_view.dart';
import '../modules/BasicInfoForm/controllers/basic_info_form_controller.dart';
import '../modules/BasicInfoForm/views/basic_info_form_view.dart';
import '../modules/BioForm/controllers/bio_form_controller.dart';
import '../modules/BioForm/views/bio_form_view.dart';
import '../modules/BondsFlagsForm/controllers/bonds_flags_form_controller.dart';
import '../modules/BondsFlagsForm/views/bonds_flags_form_view.dart';
import '../modules/Campaign/CampaignsList/views/campaigns_list_view.dart';
import '../modules/CharacterList/views/character_list_view.dart';
import '../modules/ClassAlignments/views/class_alignments_view.dart';
import '../modules/CreateCharacter/SelectMovesSpells/views/select_moves_spells_view.dart';
import '../modules/CreateCharacter/controllers/create_character_controller.dart';
import '../modules/CreateCharacter/views/create_character_view.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/ImportExport/controllers/import_export_controller.dart';
import '../modules/ImportExport/views/import_export_view.dart';
import '../modules/LibraryList/views/character_classes_library_list_view.dart';
import '../modules/LibraryList/views/items_library_list_view.dart';
import '../modules/LibraryList/views/library_collection_view.dart';
import '../modules/LibraryList/views/moves_library_list_view.dart';
import '../modules/LibraryList/views/races_library_list_view.dart';
import '../modules/LibraryList/views/spells_library_list_view.dart';
import '../modules/Login/controllers/login_controller.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Migration/views/migration_view.dart';
import '../modules/SelectCharacterTheme/views/select_character_theme_view.dart';
import '../modules/SendFeedback/views/send_feedback_view.dart';
import '../modules/Settings/controllers/settings_controller.dart';
import '../modules/Settings/views/settings_view.dart';
import '../modules/StartingGearForm/controllers/starting_gear_form_controller.dart';
import '../modules/StartingGearForm/views/starting_gear_form_view.dart';
import '../modules/UniversalSearch/controllers/universal_search_controller.dart';
import '../modules/UniversalSearch/views/universal_search_view.dart';
import '../widgets/forms/character_class_form.dart';
import '../widgets/forms/item_form.dart';
import '../widgets/forms/move_form.dart';
import '../widgets/forms/note_form.dart';
import '../widgets/forms/race_form.dart';
import '../widgets/forms/spell_form.dart';
import '../widgets/molecules/user_menu_popover.dart';
import '../widgets/views/roll_dice_view.dart';
import 'custom_transitions.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final pageController = PageController();

  static final CharacterService characterService = Get.find();

  static const initial = Routes.home;

  static final routes = {
    Routes.login: (context) => ChangeNotifierProvider(
          create: (_) => LoginController(),
          child: const LoginView(),
        ),

    Routes.userMenu: (context) => const UserMenuPopover(),

    Routes.home: (context) => const HomeView(),

    Routes.characterList: (context) => const CharacterListPageView(),

    Routes.settings: (context) => ChangeNotifierProvider(
          create: (_) => SettingsController(),
          child: const SettingsView(),
        ),

    Routes.importExport: (context) => ChangeNotifierProvider(
          create: (_) => ImportExportController(),
          child: const ImportExportView(),
        ),

    Routes.rollDice: (context) => RollDiceView(
        dice: ModalRoute.of(context)!.settings.arguments as List<Dice>),

    //

    Routes.library: (context) => const LibraryCollectionView(),

    Routes.moves: (context) => const MovesLibraryListView(),

    Routes.editMove: (context) => ChangeNotifierProvider(
          create: (context) => MoveFormController(context),
          child: const MoveForm(),
        ),

    Routes.spells: (context) => const SpellsLibraryListView(),

    Routes.editSpell: (context) => ChangeNotifierProvider(
          create: (context) => SpellFormController(context),
          child: const SpellForm(),
        ),

    Routes.items: (context) => const ItemsLibraryListView(),

    Routes.editItem: (context) => ChangeNotifierProvider(
          create: (context) => ItemFormController(context),
          child: const ItemForm(),
        ),

    Routes.classes: (context) => const CharacterClassesLibraryListView(),

    Routes.editClass: (context) => ChangeNotifierProvider(
          create: (context) => CharacterClassFormController(context),
          child: const CharacterClassForm(),
        ),

    Routes.races: (context) => const RacesLibraryListView(),

    Routes.editRace: (context) => ChangeNotifierProvider(
          create: (context) => RaceFormController(context),
          child: const RaceForm(),
        ),

    Routes.editNote: (context) => ChangeNotifierProvider(
          create: (context) => NoteFormController(context),
          child: const NoteForm(),
        ),

    //

    Routes.bondsFlags: (context) => ChangeNotifierProvider(
          create: (context) => BondsFlagsFormController(context),
          child: const BondsFlagsFormView(),
        ),

    Routes.bio: (context) => ChangeNotifierProvider(
          create: (context) => BioFormController(context),
          child: const BioFormView(),
        ),

    Routes.basicInfo: (context) => ChangeNotifierProvider(
          create: (context) => BasicInfoFormController(context),
          child: const BasicInfoFormView(),
        ),

    Routes.abilityScores: (context) => ChangeNotifierProvider(
          create: (context) => AbilityScoresFormController(context),
          child: const AbilityScoresFormView(),
        ),

    Routes.abilityScoreForm: (context) => ChangeNotifierProvider(
          child: const AbilityScoreFormView(),
          create: (context) => AbilityScoreFormController(context),
        ),

    //

    Routes.createCharacter: (context) => ChangeNotifierProvider(
          create: (_) => CreateCharacterController(),
          child: const CreateCharacterView(),
        ),

    Routes.createCharacterSelectClass: (context) =>
        const CharacterClassesLibraryListView(),

    Routes.createCharacterStartingGear: (context) => ChangeNotifierProvider(
          child: const StartingGearFormView(),
          create: (context) => StartingGearFormController(context),
        ),

    Routes.createCharacterMovesSpells: (context) => ChangeNotifierProvider(
          child: const SelectMovesSpellsView(),
          create: (_) => SelectMovesSpellsController(),
        ),

    Routes.createCharacterBasicInfo: (context) => ChangeNotifierProvider(
          child: const BasicInfoFormView(),
          create: (context) => BasicInfoFormController(context),
        ),

    Routes.createCharacterAbilityScores: (context) => ChangeNotifierProvider(
          child: const AbilityScoresFormView(),
          create: (context) => AbilityScoresFormController(context),
        ),

    Routes.classAlignments: (context) => ChangeNotifierProvider(
          child: const ClassAlignmentsView(),
          create: (_) => ClassAlignmentsController(),
        ),

    Routes.universalSearch: (context) => ChangeNotifierProvider(
          create: (_) => UniversalSearchController(),
          child: UniversalSearchView(),
        ),

    Routes.migration: (context) => ChangeNotifierProvider(
          child: const MigrationView(),
          create: (_) => MigrationController(),
        ),

    Routes.about: (context) => ChangeNotifierProvider(
          child: const AboutView(),
          create: (_) => AboutController(),
        ),

    Routes.selectCharacterTheme: (context) => ChangeNotifierProvider(
          child: const SelectCharacterThemeView(),
          create: (_) => SelectCharacterThemeController(),
        ),

    _Paths.abilityScoreForm: (context) => ChangeNotifierProvider(
          child: const AbilityScoreFormView(),
          create: (context) => AbilityScoreFormController(context),
        ),

    _Paths.account: (context) => ChangeNotifierProvider(
          child: const AccountView(),
          create: (_) => AccountController(),
        ),

    _Paths.sendFeedback: (context) => ChangeNotifierProvider(
          child: const SendFeedbackView(),
          create: (_) => SendFeedbackController(),
        ),

    _Paths.campaigns: (context) => ChangeNotifierProvider(
          child: const CampaignsListView(),
          create: (_) => CampaignsListController(),
        ),
  };
}

class CustomTransitions {
  static CustomTransition circularReveal({
    Offset? offset,
    Alignment? alignment,
  }) {
    return CustomCircularRevealTransition(offset: offset, alignment: alignment);
  }
}

