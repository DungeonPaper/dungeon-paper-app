import 'package:dungeon_paper/app/routes/custom_transitions.dart';
import 'package:dungeon_paper/core/route_arguments.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/character_class.dart';
import '../data/models/item.dart';
import '../data/models/meta.dart';
import '../data/models/move.dart';
import '../data/models/note.dart';
import '../data/models/race.dart';
import '../data/models/spell.dart';
import '../modules/AbilityScoreForm/controllers/ability_score_form_controller.dart';
import '../modules/AbilityScoreForm/views/ability_score_form_view.dart';
import '../modules/AbilityScoresForm/controllers/ability_scores_form_controller.dart';
import '../modules/AbilityScoresForm/views/ability_scores_form_view.dart';
import '../modules/About/controllers/about_controller.dart';
import '../modules/About/views/about_view.dart';
import '../modules/Account/controllers/account_controller.dart';
import '../modules/Account/views/account_view.dart';
import '../modules/BasicInfoForm/controllers/basic_info_form_controller.dart';
import '../modules/BasicInfoForm/views/basic_info_form_view.dart';
import '../modules/BioForm/controllers/bio_form_controller.dart';
import '../modules/BioForm/views/bio_form_view.dart';
import '../modules/BondsFlagsForm/controllers/bonds_flags_form_controller.dart';
import '../modules/BondsFlagsForm/views/bonds_flags_form_view.dart';
import '../modules/Campaign/CampaignsList/controllers/campaigns_list_controller.dart';
import '../modules/Campaign/CampaignsList/views/campaigns_list_view.dart';
import '../modules/Changelog/changelog_controller.dart';
import '../modules/Changelog/changelog_view.dart';
import '../modules/CharacterList/views/character_list_view.dart';
import '../modules/ClassAlignments/controllers/class_alignments_controller.dart';
import '../modules/ClassAlignments/views/class_alignments_view.dart';
import '../modules/CreateCharacter/SelectMovesSpells/controllers/select_moves_spells_controller.dart';
import '../modules/CreateCharacter/SelectMovesSpells/views/select_moves_spells_view.dart';
import '../modules/CreateCharacter/controllers/create_character_controller.dart';
import '../modules/CreateCharacter/views/create_character_view.dart';
import '../modules/Home/views/home_view.dart';
import '../modules/ImportExport/controllers/export_controller.dart';
import '../modules/ImportExport/controllers/import_controller.dart';
import '../modules/ImportExport/controllers/import_export_controller.dart';
import '../modules/ImportExport/views/import_export_view.dart';
import '../modules/LibraryList/controllers/library_list_controller.dart';
import '../modules/LibraryList/views/character_classes_library_list_view.dart';
import '../modules/LibraryList/views/filters/character_class_filters.dart';
import '../modules/LibraryList/views/filters/item_filters.dart';
import '../modules/LibraryList/views/filters/move_filters.dart';
import '../modules/LibraryList/views/filters/race_filters.dart';
import '../modules/LibraryList/views/filters/spell_filters.dart';
import '../modules/LibraryList/views/items_library_list_view.dart';
import '../modules/LibraryList/views/library_collection_view.dart';
import '../modules/LibraryList/views/moves_library_list_view.dart';
import '../modules/LibraryList/views/races_library_list_view.dart';
import '../modules/LibraryList/views/spells_library_list_view.dart';
import '../modules/Login/controllers/login_controller.dart';
import '../modules/Login/views/login_view.dart';
import '../modules/Migration/controllers/migration_controller.dart';
import '../modules/Migration/views/migration_view.dart';
import '../modules/SelectCharacterTheme/controllers/select_character_theme_controller.dart';
import '../modules/SelectCharacterTheme/views/select_character_theme_view.dart';
import '../modules/SendFeedback/controllers/send_feedback_controller.dart';
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
// import 'custom_transitions.dart';

part 'app_routes.dart';

class DefaultPageRoute<T> extends PageRouteBuilder<T>
    with MaterialRouteTransitionMixin<T> {
  DefaultPageRoute(
      {required this.builder,
      super.settings,
      super.fullscreenDialog,
      super.opaque})
      : super(pageBuilder: (ctx, _, __) => builder(ctx));
  final WidgetBuilder builder;

  @override
  Widget buildContent(BuildContext context) {
    return this.builder(context);
  }
}

class AppPages {
  AppPages._();

  static final pageController = PageController();

