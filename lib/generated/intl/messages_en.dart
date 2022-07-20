// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(stat) => "Roll +${stat}";

  static String m1(modifier) => "Modifier:\n${modifier}";

  static String m2(coins) => "${coins} G";

  static String m3(load, maxLoad) => "Load: ${load}/${maxLoad}";

  static String m4(entity) => "Add New ${entity}";

  static String m5(entity) => "Add Existing ${entity}";

  static String m6(entity) => "Add ${entity}";

  static String m7(string) => "Add ${string}";

  static String m8(alignment) => "${Intl.select(alignment, {
            'chaotic': 'Chaotic',
            'evil': 'Evil',
            'good': 'Good',
            'lawful': 'Lawful',
            'neutral': 'Neutral',
          })}";

  static String m9(entity) => "All ${entity}";

  static String m10(entity) => "Change ${entity}";

  static String m11(level, charClass, race) =>
      "Level ${level} ∙ ${charClass} ∙ ${race} ∙";

  static String m12(alignment) => "${alignment}";

  static String m13(charClass) => "${charClass}";

  static String m14(level) => "Level ${level}";

  static String m15(race) => "${race}";

  static String m16(count, fmtCount) =>
      "${Intl.plural(count, zero: 'No coins', one: 'One coin', other: '${fmtCount} coins')}";

  static String m17(entity, name) =>
      "Are you sure you want to remove the ${entity} \"${name}\" from the list?";

  static String m18(entity) => "Delete ${entity}?";

  static String m19(hp, load, damageDice) =>
      "Base HP: ${hp}, Load: ${load}, Damage Dice: ${damageDice}";

  static String m20(hp) => "Max HP: ${hp}";

  static String m21(count) => "${count} selected";

  static String m22(count, max) =>
      "${count} selected (class allowance: ${max})";

  static String m23(amount) => "${amount} coins";

  static String m24(amount, name) => "${amount} × ${name}";

  static String m25(step) => "${step} - Changes Required";

  static String m26(cls) => "Level 1 ${cls}";

  static String m27(entity) => "Create ${entity}";

  static String m28(name, key) => "${name} (${key})";

  static String m29(dice) => "Suggested: ${dice}";

  static String m30(name, key) => "${name} (${key})";

  static String m31(entity) => "Edit ${entity}";

  static String m32(runtimeType) => "${Intl.select(runtimeType, {
            'CharacterClass': 'Class',
            'Item': 'Item',
            'Monster': 'Monster',
            'Move': 'Move',
            'Race': 'Race',
            'Spell': 'Spell',
            'Tag': 'Tag',
            'MoveCategory': 'Category',
            'GearSelection': 'Starting Gear',
            'Dice': 'Dice',
            'AbilityScore': 'Ability Score',
            'AlignmentValue': 'Alignment',
            'Playbook': 'Playbook',
            'other': '${runtimeType}',
          })}";

  static String m33(runtimeType) => "${Intl.select(runtimeType, {
            'CharacterClass': 'Classes',
            'Item': 'Items',
            'Monster': 'Monsters',
            'Move': 'Moves',
            'Race': 'Races',
            'Spell': 'Spells',
            'Tag': 'Tags',
            'MoveCategory': 'Categories',
            'Dice': 'Dice',
            'GearSelection': 'Starting Gear',
            'AbilityScore': 'Ability Scores',
            'AlignmentValue': 'Alignment',
            'Playbook': 'Playbooks',
            'other': '${runtimeType}s',
          })}";

  static String m34(entity) =>
      "This ${entity} is not linked to any library item";

  static String m35(entity) =>
      "This ${entity} is In Sync with its linked library item";

  static String m36(entity) =>
      "This ${entity} is Out of Sync with its linked library item";

  static String m37(count, entPlural, ent) =>
      "${Intl.plural(count, zero: 'No ${entPlural}', one: 'One ${ent}', other: '${count} ${entPlural}')}";

  static String m38(entity) => "No ${entity} selected";

  static String m39(entity) => "No ${entity} selected (required)";

  static String m40(amount) => "Add\n+${amount}";

  static String m41(amount) => "Reduce\n-${amount}";

  static String m42(entity) => "${entity} category";

  static String m43(entity) => "${entity} description";

  static String m44(entity) => "${entity} explanation";

  static String m45(entity) => "${entity} name";

  static String m46(entity) => "${entity} title";

  static String m47(n) => "Cell ${n}";

  static String m48(n) => "Header ${n}";

  static String m49(n) => "Header ${n}";

  static String m50(n) => "Heading ${n}";

  static String m51(entity) => "${entity} description";

  static String m52(entity) => "${entity} name";

  static String m53(entity) => "${entity} value";

  static String m54(amount) => "Heal\n+${amount}";

  static String m55(amount) => "Damage\n-${amount}";

  static String m56(entity) => "Processing ${entity}...";

  static String m57(amount) => "× ${amount}";

  static String m58(count) =>
      "${Intl.plural(count, zero: 'No items', one: 'One item', other: '${count} items')}";

  static String m59(count, type) => "${count} in ${type}";

  static String m60(type) => "${Intl.select(type, {
            'builtIn': 'Playbook',
            'my': 'My Library',
            'other': '${type}',
          })}";

  static String m61(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced',
            'advanced2': 'Advanced',
            'other': 'Other',
          })}";

  static String m62(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced (level 1-5)',
            'advanced2': 'Advanced (level 6-10)',
            'other': 'Other',
          })}";

  static String m63(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced (1-5)',
            'advanced2': 'Advanced (6-10)',
            'other': 'Other',
          })}";

  static String m64(entity) => "Move ${entity} to bottom";

  static String m65(entity) => "Move ${entity} to top";

  static String m66(count) =>
      "${Intl.plural(count, zero: 'No moves', one: 'One move', other: '${count} moves')}";

  static String m67(entity) => "My ${entity}";

  static String m68(entity) => "No ${entity}";

  static String m69(count) =>
      "${Intl.plural(count, zero: 'No notes', one: 'One note', other: '${count} notes')}";

  static String m70(count, singular, plural) =>
      "${Intl.plural(count, one: 'One ${singular}', other: '${count} ${plural}')}";

  static String m71(dice) => "Roll ${dice}";

  static String m72(dice) => "Roll ${dice}\n* Rolling with debility";

  static String m73(dice, mod) => "Dice: ${dice} | Modifier: ${mod}";

  static String m74(total) => "Total: ${total}";

  static String m75(total) => "Total: ${total}";

  static String m76(count) => "Rolling ${count} dice";

  static String m77(entity) => "Save ${entity}";

  static String m78(entity) => "Type to search ${entity}";

  static String m79(entity) => "Select ${entity}";

  static String m80(string) => "Select ${string} to add";

  static String m81(length) => "Password must be at least ${length} characters";

  static String m82(pattern) => "Password must contain ${pattern}";

  static String m83(length) => "Username must be at least ${length} characters";

  static String m84(button) => "${Intl.select(button, {
            'damage': 'Damage',
            'other': '${button}',
          })}";

  static String m85(level) => "${Intl.select(level, {
            'cantrip': 'Cantrip',
            'rote': 'Rote',
            'other': 'Level ${level}',
          })}";

  static String m86(count) =>
      "${Intl.plural(count, zero: 'No spells', one: 'One spell', other: '${count} spells')}";

  static String m87(tag) => "Copy from: ${tag}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "abilityScoreBondDebilityDescription":
            MessageLookupByLibrary.simpleMessage(""),
        "abilityScoreBondDebilityName":
            MessageLookupByLibrary.simpleMessage("Lonely"),
        "abilityScoreBondDescription": MessageLookupByLibrary.simpleMessage(
            "When a move has you roll+BOND you\'ll count the number of bonds you have with the character in question and add that to the roll."),
        "abilityScoreBondName":
            MessageLookupByLibrary.simpleMessage("Charisma"),
        "abilityScoreButtonTooltip": m0,
        "abilityScoreChaDebilityDescription":
            MessageLookupByLibrary.simpleMessage(
                "It may not be permanent, but for now you don\'t look so good."),
        "abilityScoreChaDebilityName":
            MessageLookupByLibrary.simpleMessage("Scarred"),
        "abilityScoreChaDescription": MessageLookupByLibrary.simpleMessage(
            "Measures a character\'s personality, personal magnetism, ability to lead, and appearance."),
        "abilityScoreChaName": MessageLookupByLibrary.simpleMessage("Charisma"),
        "abilityScoreConDebilityDescription": MessageLookupByLibrary.simpleMessage(
            "Something just isn\'t right inside. Maybe you\'ve got a disease or a wasting illness. Maybe you just drank too much ale last night and it\'s coming back to haunt you."),
        "abilityScoreConDebilityName":
            MessageLookupByLibrary.simpleMessage("Sick"),
        "abilityScoreConDescription": MessageLookupByLibrary.simpleMessage(
            "Represents your character\'s health and stamina."),
        "abilityScoreConName":
            MessageLookupByLibrary.simpleMessage("Constitution"),
        "abilityScoreDexDebilityDescription": MessageLookupByLibrary.simpleMessage(
            "You\'re unsteady on your feet and you\'ve got a shake in your hands."),
        "abilityScoreDexDebilityName":
            MessageLookupByLibrary.simpleMessage("Shaky"),
        "abilityScoreDexDescription": MessageLookupByLibrary.simpleMessage(
            "Measures agility, reflexes and balance."),
        "abilityScoreDexName":
            MessageLookupByLibrary.simpleMessage("Dexterity"),
        "abilityScoreInfo": MessageLookupByLibrary.simpleMessage(
            "You can drag & drop the stat cards to change the order in which they appear throughout this character\'s screens."),
        "abilityScoreIntDebilityDescription": MessageLookupByLibrary.simpleMessage(
            "That last knock to the head shook something loose. Brain not work so good."),
        "abilityScoreIntDebilityName":
            MessageLookupByLibrary.simpleMessage("Stunned"),
        "abilityScoreIntDescription": MessageLookupByLibrary.simpleMessage(
            "Determines how well your character learns and reasons."),
        "abilityScoreIntName":
            MessageLookupByLibrary.simpleMessage("Intelligence"),
        "abilityScoreModifierValueLabel": m1,
        "abilityScoreRollButtonTooltip":
            MessageLookupByLibrary.simpleMessage("Roll random stat"),
        "abilityScoreStrDebilityDescription": MessageLookupByLibrary.simpleMessage(
            "You can\'t exert much force. Maybe it\'s just fatigue and injury, or maybe your strength was drained by magic."),
        "abilityScoreStrDebilityName":
            MessageLookupByLibrary.simpleMessage("Weak"),
        "abilityScoreStrDescription": MessageLookupByLibrary.simpleMessage(
            "Measures muscle and physical power."),
        "abilityScoreStrName": MessageLookupByLibrary.simpleMessage("Strength"),
        "abilityScoreWisDebilityDescription": MessageLookupByLibrary.simpleMessage(
            "Ears ringing. Vision blurred. You\'re more than a little out of it."),
        "abilityScoreWisDebilityName":
            MessageLookupByLibrary.simpleMessage("Confused"),
        "abilityScoreWisDescription": MessageLookupByLibrary.simpleMessage(
            "Describes a character\'s willpower, common sense, awareness, and intuition."),
        "abilityScoreWisName": MessageLookupByLibrary.simpleMessage("Wisdom"),
        "aboutTitle": MessageLookupByLibrary.simpleMessage("About"),
        "actionSummaryChipCoins": m2,
        "actionSummaryChipLoad": m3,
        "actionsViewVisibleLabel": MessageLookupByLibrary.simpleMessage("Show"),
        "addCustomGeneric": m4,
        "addExistingGeneric": m5,
        "addGeneric": m6,
        "addRepoItemTabOnline": MessageLookupByLibrary.simpleMessage("Online"),
        "addRepoItemTabPlaybook":
            MessageLookupByLibrary.simpleMessage("Playbook"),
        "addWithCount": m7,
        "alignment": m8,
        "alignmentLabel": MessageLookupByLibrary.simpleMessage("Alignment"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "allGeneric": m9,
        "alreadyAdded": MessageLookupByLibrary.simpleMessage("Already added"),
        "amount": MessageLookupByLibrary.simpleMessage("Amount"),
        "appName": MessageLookupByLibrary.simpleMessage("Dungeon Paper"),
        "armor": MessageLookupByLibrary.simpleMessage("Armor"),
        "basicInfoImageChoose":
            MessageLookupByLibrary.simpleMessage("Choose Photo..."),
        "basicInfoImageChooseNew":
            MessageLookupByLibrary.simpleMessage("Change Photo..."),
        "basicInfoImageNeedAccountLinkLabel":
            MessageLookupByLibrary.simpleMessage(
                "Sign in or create an account"),
        "basicInfoImageNeedAccountPrefix": MessageLookupByLibrary.simpleMessage(
            "You need to be signed in to upload images."),
        "basicInfoImageNeedAccountSuffix": MessageLookupByLibrary.simpleMessage(
            ", or upload using your own URL below."),
        "basicInfoImageRemove":
            MessageLookupByLibrary.simpleMessage("Remove Photo"),
        "basicInfoImageUploading":
            MessageLookupByLibrary.simpleMessage("UPLOADING..."),
        "basicInformationTitle":
            MessageLookupByLibrary.simpleMessage("Basic Information"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "changeGeneric": m10,
        "characterAutoArmor": MessageLookupByLibrary.simpleMessage(
            "Use armor from class & equipped items"),
        "characterAutoDamage": MessageLookupByLibrary.simpleMessage(
            "Use damage dice from class & equipped items"),
        "characterAutoMaxLoad": MessageLookupByLibrary.simpleMessage(
            "Use class base HP + Constitution (score)"),
        "characterBarHp": MessageLookupByLibrary.simpleMessage("HP"),
        "characterBarXp": MessageLookupByLibrary.simpleMessage("XP"),
        "characterBioDialogAlignmentDescriptionLabel":
            MessageLookupByLibrary.simpleMessage("Alignment Description"),
        "characterBioDialogAlignmentDescriptionPlaceholder":
            MessageLookupByLibrary.simpleMessage(
                "Alignment is your character\'s way of thinking and moral compass. This can center on an ethical ideal, religious strictures or early life events. It reflects what your character values and aspires to protect or create."),
        "characterBioDialogAlignmentNameDisplayLabel":
            MessageLookupByLibrary.simpleMessage("Alignment:"),
        "characterBioDialogAlignmentNameLabel":
            MessageLookupByLibrary.simpleMessage("Alignment"),
        "characterBioDialogAlignmentNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("Select alignment"),
        "characterBioDialogDescLabel": MessageLookupByLibrary.simpleMessage(
            "Character & background description"),
        "characterBioDialogDescPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Describe your character\'s background, personality, goals, etc."),
        "characterBioDialogLooksLabel":
            MessageLookupByLibrary.simpleMessage("Looks"),
        "characterBioDialogLooksPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Describe your character\'s appearance. You may use the presets from the buttons above."),
        "characterBioDialogTitle":
            MessageLookupByLibrary.simpleMessage("Character Biography"),
        "characterBondsFlagsDialogBond":
            MessageLookupByLibrary.simpleMessage("Bond"),
        "characterBondsFlagsDialogBonds":
            MessageLookupByLibrary.simpleMessage("Bonds"),
        "characterBondsFlagsDialogFlag":
            MessageLookupByLibrary.simpleMessage("Flag"),
        "characterBondsFlagsDialogFlags":
            MessageLookupByLibrary.simpleMessage("Flags"),
        "characterBondsFlagsDialogNoData": MessageLookupByLibrary.simpleMessage(
            "You have no bonds or flags. You can add some using the edit button above, then mark them off as completed as you go along your adventure."),
        "characterBondsFlagsDialogTitle":
            MessageLookupByLibrary.simpleMessage("Bonds & Flags"),
        "characterDebilitiesDialogTitle":
            MessageLookupByLibrary.simpleMessage("Debilities"),
        "characterHeaderSubtitle": m11,
        "characterHeaderSubtitleAlignment": m12,
        "characterHeaderSubtitleClass": m13,
        "characterHeaderSubtitleLevel": m14,
        "characterHeaderSubtitleRace": m15,
        "characterHeaderSubtitleSeparator":
            MessageLookupByLibrary.simpleMessage(" ∙ "),
        "characterListTitle":
            MessageLookupByLibrary.simpleMessage("All Characters"),
        "characterNoCategory":
            MessageLookupByLibrary.simpleMessage("No Category"),
        "characterRollsTitle":
            MessageLookupByLibrary.simpleMessage("Ability Scores"),
        "characterSelectTheme":
            MessageLookupByLibrary.simpleMessage("Character Theme"),
        "coins": MessageLookupByLibrary.simpleMessage("Coins"),
        "coinsWithCount": m16,
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmDeleteBody": m17,
        "confirmDeleteTitle": m18,
        "confirmExitDefaultCancelLabel":
            MessageLookupByLibrary.simpleMessage("Continue editing"),
        "confirmExitDefaultOkLabel":
            MessageLookupByLibrary.simpleMessage("Exit & Discard"),
        "confirmExitDefaultText": MessageLookupByLibrary.simpleMessage(
            "Going back will lose any unsaved changes.\nAre you sure you want to go back?"),
        "confirmExitDefaultTitle":
            MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "continueLabel": MessageLookupByLibrary.simpleMessage("Continue"),
        "createCharRandomizeNameTooltipClick":
            MessageLookupByLibrary.simpleMessage(
                "Click to generate a random name"),
        "createCharRandomizeNameTooltipTouch":
            MessageLookupByLibrary.simpleMessage(
                "Tap to generate a random name"),
        "createCharacterAddButton":
            MessageLookupByLibrary.simpleMessage("Create Character"),
        "createCharacterAvatarFieldLabel":
            MessageLookupByLibrary.simpleMessage("Photo URL"),
        "createCharacterAvatarFieldPlaceholder":
            MessageLookupByLibrary.simpleMessage("Paste an image URL"),
        "createCharacterBioFieldLabel":
            MessageLookupByLibrary.simpleMessage("Biography"),
        "createCharacterBioFieldPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Describe your character as shortly or thoroughly as you want here.\nPut your backstory, a visual description, some personality traits, etc. to help you keep in character."),
        "createCharacterClassDescription": m19,
        "createCharacterClassHelpText": MessageLookupByLibrary.simpleMessage(
            "No class selected (required)"),
        "createCharacterDescFieldLabel":
            MessageLookupByLibrary.simpleMessage("Biography/description"),
        "createCharacterDescFieldPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Enter general information about your character - backstory, goals & ambitions, behavior descriptions, etc"),
        "createCharacterFinishButton":
            MessageLookupByLibrary.simpleMessage("Review"),
        "createCharacterMovesSpells":
            MessageLookupByLibrary.simpleMessage("Moves & Spells"),
        "createCharacterNameFieldLabel":
            MessageLookupByLibrary.simpleMessage("Character Name"),
        "createCharacterNameFieldPlaceholder":
            MessageLookupByLibrary.simpleMessage(
                "Enter your character\'s name"),
        "createCharacterPreviewPageMaxHp": m20,
        "createCharacterPreviewPageTitle":
            MessageLookupByLibrary.simpleMessage("Preview Character"),
        "createCharacterProceedTooltip":
            MessageLookupByLibrary.simpleMessage("Continue"),
        "createCharacterRaceDescFieldLabel":
            MessageLookupByLibrary.simpleMessage("Race description"),
        "createCharacterRaceDescFieldPlaceholder":
            MessageLookupByLibrary.simpleMessage(
                "Describe a special move usable by your race. It will appear alongside the rest of the moves."),
        "createCharacterRaceNameFieldLabel":
            MessageLookupByLibrary.simpleMessage("Race"),
        "createCharacterRaceNameFieldPlaceholder":
            MessageLookupByLibrary.simpleMessage("Race name"),
        "createCharacterSaveButton":
            MessageLookupByLibrary.simpleMessage("Create Character"),
        "createCharacterStartingGearChoiceCountNoMax": m21,
        "createCharacterStartingGearChoiceCountWithMax": m22,
        "createCharacterStartingGearDescriptionCoins": m23,
        "createCharacterStartingGearDescriptionItem": m24,
        "createCharacterStartingGearHelpText":
            MessageLookupByLibrary.simpleMessage(
                "Select your starting gear determined by class (optional)"),
        "createCharacterStepInvalidTooltip": m25,
        "createCharacterTitle":
            MessageLookupByLibrary.simpleMessage("Create Character"),
        "createCharacterTravelerBlankName":
            MessageLookupByLibrary.simpleMessage("Unnamed Traveler"),
        "createCharacterTravelerDescription": m26,
        "createCharacterTravelerHelpText": MessageLookupByLibrary.simpleMessage(
            "Select name & picture (required)"),
        "createGeneric": m27,
        "customButtonLeft": MessageLookupByLibrary.simpleMessage("Left Button"),
        "customButtonRight":
            MessageLookupByLibrary.simpleMessage("Right Button"),
        "customRollButtons":
            MessageLookupByLibrary.simpleMessage("Quick Roll Buttons"),
        "damage": MessageLookupByLibrary.simpleMessage("Damage"),
        "damageDice": MessageLookupByLibrary.simpleMessage("Damage Dice"),
        "debilityLabel": m28,
        "diceAmount": MessageLookupByLibrary.simpleMessage("Amount"),
        "diceRollAgain": MessageLookupByLibrary.simpleMessage("Roll"),
        "diceSeparator": MessageLookupByLibrary.simpleMessage("d"),
        "diceSides": MessageLookupByLibrary.simpleMessage("Sides"),
        "diceSuggestion": m29,
        "diceUseStat": MessageLookupByLibrary.simpleMessage("Roll Stat"),
        "diceUseStatLabel": MessageLookupByLibrary.simpleMessage("Stat"),
        "diceUseStatPlaceholder":
            MessageLookupByLibrary.simpleMessage("Select Stat"),
        "diceUseStatValue": m30,
        "diceUseValue": MessageLookupByLibrary.simpleMessage("Fixed Value"),
        "diceUseValueLabel":
            MessageLookupByLibrary.simpleMessage("Modifier value"),
        "diceUseValuePlaceholder":
            MessageLookupByLibrary.simpleMessage("Number, e.g. 2 or -1"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "dynamicCategoriesItems":
            MessageLookupByLibrary.simpleMessage("Equipped Items"),
        "dynamicCategoriesMoves":
            MessageLookupByLibrary.simpleMessage("Favorite Moves"),
        "dynamicCategoriesNotes":
            MessageLookupByLibrary.simpleMessage("Bookmarked Notes"),
        "dynamicCategoriesSpells":
            MessageLookupByLibrary.simpleMessage("Prepared Spells"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editGeneric": m31,
        "endOfSessionQ1": MessageLookupByLibrary.simpleMessage(
            "Did we learn something new and important about the world?"),
        "endOfSessionQ2": MessageLookupByLibrary.simpleMessage(
            "Did we overcome a notable monster or enemy?"),
        "endOfSessionQ3": MessageLookupByLibrary.simpleMessage(
            "Did we loot a memorable treasure?"),
        "endOfSessionQuestions":
            MessageLookupByLibrary.simpleMessage("End of Session Questions"),
        "endOfSessionQuestionsSubtitle": MessageLookupByLibrary.simpleMessage(
            "Answer these questions as a group. For each \"yes\" answer, XP is marked."),
        "entity": m32,
        "entityPlural": m33,
        "entityShareStatusDetached": m34,
        "entityShareStatusInSync": m35,
        "entityShareStatusOutOfSync": m36,
        "entityWithCount": m37,
        "errorNoSelection":
            MessageLookupByLibrary.simpleMessage("None selected"),
        "errorNoSelectionGeneric": m38,
        "errorNoSelectionGenericRequired": m39,
        "errorUserOperationCanceled":
            MessageLookupByLibrary.simpleMessage("Operation canceled"),
        "expDialogChangeAdd": m40,
        "expDialogChangeNeutral":
            MessageLookupByLibrary.simpleMessage("No Change"),
        "expDialogChangeOverride":
            MessageLookupByLibrary.simpleMessage("Override XP & Level"),
        "expDialogChangeRemove": m41,
        "expDialogCurrentXP":
            MessageLookupByLibrary.simpleMessage("Current XP"),
        "expDialogEndSession":
            MessageLookupByLibrary.simpleMessage("End Session"),
        "expDialogLevelShouldOverride":
            MessageLookupByLibrary.simpleMessage("Set level manually"),
        "expDialogTitle": MessageLookupByLibrary.simpleMessage("Modify XP"),
        "explanation": MessageLookupByLibrary.simpleMessage("Further details"),
        "export": MessageLookupByLibrary.simpleMessage("Export"),
        "exportFailedMessage": MessageLookupByLibrary.simpleMessage(
            "Something went wrong.\nTry again or contact support if this persists"),
        "exportFailedTitle":
            MessageLookupByLibrary.simpleMessage("Export Failed"),
        "exportSuccessfulMessage": MessageLookupByLibrary.simpleMessage(
            "Your data was exported to file successfully"),
        "exportSuccessfulTitle":
            MessageLookupByLibrary.simpleMessage("Export Successful"),
        "formCharacterClassDescriptionPlaceholder":
            MessageLookupByLibrary.simpleMessage(
                "Give a general description of your class. Describe a calling for the type of person or creature that would choose or be raised in to this adventuring profession."),
        "formCharacterClassNamePlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter the class name"),
        "formGeneralCategory": MessageLookupByLibrary.simpleMessage("Category"),
        "formGeneralCategoryGeneric": m42,
        "formGeneralDescription":
            MessageLookupByLibrary.simpleMessage("Description"),
        "formGeneralDescriptionGeneric": m43,
        "formGeneralExplanation":
            MessageLookupByLibrary.simpleMessage("Explanation"),
        "formGeneralExplanationGeneric": m44,
        "formGeneralName": MessageLookupByLibrary.simpleMessage("Name"),
        "formGeneralNameGeneric": m45,
        "formGeneralTitle": MessageLookupByLibrary.simpleMessage("Title"),
        "formGeneralTitleGeneric": m46,
        "formatBold": MessageLookupByLibrary.simpleMessage("Bold"),
        "formatBulletList": MessageLookupByLibrary.simpleMessage("Bullet List"),
        "formatCell": m47,
        "formatCheckboxList":
            MessageLookupByLibrary.simpleMessage("Check List (Checked)"),
        "formatCheckboxListUnchecked":
            MessageLookupByLibrary.simpleMessage("Check List (Unchecked)"),
        "formatHeader": m48,
        "formatHeaderNoNum": m49,
        "formatHeading": m50,
        "formatHeadings": MessageLookupByLibrary.simpleMessage("Headings"),
        "formatHelp": MessageLookupByLibrary.simpleMessage("Formatting Help"),
        "formatImageURL": MessageLookupByLibrary.simpleMessage("Image URL"),
        "formatItalic": MessageLookupByLibrary.simpleMessage("Italic"),
        "formatNumberedList":
            MessageLookupByLibrary.simpleMessage("Numbered List"),
        "formatPreview": MessageLookupByLibrary.simpleMessage("Preview"),
        "formatTable": MessageLookupByLibrary.simpleMessage("Table"),
        "formatURL": MessageLookupByLibrary.simpleMessage("URL"),
        "genericDescriptionField": m51,
        "genericNameField": m52,
        "genericValueField": m53,
        "homeEmptyStateLoginSubtitle": MessageLookupByLibrary.simpleMessage(
            "Online data sync, library sharing, campaigns and more!"),
        "homeEmptyStateLoginTitle": MessageLookupByLibrary.simpleMessage(
            "Sign in to get more features"),
        "homeEmptyStateSubtitle": MessageLookupByLibrary.simpleMessage(
            "Create a Character to get started"),
        "homeEmptyStateTitle":
            MessageLookupByLibrary.simpleMessage("No Characters"),
        "hp": MessageLookupByLibrary.simpleMessage("HP"),
        "hpDialogChangeAdd": m54,
        "hpDialogChangeNeutral":
            MessageLookupByLibrary.simpleMessage("No Change"),
        "hpDialogChangeOverrideMax":
            MessageLookupByLibrary.simpleMessage("Override Max HP:"),
        "hpDialogChangeRemove": m55,
        "hpDialogCurrentHP": MessageLookupByLibrary.simpleMessage("Current HP"),
        "hpDialogTitle": MessageLookupByLibrary.simpleMessage("Modify HP"),
        "import": MessageLookupByLibrary.simpleMessage("Import"),
        "importBrowseFile": MessageLookupByLibrary.simpleMessage("Browse..."),
        "importBrowseHelp": MessageLookupByLibrary.simpleMessage(
            "To start importing, pick the file you want to import from.\nYou will then be able to select what to save and what to leave out."),
        "importClearFile":
            MessageLookupByLibrary.simpleMessage("Clear selected file"),
        "importExportTitle":
            MessageLookupByLibrary.simpleMessage("Export/Import"),
        "importFailedMessage": MessageLookupByLibrary.simpleMessage(
            "Something went wrong.\nTry again or contact support if this persists"),
        "importFailedTitle":
            MessageLookupByLibrary.simpleMessage("Import Failed"),
        "importProgressProcessing": m56,
        "importProgressTitle":
            MessageLookupByLibrary.simpleMessage("Importing..."),
        "importSuccessMessage": MessageLookupByLibrary.simpleMessage(
            "Your data was imported from file successfully"),
        "importSuccessTitle":
            MessageLookupByLibrary.simpleMessage("Successful"),
        "itemAmountX": m57,
        "items": MessageLookupByLibrary.simpleMessage("Items"),
        "itemsWithCount": m58,
        "level": MessageLookupByLibrary.simpleMessage("Level"),
        "libraryCollectionListItemSubtitle": m59,
        "libraryCollectionListItemSubtitleType": m60,
        "libraryCollectionTitle":
            MessageLookupByLibrary.simpleMessage("My Library"),
        "loadingCharacters":
            MessageLookupByLibrary.simpleMessage("Getting characters..."),
        "loadingGeneral": MessageLookupByLibrary.simpleMessage("Loading..."),
        "loadingUser": MessageLookupByLibrary.simpleMessage("Signing in..."),
        "markdownPreview":
            MessageLookupByLibrary.simpleMessage("Content Preview"),
        "maxLoad": MessageLookupByLibrary.simpleMessage("Max Load"),
        "moveCategory": m61,
        "moveCategoryWithLevel": m62,
        "moveCategoryWithLevelShort": m63,
        "moveToEnd": MessageLookupByLibrary.simpleMessage("Move to bottom"),
        "moveToEndGeneric": m64,
        "moveToStart": MessageLookupByLibrary.simpleMessage("Move to top"),
        "moveToStartGeneric": m65,
        "moves": MessageLookupByLibrary.simpleMessage("Moves"),
        "movesWithCount": m66,
        "myGeneric": m67,
        "navActions": MessageLookupByLibrary.simpleMessage("Use"),
        "navCharacter": MessageLookupByLibrary.simpleMessage("Character"),
        "navJournal": MessageLookupByLibrary.simpleMessage("Journal"),
        "noDescription":
            MessageLookupByLibrary.simpleMessage("‹No description provided›"),
        "noGeneric": m68,
        "noteNoCategory": MessageLookupByLibrary.simpleMessage("General"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notesWithCount": m69,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "pluralize": m70,
        "quickIconsItems": MessageLookupByLibrary.simpleMessage("Items"),
        "quickIconsMoves": MessageLookupByLibrary.simpleMessage("Moves"),
        "quickIconsNote": MessageLookupByLibrary.simpleMessage("+ Note"),
        "quickIconsSpells": MessageLookupByLibrary.simpleMessage("Spells"),
        "reloadLibrary": MessageLookupByLibrary.simpleMessage("Reload Library"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "resetToDefault":
            MessageLookupByLibrary.simpleMessage("Reset to default"),
        "rollAttackDamageButton":
            MessageLookupByLibrary.simpleMessage("Hack & Slash"),
        "rollBasicActionButton":
            MessageLookupByLibrary.simpleMessage("Basic Action"),
        "rollButtonLabel": MessageLookupByLibrary.simpleMessage("Button Text"),
        "rollButtonTooltip": m71,
        "rollButtonTooltipWithDebility": m72,
        "rollButtonUsePreset":
            MessageLookupByLibrary.simpleMessage("Use preset"),
        "rollDialogResultBreakdown": m73,
        "rollDialogResultTotal": m74,
        "rollDialogTitleRolled": m75,
        "rollDialogTitleRolling": m76,
        "rollDiscernRealitiesButton":
            MessageLookupByLibrary.simpleMessage("Discern Realities"),
        "rollVolleyButton": MessageLookupByLibrary.simpleMessage("Volley"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveGeneric": m77,
        "searchIn": MessageLookupByLibrary.simpleMessage("Search in: "),
        "searchPlaceholder":
            MessageLookupByLibrary.simpleMessage("Type to search"),
        "searchPlaceholderGeneric": m78,
        "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Select All"),
        "selectGeneric": m79,
        "selectNone": MessageLookupByLibrary.simpleMessage("Select None"),
        "selectToAdd": m80,
        "selected": MessageLookupByLibrary.simpleMessage("Selected"),
        "separatorOr": MessageLookupByLibrary.simpleMessage("OR"),
        "settingsDefaultDarkTheme":
            MessageLookupByLibrary.simpleMessage("Default dark theme"),
        "settingsDefaultLightTheme":
            MessageLookupByLibrary.simpleMessage("Default light theme"),
        "settingsGeneral": MessageLookupByLibrary.simpleMessage("General"),
        "settingsKeepScreenAwake": MessageLookupByLibrary.simpleMessage(
            "Keep screen awake while using the app"),
        "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "signinButton": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signinWithAppleButton":
            MessageLookupByLibrary.simpleMessage("Sign in with Apple"),
        "signinWithFacebookButton":
            MessageLookupByLibrary.simpleMessage("Sign in with Facebook"),
        "signinWithGoogleButton":
            MessageLookupByLibrary.simpleMessage("Sign in with Google"),
        "signoutButton": MessageLookupByLibrary.simpleMessage("Sign out"),
        "signupDefaultDataLanguage":
            MessageLookupByLibrary.simpleMessage("Default data language"),
        "signupEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "signupEmailPlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter your email"),
        "signupEmailValidation":
            MessageLookupByLibrary.simpleMessage("Please enter a valid email"),
        "signupPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "signupPasswordPlaceholder":
            MessageLookupByLibrary.simpleMessage("Enter your password"),
        "signupPasswordValidationLength": m81,
        "signupPasswordValidationPatternGeneric": m82,
        "signupPasswordValidationPatternLetter":
            MessageLookupByLibrary.simpleMessage(
                "Password must contain at least one capital letter"),
        "signupPasswordValidationPatternNumber":
            MessageLookupByLibrary.simpleMessage(
                "Password must contain at least one number"),
        "signupUsername": MessageLookupByLibrary.simpleMessage("Username"),
        "signupUsernamePlaceholder":
            MessageLookupByLibrary.simpleMessage("Pick a unique username"),
        "signupUsernameValidation": m83,
        "signupUsernameValidationPattern": MessageLookupByLibrary.simpleMessage(
            "Username must only contain letters, numbers, dashes and underscores"),
        "sortMoveDown": MessageLookupByLibrary.simpleMessage("Move down"),
        "sortMoveUp": MessageLookupByLibrary.simpleMessage("Move up"),
        "specialDice": MessageLookupByLibrary.simpleMessage("Special Dice"),
        "specialRollButton": m84,
        "spellLevel": m85,
        "spells": MessageLookupByLibrary.simpleMessage("Spells"),
        "spellsWithCount": m86,
        "tagCopyFrom": m87,
        "tagDetails": MessageLookupByLibrary.simpleMessage("Tag Information"),
        "themeTurnDark":
            MessageLookupByLibrary.simpleMessage("Switch to Dark Mode"),
        "themeTurnLight":
            MessageLookupByLibrary.simpleMessage("Switch to Light Mode"),
        "unselect": MessageLookupByLibrary.simpleMessage("Unselect"),
        "useDefault": MessageLookupByLibrary.simpleMessage("Use default"),
        "userLoginButton": MessageLookupByLibrary.simpleMessage("Sign in"),
        "userLogoutButton": MessageLookupByLibrary.simpleMessage("Sign out"),
        "userMenuMoreChars": MessageLookupByLibrary.simpleMessage("More"),
        "userMenuRecentCharacters":
            MessageLookupByLibrary.simpleMessage("Recent Characters"),
        "userUnregistered":
            MessageLookupByLibrary.simpleMessage("Not registered")
      };
}
