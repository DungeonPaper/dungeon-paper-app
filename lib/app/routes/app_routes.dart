part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const about = _Paths.about;
  static const characterList = _Paths.characterList;
  static const importExport = _Paths.importExport;
  static const login = _Paths.login;
  static const migration = _Paths.migration;
  static const rollDice = _Paths.rollDice;
  static const settings = _Paths.settings;
  static const universalSearch = _Paths.search;
  static const userMenu = _Paths.userMenu;

  static const library = _Paths.library;
  static const moves = _Paths.library + _Paths.moves;
  static const editMove = _Paths.library + _Paths.moves + _Paths.edit;
  static const spells = _Paths.library + _Paths.spells;
  static const editSpell = _Paths.library + _Paths.spells + _Paths.edit;
  static const items = _Paths.library + _Paths.items;
  static const editItem = _Paths.library + _Paths.items + _Paths.edit;
  static const races = _Paths.library + _Paths.races;
  static const editRace = _Paths.library + _Paths.races + _Paths.edit;
  static const notes = _Paths.library + _Paths.notes;
  static const editNote = _Paths.library + _Paths.notes + _Paths.edit;
  static const classes = _Paths.library + _Paths.characterClass;
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

  static const createCharacter = _Paths.character + _Paths.create;
  static const createCharacterAbilityScores =
      _Paths.character + _Paths.create + _Paths.abilityScores;
  static const createCharacterBasicInfo = _Paths.character + _Paths.create + _Paths.basicInfo;
  static const createCharacterMovesSpells =
      _Paths.character + _Paths.create + _Paths.selectMovesSpells;
  static const createCharacterSelectClass =
      _Paths.character + _Paths.create + _Paths.characterClass;
  static const createCharacterStartingGear = _Paths.character + _Paths.create + _Paths.startingGear;

  static const characterClass = _Paths.character + _Paths.characterClass; // TODO add page
  static const abilityScoreForm = _Paths.character + _Paths.abilityScoreForm;
  static const abilityScores = _Paths.character + _Paths.abilityScores;
  static const basicInfo = _Paths.character + _Paths.basicInfo;
  static const bio = _Paths.character + _Paths.bio;
  static const bondsFlags = _Paths.character + _Paths.bondsFlags;
  static const classAlignments = _Paths.character + _Paths.classAlignments;
  static const selectCharacterTheme = _Paths.character + _Paths.selectCharacterTheme;
  static const account = _Paths.account;
}

abstract class _Paths {
  _Paths._();

  static const home = '/';
  static const account = '/account';
  static const about = '/about';
  static const character = '/character';
  static const characterList = '/characters';
  static const importExport = '/import-export';
  static const login = '/login';
  static const migration = '/migration';
  static const rollDice = '/roll';
  static const search = '/search';
  static const edit = '/edit';
  static const create = '/edit';
  static const settings = '/settings';
  static const userMenu = '/user-menu';

  static const abilityScores = '/roll-stats';
  static const basicInfo = '/basic-info';
  static const characterClass = '/class';
  static const selectMovesSpells = '/moves-and-spells';
  static const startingGear = '/starting-gear';

  static const library = '/library';
  static const moves = '/moves';
  static const spells = '/spells';
  static const items = '/items';
  static const races = '/races';
  static const notes = '/notes';

  static const abilityScoreForm = '/ability-score';
  static const bio = '/biography';
  static const bondsFlags = '/bonds-flags';
  static const classAlignments = '/class-alignments';
  static const selectCharacterTheme = '/character-theme';
}