  static const initial = Routes.home;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final route = settings.name;
    final builder = routes[route];
    debugPrint('[ROUTER] Building route $route');
    if (builder == null) {
      throw Exception('No route defined for $route');
    }
    if (transitionsMap.containsKey(route)) {
      return transitionsMap[route]!(builder, settings);
    }
    return DefaultPageRoute(
      builder: builder,
      settings: settings,
      fullscreenDialog: AppPages.fullscreenDialogs.contains(route),
      opaque: !AppPages.transparentRoutes.contains(route),
    );
  }

  static final fullscreenDialogs = <String>{
    Routes.rollDice,
    Routes.userMenu,
    Routes.universalSearch,
    Routes.createCharacter,
  };

  static final transparentRoutes = <String>{Routes.createCharacter};

  static final transitionsMap =
      <String, Route Function(WidgetBuilder builder, RouteSettings settings)>{
    Routes.rollDice: (builder, settings) => CircularRevealTransitionBuilder(
          builder: builder,
          settings: settings,
          alignment: Alignment.bottomCenter,
        ),
    Routes.userMenu: (builder, settings) => CircularRevealTransitionBuilder(
          builder: builder,
          settings: settings,
          alignment: Alignment.topRight,
          offset: const Offset(-24, 64),
        ),
    Routes.universalSearch: (builder, settings) =>
        CircularRevealTransitionBuilder(
          builder: builder,
          settings: settings,
          alignment: Alignment.topLeft,
          offset: const Offset(26, 64),
        ),
  };

  static final routes = <String, WidgetBuilder>{
    Routes.login: (context) => ChangeNotifierProvider(
          create: (_) => LoginController(),
          child: const LoginView(),
        ),

    Routes.userMenu: (context) => const UserMenuPopover(),

    Routes.home: (context) => const HomeView(),

    Routes.characterList: (context) => const CharacterListPageView(),

    Routes.settings: (context) => ChangeNotifierProvider(
          create: (_) => SettingsController(context),
          child: const SettingsView(),
        ),

    Routes.importExport: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ImportExportController()),
            ChangeNotifierProvider(create: (_) => ImportController()),
            ChangeNotifierProvider(create: (_) => ExportController()),
          ],
          child: const ImportExportView(),
        ),

    Routes.rollDice: (context) => RollDiceView(dice: getArgs(context)),

    //

    Routes.library: (context) => const LibraryCollectionView(),

    Routes.moves: (context) => ChangeNotifierProvider(
          create: (_) => LibraryListController<Move, MoveFilters>(context),
          child: const MovesLibraryListView(),
        ),

    Routes.editMove: (context) => ChangeNotifierProvider(
          create: (_) => MoveFormController(context),
          child: const MoveForm(),
        ),

    Routes.spells: (context) => ChangeNotifierProvider(
          create: (_) => LibraryListController<Spell, SpellFilters>(context),
          child: const SpellsLibraryListView(),
        ),

    Routes.editSpell: (context) => ChangeNotifierProvider(
          create: (_) => SpellFormController(context),
          child: const SpellForm(),
        ),

    Routes.items: (context) => ChangeNotifierProvider(
          create: (_) => LibraryListController<Item, ItemFilters>(context),
          child: const ItemsLibraryListView(),
        ),

    Routes.editItem: (context) => ChangeNotifierProvider(
          create: (_) => ItemFormController(context),
          child: const ItemForm(),
        ),

    Routes.classes: (context) => ChangeNotifierProvider(
          create: (_) =>
              LibraryListController<CharacterClass, CharacterClassFilters>(
                  context),
          child: const CharacterClassesLibraryListView(),
        ),

    Routes.editClass: (context) => ChangeNotifierProvider(
          create: (_) => CharacterClassFormController(context),
          child: const CharacterClassForm(),
        ),

    Routes.races: (context) => ChangeNotifierProvider(
          create: (_) => LibraryListController<Race, RaceFilters>(context),
          child: const RacesLibraryListView(),
        ),

    Routes.editRace: (context) => ChangeNotifierProvider(
          create: (_) => RaceFormController(context),
          child: const RaceForm(),
        ),

    Routes.editNote: (context) => ChangeNotifierProvider(
          create: (_) => NoteFormController(context),
          child: const NoteForm(),
        ),

    //

    Routes.bondsFlags: (context) => ChangeNotifierProvider(
          create: (_) => BondsFlagsFormController(context),
          child: const BondsFlagsFormView(),
        ),

    Routes.bio: (context) => ChangeNotifierProvider(
          create: (_) => BioFormController(context),
          child: const BioFormView(),
        ),

    Routes.basicInfo: (context) => ChangeNotifierProvider(
          create: (_) => BasicInfoFormController(context),
          child: const BasicInfoFormView(),
        ),

    Routes.abilityScores: (context) => ChangeNotifierProvider(
          create: (_) => AbilityScoresFormController(context),
          child: const AbilityScoresFormView(),
        ),

    Routes.abilityScoreForm: (context) => ChangeNotifierProvider(
          child: const AbilityScoreFormView(),
          create: (_) => AbilityScoreFormController(context),
        ),

    //

    Routes.createCharacter: (context) => ChangeNotifierProvider(
          create: (_) => CreateCharacterController(),
          child: const CreateCharacterView(),
        ),

    Routes.createCharacterSelectClass: (context) => ChangeNotifierProvider(
          create: (_) =>
              LibraryListController<CharacterClass, CharacterClassFilters>(
            context,
          ),
          child: const CharacterClassesLibraryListView(),
        ),

    Routes.createCharacterStartingGear: (context) => ChangeNotifierProvider(
          create: (_) => StartingGearFormController(context),
          child: const StartingGearFormView(),
        ),

    Routes.createCharacterMovesSpells: (context) => ChangeNotifierProvider(
          create: (_) => SelectMovesSpellsController(context),
          child: const SelectMovesSpellsView(),
        ),

    Routes.createCharacterBasicInfo: (context) => ChangeNotifierProvider(
          create: (_) => BasicInfoFormController(context),
          child: const BasicInfoFormView(),
        ),

    Routes.createCharacterAbilityScores: (context) => ChangeNotifierProvider(
          create: (_) => AbilityScoresFormController(context),
          child: const AbilityScoresFormView(),
        ),

    Routes.classAlignments: (context) => ChangeNotifierProvider(
          child: const ClassAlignmentsView(),
          create: (_) => ClassAlignmentsController(context),
        ),

    Routes.universalSearch: (context) => ChangeNotifierProvider(
          create: (_) => UniversalSearchController(),
          child: UniversalSearchView(),
        ),

    Routes.migration: (context) => ChangeNotifierProvider(
          child: const MigrationView(),
          create: (_) => MigrationController(context),
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
          create: (_) => AbilityScoreFormController(context),
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

    _Paths.changelog: (context) => ChangeNotifierProvider(
          child: const ChangelogView(),
          create: (_) => ChangelogController(),
        ),
  };
}

