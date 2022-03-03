// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Dungeon Paper`
  String get appName {
    return Intl.message(
      'Dungeon Paper',
      name: 'appName',
      desc: 'The name of the app',
      args: [],
    );
  }

  /// `All Characters`
  String get characterListTitle {
    return Intl.message(
      'All Characters',
      name: 'characterListTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create Character`
  String get createCharacterTitle {
    return Intl.message(
      'Create Character',
      name: 'createCharacterTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Character`
  String get createCharacterAddButton {
    return Intl.message(
      'Add Character',
      name: 'createCharacterAddButton',
      desc: '',
      args: [],
    );
  }

  /// `Character Name`
  String get createCharacterNameFieldLabel {
    return Intl.message(
      'Character Name',
      name: 'createCharacterNameFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter your character's name`
  String get createCharacterNameFieldPlaceholder {
    return Intl.message(
      'Enter your character\'s name',
      name: 'createCharacterNameFieldPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Biography/description`
  String get createCharacterDescFieldLabel {
    return Intl.message(
      'Biography/description',
      name: 'createCharacterDescFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Enter general information about your character - backstory, goals & ambitions, behavior descriptions, etc`
  String get createCharacterDescFieldPlaceholder {
    return Intl.message(
      'Enter general information about your character - backstory, goals & ambitions, behavior descriptions, etc',
      name: 'createCharacterDescFieldPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Photo URL`
  String get createCharacterAvatarFieldLabel {
    return Intl.message(
      'Photo URL',
      name: 'createCharacterAvatarFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Paste an image URL`
  String get createCharacterAvatarFieldPlaceholder {
    return Intl.message(
      'Paste an image URL',
      name: 'createCharacterAvatarFieldPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Level {level} ∙ {charClass} ∙ {alignment}`
  String characterHeaderSubtitle(
      int level, String charClass, String alignment) {
    return Intl.message(
      'Level $level ∙ $charClass ∙ $alignment',
      name: 'characterHeaderSubtitle',
      desc: '',
      args: [level, charClass, alignment],
    );
  }

  /// `Items`
  String get quickIconsItems {
    return Intl.message(
      'Items',
      name: 'quickIconsItems',
      desc: '',
      args: [],
    );
  }

  /// `Spells`
  String get quickIconsSpells {
    return Intl.message(
      'Spells',
      name: 'quickIconsSpells',
      desc: '',
      args: [],
    );
  }

  /// `Moves`
  String get quickIconsMoves {
    return Intl.message(
      'Moves',
      name: 'quickIconsMoves',
      desc: '',
      args: [],
    );
  }

  /// `+ Note`
  String get quickIconsNote {
    return Intl.message(
      '+ Note',
      name: 'quickIconsNote',
      desc: '',
      args: [],
    );
  }

  /// `{alignment, select, chaotic {Chaotic} evil {Evil} good {Good} lawful {Lawful} neutral {Neutral}}`
  String alignment(Object alignment) {
    return Intl.select(
      alignment,
      {
        'chaotic': 'Chaotic',
        'evil': 'Evil',
        'good': 'Good',
        'lawful': 'Lawful',
        'neutral': 'Neutral',
      },
      name: 'alignment',
      desc: '',
      args: [alignment],
    );
  }

  /// `HP`
  String get characterBarHp {
    return Intl.message(
      'HP',
      name: 'characterBarHp',
      desc: '',
      args: [],
    );
  }

  /// `XP`
  String get characterBarXp {
    return Intl.message(
      'XP',
      name: 'characterBarXp',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Moves`
  String get dynamicCategoriesMoves {
    return Intl.message(
      'Favorite Moves',
      name: 'dynamicCategoriesMoves',
      desc: '',
      args: [],
    );
  }

  /// `Prepared Spells`
  String get dynamicCategoriesSpells {
    return Intl.message(
      'Prepared Spells',
      name: 'dynamicCategoriesSpells',
      desc: '',
      args: [],
    );
  }

  /// `Equipped Items`
  String get dynamicCategoriesItems {
    return Intl.message(
      'Equipped Items',
      name: 'dynamicCategoriesItems',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Notes`
  String get dynamicCategoriesNotes {
    return Intl.message(
      'Favorite Notes',
      name: 'dynamicCategoriesNotes',
      desc: '',
      args: [],
    );
  }

  /// `{category, select, starting {Starting} basic {Basic} special {Special} advanced1 {Advanced} advanced2 {Advanced} other {Other}}`
  String moveCategory(Object category) {
    return Intl.select(
      category,
      {
        'starting': 'Starting',
        'basic': 'Basic',
        'special': 'Special',
        'advanced1': 'Advanced',
        'advanced2': 'Advanced',
        'other': 'Other',
      },
      name: 'moveCategory',
      desc: '',
      args: [category],
    );
  }

  /// `Roll +{stat}`
  String rollStatButtonTooltip(String stat) {
    return Intl.message(
      'Roll +$stat',
      name: 'rollStatButtonTooltip',
      desc: '',
      args: [stat],
    );
  }

  /// `Basic Action`
  String get rollBasicActionButton {
    return Intl.message(
      'Basic Action',
      name: 'rollBasicActionButton',
      desc: '',
      args: [],
    );
  }

  /// `Attack + Damage`
  String get rollAttackDamageButton {
    return Intl.message(
      'Attack + Damage',
      name: 'rollAttackDamageButton',
      desc: '',
      args: [],
    );
  }

  /// `{step, select, information {Basic Information} charClass {Class} stats {Roll Stats} movesSpells {Moves & Spells} background {Background & Bonds} gear {Starting Gear}}`
  String createCharacterStep(Object step) {
    return Intl.select(
      step,
      {
        'information': 'Basic Information',
        'charClass': 'Class',
        'stats': 'Roll Stats',
        'movesSpells': 'Moves & Spells',
        'background': 'Background & Bonds',
        'gear': 'Starting Gear',
      },
      name: 'createCharacterStep',
      desc: '',
      args: [step],
    );
  }

  /// `{step} - Changes Required`
  String createCharacterStepInvalidTooltip(Object step) {
    return Intl.message(
      '$step - Changes Required',
      name: 'createCharacterStepInvalidTooltip',
      desc: '',
      args: [step],
    );
  }

  /// `Continue`
  String get createCharacterProceedTooltip {
    return Intl.message(
      'Continue',
      name: 'createCharacterProceedTooltip',
      desc: '',
      args: [],
    );
  }

  /// `Review`
  String get createCharacterFinishButton {
    return Intl.message(
      'Review',
      name: 'createCharacterFinishButton',
      desc: '',
      args: [],
    );
  }

  /// `Create Character`
  String get createCharacterSaveButton {
    return Intl.message(
      'Create Character',
      name: 'createCharacterSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `Add Moves`
  String get addMoves {
    return Intl.message(
      'Add Moves',
      name: 'addMoves',
      desc: '',
      args: [],
    );
  }

  /// `Add Spells`
  String get addSpells {
    return Intl.message(
      'Add Spells',
      name: 'addSpells',
      desc: '',
      args: [],
    );
  }

  /// `Biography`
  String get createCharacterBioFieldLabel {
    return Intl.message(
      'Biography',
      name: 'createCharacterBioFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Describe your character as shortly or thoroughly as you want here.\nPut your backstory, a visual description, some personality traits, etc. to help you keep in character.`
  String get createCharacterBioFieldPlaceholder {
    return Intl.message(
      'Describe your character as shortly or thoroughly as you want here.\nPut your backstory, a visual description, some personality traits, etc. to help you keep in character.',
      name: 'createCharacterBioFieldPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Race`
  String get createCharacterRaceNameFieldLabel {
    return Intl.message(
      'Race',
      name: 'createCharacterRaceNameFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Race name`
  String get createCharacterRaceNameFieldPlaceholder {
    return Intl.message(
      'Race name',
      name: 'createCharacterRaceNameFieldPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Race description`
  String get createCharacterRaceDescFieldLabel {
    return Intl.message(
      'Race description',
      name: 'createCharacterRaceDescFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Describe a special move usable by your race. It will appear alongside the rest of the moves.`
  String get createCharacterRaceDescFieldPlaceholder {
    return Intl.message(
      'Describe a special move usable by your race. It will appear alongside the rest of the moves.',
      name: 'createCharacterRaceDescFieldPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Preview Character`
  String get createCharacterPreviewPageTitle {
    return Intl.message(
      'Preview Character',
      name: 'createCharacterPreviewPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Max HP: {hp}`
  String createCharacterPreviewPageMaxHp(int hp) {
    return Intl.message(
      'Max HP: $hp',
      name: 'createCharacterPreviewPageMaxHp',
      desc: '',
      args: [hp],
    );
  }

  /// `Tap to generate a random name`
  String get createCharRandomizeNameTooltipTouch {
    return Intl.message(
      'Tap to generate a random name',
      name: 'createCharRandomizeNameTooltipTouch',
      desc: '',
      args: [],
    );
  }

  /// `Click to generate a random name`
  String get createCharRandomizeNameTooltipClick {
    return Intl.message(
      'Click to generate a random name',
      name: 'createCharRandomizeNameTooltipClick',
      desc: '',
      args: [],
    );
  }

  /// `Moves`
  String get moves {
    return Intl.message(
      'Moves',
      name: 'moves',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one {One Move} other {{count} Moves}}`
  String movesWithCount(num count) {
    return Intl.plural(
      count,
      one: 'One Move',
      other: '$count Moves',
      name: 'movesWithCount',
      desc: '',
      args: [count],
    );
  }

  /// `Spells`
  String get spells {
    return Intl.message(
      'Spells',
      name: 'spells',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one {One Spell} other {{count} Spells}}`
  String spellsWithCount(num count) {
    return Intl.plural(
      count,
      one: 'One Spell',
      other: '$count Spells',
      name: 'spellsWithCount',
      desc: '',
      args: [count],
    );
  }

  /// `Items`
  String get items {
    return Intl.message(
      'Items',
      name: 'items',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one {One Item} other {{count} Items}}`
  String itemsWithCount(num count) {
    return Intl.plural(
      count,
      one: 'One Item',
      other: '$count Items',
      name: 'itemsWithCount',
      desc: '',
      args: [count],
    );
  }

  /// `Coins`
  String get coins {
    return Intl.message(
      'Coins',
      name: 'coins',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, one {One Coin} other {{fmtCount} Coins}}`
  String coinsWithCount(num count, Object fmtCount) {
    return Intl.plural(
      count,
      one: 'One Coin',
      other: '$fmtCount Coins',
      name: 'coinsWithCount',
      desc: '',
      args: [count, fmtCount],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
