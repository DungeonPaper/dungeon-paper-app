part of 'app_pages.dart';
// DO NOT EDIT. This is code generated via package:get_cli/get_cli.dart

abstract class Routes {
  Routes._();

  static const login = _Paths.login;
  static const userMenu = _Paths.userMenu;
  static const home = _Paths.home;
  static const characterList = _Paths.characterList;
  static const rollDice = _Paths.rollDice;
  static const settings = _Paths.settings;
  static const importExport = _Paths.importExport;

  static const library = _Paths.library;
  static const moves = _Paths.moves;
  static const spells = _Paths.spells;
  static const items = _Paths.items;
  static const notes = _Paths.notes;
  static const characterClass = _Paths.characterClass;

  static const basicInfo = _Paths.basicInfo;
  static const bondsFlags = _Paths.bondsFlags;
  static const abilityScores = _Paths.abilityScores;
  static const bio = _Paths.bio;

  static listByType<T extends WithMeta>() => {
        Move: _Paths.moves,
        Spell: _Paths.spells,
        Item: _Paths.items,
      }[T];

  static const createCharacter = _Paths.createCharacter;
  static const createCharacterSelectClass = _Paths.createCharacter + _Paths.characterClass;
  static const createCharacterAbilityScores = _Paths.createCharacter + _Paths.abilityScores;
  static const createCharacterMovesSpells = _Paths.createCharacter + _Paths.selectMovesSpells;
  static const createCharacterBasicInfo = _Paths.createCharacter + _Paths.basicInfo;
  static const createCharacterStartingGear = _Paths.createCharacter + _Paths.startingGear;
  static const hpDialog = _Paths.hpDialog;
  static const classAlignments = _Paths.classAlignments;
  static const universalSearch = _Paths.universalSearch;
  static const migration = _Paths.migration;
  static const about = _Paths.about;
}

abstract class _Paths {
  _Paths._();

  static const login = '/login';
  static const userMenu = '/user-menu';
  static const home = '/';
  static const characterList = '/character-list';
  static const rollDice = '/roll';
  static const settings = '/settings';
  static const importExport = '/import-export';

  static const createCharacter = '/create-character';
  static const basicInfo = '/basic-info';
  static const abilityScores = '/roll-stats';
  static const startingGear = '/starting-gear';
  static const selectMovesSpells = '/moves-spells';
  static const characterClass = '/character-class';

  static const library = '/library';
  static const moves = '/moves';
  static const spells = '/spells';
  static const items = '/items';
  static const notes = '/notes';
  static const bondsFlags = '/bonds-flags';
  static const bio = '/biography';
  static const hpDialog = '/edit-hp';
  static const classAlignments = '/class-alignments';
  static const universalSearch = '/universal-search';
  static const migration = '/migration';
  static const about = '/about';
}
