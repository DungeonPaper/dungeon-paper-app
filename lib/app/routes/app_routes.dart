part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  /// `/`
  static const home = _Paths.home;

  /// `/about`
  static const about = _Paths.about;

  /// `/characters`
  static const characterList = _Paths.characterList;

  /// `/import-export`
  static const importExport = _Paths.importExport;

  /// `/login`
  static const login = _Paths.login;

  /// `/migration`
  static const migration = _Paths.migration;

  /// `/roll`
  static const rollDice = _Paths.rollDice;

  /// `/settings`
  static const settings = _Paths.settings;

  /// `/search`
  static const universalSearch = _Paths.search;

  /// `/user-menu`
  static const userMenu = _Paths.userMenu;

  /// `/library`
  static const library = _Paths.library;

  /// `/library/moves`
  static const moves = _Paths.library + _Paths.moves;

  /// `/library/moves/edit`
  static const editMove = _Paths.library + _Paths.moves + _Paths.edit;

  /// `/library/spells`
  static const spells = _Paths.library + _Paths.spells;

  /// `/library/spells/edit`
  static const editSpell = _Paths.library + _Paths.spells + _Paths.edit;

  /// `/library/items`
  static const items = _Paths.library + _Paths.items;

  /// `/library/items/edit`
  static const editItem = _Paths.library + _Paths.items + _Paths.edit;

  /// `/library/races`
  static const races = _Paths.library + _Paths.races;

  /// `/library/races/edit`
  static const editRace = _Paths.library + _Paths.races + _Paths.edit;

  /// `/library/notes`
  static const notes = _Paths.library + _Paths.notes;

  /// `/library/notes/edit`
  static const editNote = _Paths.library + _Paths.notes + _Paths.edit;

  /// `/library/class`
  static const classes = _Paths.library + _Paths.characterClass;

  /// `/library/class/edit`
  static const editClass = _Paths.library + _Paths.characterClass + _Paths.edit;

  static listByType<T extends WithMeta>() => {
        Move: Routes.moves,
        Spell: Routes.spells,
        Item: Routes.items,
        Race: Routes.races,
        Note: Routes.notes,
        CharacterClass: Routes.classes,
      }[T];

  static editByType<T extends WithMeta>() => {
        Move: Routes.editMove,
        Spell: Routes.editSpell,
        Item: Routes.editItem,
        Race: Routes.editRace,
        Note: Routes.editNote,
        CharacterClass: Routes.editClass,
      }[T];

  /// `/character/create`
  static const createCharacter = _Paths.character + _Paths.create;

  /// `/character/create/roll-stats`
  static const createCharacterAbilityScores =
      _Paths.character + _Paths.create + _Paths.abilityScores;

  /// `/character/create/basic-info`
  static const createCharacterBasicInfo =
      _Paths.character + _Paths.create + _Paths.basicInfo;

  /// `/character/create/moves-and-spells`
  static const createCharacterMovesSpells =
      _Paths.character + _Paths.create + _Paths.selectMovesSpells;

  /// `/character/create/class`
  static const createCharacterSelectClass =
      _Paths.character + _Paths.create + _Paths.characterClass;

  /// `/character/create/starting-gear`
  static const createCharacterStartingGear =
      _Paths.character + _Paths.create + _Paths.startingGear;

  /// `/character/class`
  static const characterClass =
      _Paths.character + _Paths.characterClass; // TODO add page

  /// `/character/ability-score`
  static const abilityScoreForm = _Paths.character + _Paths.abilityScoreForm;

  /// `/character/ability-scores`
  static const abilityScores = _Paths.character + _Paths.abilityScores;

  /// `/character/basic-info`
  static const basicInfo = _Paths.character + _Paths.basicInfo;

  /// `/character/bio`
  static const bio = _Paths.character + _Paths.bio;

  /// `/character/bonds-flags`
  static const bondsFlags = _Paths.character + _Paths.bondsFlags;

  /// `/character/class-alignments`
  static const classAlignments = _Paths.character + _Paths.classAlignments;

  /// `/character/theme`
  static const selectCharacterTheme = _Paths.character + _Paths.theme;

  /// `/account`
  static const account = _Paths.account;

  /// `/feedback`
  static const sendFeedback = _Paths.sendFeedback;

  /// `/campaigns`
  static const campaigns = _Paths.campaigns;
}

abstract class _Paths {
  _Paths._();

  /// `/`
  static const home = '/';

  /// `/account`
  static const account = '/account';

  /// `/about`
  static const about = '/about';

  /// `/character`
  static const character = '/character';

  /// `/characters`
  static const characterList = '/characters';

  /// `/import-export`
  static const importExport = '/import-export';

  /// `/login`
  static const login = '/login';

  /// `/migration`
  static const migration = '/migration';

  /// `/roll`
  static const rollDice = '/roll';

  /// `/search`
  static const search = '/search';

  /// `/edit`
  static const edit = '/edit';

  /// `/create`
  static const create = '/create';

  /// `/settings`
  static const settings = '/settings';

  /// `/user-menu`
  static const userMenu = '/user-menu';

  /// `/roll-stats`
  static const abilityScores = '/roll-stats';

  /// `/basic-info`
  static const basicInfo = '/basic-info';

  /// `/class`
  static const characterClass = '/class';

  /// `/moves-and-spells`
  static const selectMovesSpells = '/moves-and-spells';

  /// `/starting-gear`
  static const startingGear = '/starting-gear';

  /// `/library`
  static const library = '/library';

  /// `/moves`
  static const moves = '/moves';

  /// `/spells`
  static const spells = '/spells';

  /// `/items`
  static const items = '/items';

  /// `/races`
  static const races = '/races';

  /// `/notes`
  static const notes = '/notes';

  /// `/ability-score`
  static const abilityScoreForm = '/ability-score';

  /// `/biography`
  static const bio = '/biography';

  /// `/bonds-flags`
  static const bondsFlags = '/bonds-flags';

  /// `/class-alignments`
  static const classAlignments = '/class-alignments';

  /// `/character-theme`
  static const theme = '/theme';

  /// `/feedback`
  static const sendFeedback = '/feedback';

  /// `/campaign`
  static const campaigns = '/campaigns';
}
