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

  static String m1(coins) => "${coins} G";

  static String m2(load, maxLoad) => "Load: ${load}/${maxLoad}";

  static String m3(entity) => "Add New ${entity}";

  static String m4(entity) => "Add Existing ${entity}";

  static String m5(entity) => "Add ${entity}";

  static String m6(string) => "Add ${string}";

  static String m7(alignment) => "${Intl.select(alignment, {
            'chaotic': 'Chaotic',
            'evil': 'Evil',
            'good': 'Good',
            'lawful': 'Lawful',
            'neutral': 'Neutral',
          })}";

  static String m8(entity) => "All ${entity}";

  static String m9(level, charClass, race) =>
      "Level ${level} ∙ ${charClass} ∙ ${race} ∙";

  static String m10(count, fmtCount) =>
      "${Intl.plural(count, zero: 'No coins', one: 'One coin', other: '${fmtCount} coins')}";

  static String m11(entity, name) =>
      "Are you sure you want to remove the ${entity} \"${name}\" from the list?";

  static String m12(entity) => "Delete ${entity}?";

  static String m13(hp, load, damageDice) =>
      "Base HP: ${hp}, Load: ${load}, Damage Dice: ${damageDice}";

  static String m14(hp) => "Max HP: ${hp}";

  static String m15(amount) => "${amount} coins";

  static String m16(amount, name) => "${amount} × ${name}";

  static String m17(step) => "${Intl.select(step, {
            'information': 'Basic Information',
            'charClass': 'Class',
            'stats': 'Ability Scores',
            'movesSpells': 'Moves & Spells',
            'background': 'Background & Bonds',
            'gear': 'Starting Gear',
          })}";

  static String m18(step) => "${step} - Changes Required";

  static String m19(cls) => "Level 1 ${cls}";

  static String m20(entity) => "Create ${entity}";

  static String m21(name, key) => "${name} (${key})";

  static String m22(dice) => "Suggested: ${dice}";

  static String m23(name, key) => "${name} (${key})";

  static String m24(entity) => "Edit ${entity}";

  static String m25(runtimeType) => "${Intl.select(runtimeType, {
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
            'other': '${runtimeType}',
          })}";

  static String m26(runtimeType) => "${Intl.select(runtimeType, {
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
            'other': '${runtimeType}s',
          })}";

  static String m27(count, entPlural, ent) =>
      "${Intl.plural(count, zero: 'No ${entPlural}', one: 'One ${ent}', other: '${count} ${entPlural}')}";

  static String m28(n) => "Cell ${n}";

  static String m29(n) => "Header ${n}";

  static String m30(n) => "Header ${n}";

  static String m31(n) => "Heading ${n}";

  static String m32(entity) => "${entity} description";

  static String m33(entity) => "${entity} name";

  static String m34(entity) => "${entity} value";

  static String m35(entity) => "Processing ${entity}...";

  static String m36(amount) => "× ${amount}";

  static String m37(count) =>
      "${Intl.plural(count, zero: 'No items', one: 'One item', other: '${count} items')}";

  static String m38(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced',
            'advanced2': 'Advanced',
            'other': 'Other',
          })}";

  static String m39(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced (level 1-5)',
            'advanced2': 'Advanced (level 6-10)',
            'other': 'Other',
          })}";

  static String m40(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced (1-5)',
            'advanced2': 'Advanced (6-10)',
            'other': 'Other',
          })}";

  static String m41(count) =>
      "${Intl.plural(count, zero: 'No moves', one: 'One move', other: '${count} moves')}";

  static String m42(entity) => "My ${entity}";

  static String m43(entity) => "No ${entity}";

  static String m44(count) =>
      "${Intl.plural(count, zero: 'No notes', one: 'One note', other: '${count} notes')}";

  static String m45(count, singular, plural) =>
      "${Intl.plural(count, one: 'One ${singular}', other: '${count} ${plural}')}";

  static String m46(dice, mod) => "Dice: ${dice} | Modifier: ${mod}";

  static String m47(total) => "Total: ${total}";

  static String m48(total) => "Total: ${total}";

  static String m49(count) => "Rolling ${count} dice";

  static String m50(entity) => "Save ${entity}";

  static String m51(entity) => "Type to search ${entity}";

  static String m52(entity) => "Select ${entity}";

  static String m53(string) => "Select ${string} to add";

  static String m54(level) => "${Intl.select(level, {
            'cantrip': 'Cantrip',
            'rote': 'Rote',
            'other': 'Level ${level}',
          })}";

  static String m55(count) =>
      "${Intl.plural(count, zero: 'No spells', one: 'One spell', other: '${count} spells')}";

  static String m56(tag) => "Copy from: ${tag}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
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
        "abilityScoreIntDebilityDescription": MessageLookupByLibrary.simpleMessage(
            "That last knock to the head shook something loose. Brain not work so good."),
        "abilityScoreIntDebilityName":
            MessageLookupByLibrary.simpleMessage("Stunned"),
        "abilityScoreIntDescription": MessageLookupByLibrary.simpleMessage(
            "Determines how well your character learns and reasons."),
        "abilityScoreIntName":
            MessageLookupByLibrary.simpleMessage("Intelligence"),
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
        "actionSummaryChipCoins": m1,
        "actionSummaryChipLoad": m2,
        "actionsViewVisibleLabel": MessageLookupByLibrary.simpleMessage("Show"),
        "addCustomGeneric": m3,
        "addExistingGeneric": m4,
        "addGeneric": m5,
        "addRepoItemTabOnline": MessageLookupByLibrary.simpleMessage("Online"),
        "addRepoItemTabPlaybook":
            MessageLookupByLibrary.simpleMessage("Playbook"),
        "addWithCount": m6,
        "alignment": m7,
        "alignmentLabel": MessageLookupByLibrary.simpleMessage("Alignment"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "allGeneric": m8,
        "alreadyAdded": MessageLookupByLibrary.simpleMessage("Already added"),
        "appName": MessageLookupByLibrary.simpleMessage("Dungeon Paper"),
        "basicInfoImageChoose":
            MessageLookupByLibrary.simpleMessage("Choose Photo..."),
        "basicInfoImageChooseNew":
            MessageLookupByLibrary.simpleMessage("Choose New Photo..."),
        "basicInfoImageNeedAccountLinkLabel":
            MessageLookupByLibrary.simpleMessage(
                "Sign in or create an account"),
        "basicInfoImageNeedAccountPrefix": MessageLookupByLibrary.simpleMessage(
            "You need to be signed in to upload images."),
        "basicInfoImageNeedAccountSuffix": MessageLookupByLibrary.simpleMessage(
            ", or upload using your own URL below."),
        "basicInfoImageRemove":
            MessageLookupByLibrary.simpleMessage("Remove Photo"),
        "basicInformationTitle":
            MessageLookupByLibrary.simpleMessage("Basic Information"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
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
        "characterBondsFlagsDialogTitle":
            MessageLookupByLibrary.simpleMessage("Bonds & Flags"),
        "characterDebilitiesDialogTitle":
            MessageLookupByLibrary.simpleMessage("Debilities"),
        "characterHeaderSubtitle": m9,
        "characterListTitle":
            MessageLookupByLibrary.simpleMessage("All Characters"),
        "characterNoCategory":
            MessageLookupByLibrary.simpleMessage("No Category"),
        "characterRollsTitle":
            MessageLookupByLibrary.simpleMessage("Ability Scores"),
        "coins": MessageLookupByLibrary.simpleMessage("Coins"),
        "coinsWithCount": m10,
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmDeleteBody": m11,
        "confirmDeleteTitle": m12,
        "confirmExitDefaultCancelLabel":
            MessageLookupByLibrary.simpleMessage("Continue editing"),
        "confirmExitDefaultOkLabel":
            MessageLookupByLibrary.simpleMessage("Exit & Discard"),
        "confirmExitDefaultText": MessageLookupByLibrary.simpleMessage(
            "Going back will lose any unsaved changes.\nAre you sure you want to go back?"),
        "confirmExitDefaultTitle":
            MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "createCharRandomizeNameTooltipClick":
            MessageLookupByLibrary.simpleMessage(
                "Click to generate a random name"),
        "createCharRandomizeNameTooltipTouch":
            MessageLookupByLibrary.simpleMessage(
                "Tap to generate a random name"),
        "createCharacterAddButton":
            MessageLookupByLibrary.simpleMessage("Add Character"),
        "createCharacterAvatarFieldLabel":
            MessageLookupByLibrary.simpleMessage("Photo URL"),
        "createCharacterAvatarFieldPlaceholder":
            MessageLookupByLibrary.simpleMessage("Paste an image URL"),
        "createCharacterBioFieldLabel":
            MessageLookupByLibrary.simpleMessage("Biography"),
        "createCharacterBioFieldPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Describe your character as shortly or thoroughly as you want here.\nPut your backstory, a visual description, some personality traits, etc. to help you keep in character."),
        "createCharacterClassDescription": m13,
        "createCharacterClassHelpText": MessageLookupByLibrary.simpleMessage(
            "No class selected (required)"),
        "createCharacterDescFieldLabel":
            MessageLookupByLibrary.simpleMessage("Biography/description"),
        "createCharacterDescFieldPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Enter general information about your character - backstory, goals & ambitions, behavior descriptions, etc"),
        "createCharacterFinishButton":
            MessageLookupByLibrary.simpleMessage("Review"),
        "createCharacterNameFieldLabel":
            MessageLookupByLibrary.simpleMessage("Character Name"),
        "createCharacterNameFieldPlaceholder":
            MessageLookupByLibrary.simpleMessage(
                "Enter your character\'s name"),
        "createCharacterPreviewPageMaxHp": m14,
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
        "createCharacterStartingGearDescriptionCoins": m15,
        "createCharacterStartingGearDescriptionItem": m16,
        "createCharacterStartingGearHelpText":
            MessageLookupByLibrary.simpleMessage(
                "Select your starting gear determined by class (optional)"),
        "createCharacterStep": m17,
        "createCharacterStepInvalidTooltip": m18,
        "createCharacterTitle":
            MessageLookupByLibrary.simpleMessage("Create Character"),
        "createCharacterTravelerBlankName":
            MessageLookupByLibrary.simpleMessage("Unnamed Traveler"),
        "createCharacterTravelerDescription": m19,
        "createCharacterTravelerHelpText": MessageLookupByLibrary.simpleMessage(
            "Select name & picture (required)"),
        "createGeneric": m20,
        "debilityLabel": m21,
        "diceAmount": MessageLookupByLibrary.simpleMessage("Amount"),
        "diceRollAgain": MessageLookupByLibrary.simpleMessage("Roll again"),
        "diceSeparator": MessageLookupByLibrary.simpleMessage("d"),
        "diceSides": MessageLookupByLibrary.simpleMessage("Sides"),
        "diceSuggestion": m22,
        "diceUseStat": MessageLookupByLibrary.simpleMessage("Roll Stat"),
        "diceUseStatLabel": MessageLookupByLibrary.simpleMessage("Stat"),
        "diceUseStatPlaceholder":
            MessageLookupByLibrary.simpleMessage("Select Stat"),
        "diceUseStatValue": m23,
        "diceUseValue": MessageLookupByLibrary.simpleMessage("Fixed Value"),
        "diceUseValueLabel":
            MessageLookupByLibrary.simpleMessage("Modifier value"),
        "diceUseValuePlaceholder":
            MessageLookupByLibrary.simpleMessage("Number, e.g. 2 or -1"),
        "dynamicCategoriesItems":
            MessageLookupByLibrary.simpleMessage("Equipped Items"),
        "dynamicCategoriesMoves":
            MessageLookupByLibrary.simpleMessage("Favorite Moves"),
        "dynamicCategoriesNotes":
            MessageLookupByLibrary.simpleMessage("Bookmarked Notes"),
        "dynamicCategoriesSpells":
            MessageLookupByLibrary.simpleMessage("Prepared Spells"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editGeneric": m24,
        "entity": m25,
        "entityPlural": m26,
        "entityWithCount": m27,
        "explanation": MessageLookupByLibrary.simpleMessage("Further details"),
        "export": MessageLookupByLibrary.simpleMessage("Export"),
        "exportCanceledMessage":
            MessageLookupByLibrary.simpleMessage("Operation was canceled"),
        "exportFailedMessage": MessageLookupByLibrary.simpleMessage(
            "Something went wrong.\nTry again or contact support if this persists"),
        "exportFailedTitle":
            MessageLookupByLibrary.simpleMessage("Export Failed"),
        "exportSuccessfulMessage": MessageLookupByLibrary.simpleMessage(
            "Your data was exported to file successfully"),
        "exportSuccessfulTitle":
            MessageLookupByLibrary.simpleMessage("Export Successful"),
        "formatBold": MessageLookupByLibrary.simpleMessage("Bold"),
        "formatBulletList": MessageLookupByLibrary.simpleMessage("Bullet List"),
        "formatCell": m28,
        "formatCheckboxList":
            MessageLookupByLibrary.simpleMessage("Check List (Checked)"),
        "formatCheckboxListUnchecked":
            MessageLookupByLibrary.simpleMessage("Check List (Unchecked)"),
        "formatHeader": m29,
        "formatHeaderNoNum": m30,
        "formatHeading": m31,
        "formatHeadings": MessageLookupByLibrary.simpleMessage("Headings"),
        "formatHelp": MessageLookupByLibrary.simpleMessage("Formatting Help"),
        "formatImageURL": MessageLookupByLibrary.simpleMessage("Image URL"),
        "formatItalic": MessageLookupByLibrary.simpleMessage("Italic"),
        "formatNumberedList":
            MessageLookupByLibrary.simpleMessage("Numbered List"),
        "formatPreview": MessageLookupByLibrary.simpleMessage("Preview"),
        "formatTable": MessageLookupByLibrary.simpleMessage("Table"),
        "formatURL": MessageLookupByLibrary.simpleMessage("URL"),
        "genericDescriptionField": m32,
        "genericNameField": m33,
        "genericValueField": m34,
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
        "importProgressProcessing": m35,
        "importProgressTitle":
            MessageLookupByLibrary.simpleMessage("Importing..."),
        "importSuccessMessage": MessageLookupByLibrary.simpleMessage(
            "Your data was imported from file successfully"),
        "importSuccessTitle":
            MessageLookupByLibrary.simpleMessage("Successful"),
        "itemAmountX": m36,
        "items": MessageLookupByLibrary.simpleMessage("Items"),
        "itemsWithCount": m37,
        "loadingCharacters":
            MessageLookupByLibrary.simpleMessage("Getting characters..."),
        "loadingGeneral": MessageLookupByLibrary.simpleMessage("Loading..."),
        "loadingUser": MessageLookupByLibrary.simpleMessage("Signing in..."),
        "markdownPreview":
            MessageLookupByLibrary.simpleMessage("Content Preview"),
        "moveCategory": m38,
        "moveCategoryWithLevel": m39,
        "moveCategoryWithLevelShort": m40,
        "moves": MessageLookupByLibrary.simpleMessage("Moves"),
        "movesWithCount": m41,
        "myGeneric": m42,
        "navActions": MessageLookupByLibrary.simpleMessage("Use"),
        "navCharacter": MessageLookupByLibrary.simpleMessage("Character"),
        "navJournal": MessageLookupByLibrary.simpleMessage("Journal"),
        "noDescription":
            MessageLookupByLibrary.simpleMessage("‹No description provided›"),
        "noGeneric": m43,
        "noteNoCategory": MessageLookupByLibrary.simpleMessage("General"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notesWithCount": m44,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "pluralize": m45,
        "quickIconsItems": MessageLookupByLibrary.simpleMessage("Items"),
        "quickIconsMoves": MessageLookupByLibrary.simpleMessage("Moves"),
        "quickIconsNote": MessageLookupByLibrary.simpleMessage("+ Note"),
        "quickIconsSpells": MessageLookupByLibrary.simpleMessage("Spells"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "rollAttackDamageButton":
            MessageLookupByLibrary.simpleMessage("Hack & Slash"),
        "rollBasicActionButton":
            MessageLookupByLibrary.simpleMessage("Basic Action"),
        "rollDialogResultBreakdown": m46,
        "rollDialogResultTotal": m47,
        "rollDialogTitleRolled": m48,
        "rollDialogTitleRolling": m49,
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveGeneric": m50,
        "searchPlaceholder":
            MessageLookupByLibrary.simpleMessage("Type to search"),
        "searchPlaceholderGeneric": m51,
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Select All"),
        "selectGeneric": m52,
        "selectNone": MessageLookupByLibrary.simpleMessage("Select None"),
        "selectToAdd": m53,
        "separatorOr": MessageLookupByLibrary.simpleMessage("OR"),
        "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "sortMoveDown": MessageLookupByLibrary.simpleMessage("Move down"),
        "sortMoveUp": MessageLookupByLibrary.simpleMessage("Move up"),
        "spellLevel": m54,
        "spells": MessageLookupByLibrary.simpleMessage("Spells"),
        "spellsWithCount": m55,
        "tagCopyFrom": m56,
        "tagDetails": MessageLookupByLibrary.simpleMessage("Tag Information"),
        "themeTurnDark":
            MessageLookupByLibrary.simpleMessage("Switch to Dark Mode"),
        "themeTurnLight":
            MessageLookupByLibrary.simpleMessage("Switch to Light Mode"),
        "unselect": MessageLookupByLibrary.simpleMessage("Unselect"),
        "userLoginButton": MessageLookupByLibrary.simpleMessage("Sign in"),
        "userLogoutButton": MessageLookupByLibrary.simpleMessage("Sign out"),
        "userMenuMoreChars": MessageLookupByLibrary.simpleMessage("More"),
        "userMenuRecentCharacters":
            MessageLookupByLibrary.simpleMessage("Recent Characters"),
        "userUnregistered":
            MessageLookupByLibrary.simpleMessage("Not registered")
      };
}
