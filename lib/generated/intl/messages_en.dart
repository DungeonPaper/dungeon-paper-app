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

  static String m0(string) => "Add ${string}";

  static String m1(alignment) => "${Intl.select(alignment, {
            'chaotic': 'Chaotic',
            'evil': 'Evil',
            'good': 'Good',
            'lawful': 'Lawful',
            'neutral': 'Neutral',
          })}";

  static String m2(entity) => "All ${entity}";

  static String m3(level, charClass, alignment) =>
      "Level ${level} ∙ ${charClass} ∙ ${alignment}";

  static String m4(count, fmtCount) =>
      "${Intl.plural(count, zero: 'No coins', one: 'One coin', other: '${fmtCount} coins')}";

  static String m5(entity, name) =>
      "Are you sure you want to remove the ${entity} \"${name}\" from the list?";

  static String m6(entity) => "Delete ${entity}?";

  static String m7(hp) => "Max HP: ${hp}";

  static String m8(step) => "${Intl.select(step, {
            'information': 'Basic Information',
            'charClass': 'Class',
            'stats': 'Roll Stats',
            'movesSpells': 'Moves & Spells',
            'background': 'Background & Bonds',
            'gear': 'Starting Gear',
          })}";

  static String m9(step) => "${step} - Changes Required";

  static String m10(runtimeType) => "${Intl.select(runtimeType, {
            'CharacterClass': 'Class',
            'Item': 'Item',
            'Monster': 'Monster',
            'Move': 'Move',
            'Race': 'Race',
            'Spell': 'Spell',
            'Tag': 'Tag',
            'MoveCategory': 'Category',
            'other': '${runtimeType}',
          })}";

  static String m11(runtimeType) => "${Intl.select(runtimeType, {
            'CharacterClass': 'Classes',
            'Item': 'Items',
            'Monster': 'Monsters',
            'Move': 'Moves',
            'Race': 'Races',
            'Spell': 'Spells',
            'Tag': 'Tags',
            'MoveCategory': 'Categories',
            'other': '${runtimeType}s',
          })}";

  static String m12(count) =>
      "${Intl.plural(count, zero: 'No items', one: 'One item', other: '${count} items')}";

  static String m13(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced',
            'advanced2': 'Advanced',
            'other': 'Other',
          })}";

  static String m14(category) => "${Intl.select(category, {
            'advanced1': 'Advanced (level 1-5)',
            'advanced2': 'Advanced (level 6-10)',
            'other': '',
          })}";

  static String m15(count) =>
      "${Intl.plural(count, zero: 'No moves', one: 'One move', other: '${count} moves')}";

  static String m16(count, singular, plural) =>
      "${Intl.plural(count, one: 'One ${singular}', other: '${count} ${plural}')}";

  static String m17(stat) => "Roll +${stat}";

  static String m18(entity) => "Type to search ${entity}";

  static String m19(string) => "Select ${string} to add";

  static String m20(count) =>
      "${Intl.plural(count, zero: 'No spells', one: 'One spell', other: '${count} spells')}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addItems": MessageLookupByLibrary.simpleMessage("Add Items"),
        "addMoves": MessageLookupByLibrary.simpleMessage("Add Moves"),
        "addMovesCustom": MessageLookupByLibrary.simpleMessage("Add New Move"),
        "addMovesExisting":
            MessageLookupByLibrary.simpleMessage("Add Existing Moves"),
        "addSpells": MessageLookupByLibrary.simpleMessage("Add Spells"),
        "addSpellsCustom":
            MessageLookupByLibrary.simpleMessage("Add New Spell"),
        "addSpellsExisting":
            MessageLookupByLibrary.simpleMessage("Add Existing Spells"),
        "addWithCount": m0,
        "alignment": m1,
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "allEntity": m2,
        "appName": MessageLookupByLibrary.simpleMessage("Dungeon Paper"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "characterBarHp": MessageLookupByLibrary.simpleMessage("HP"),
        "characterBarXp": MessageLookupByLibrary.simpleMessage("XP"),
        "characterHeaderSubtitle": m3,
        "characterListTitle":
            MessageLookupByLibrary.simpleMessage("All Characters"),
        "coins": MessageLookupByLibrary.simpleMessage("Coins"),
        "coinsWithCount": m4,
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmDeleteBody": m5,
        "confirmDeleteTitle": m6,
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
        "createCharacterPreviewPageMaxHp": m7,
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
        "createCharacterStep": m8,
        "createCharacterStepInvalidTooltip": m9,
        "createCharacterTitle":
            MessageLookupByLibrary.simpleMessage("Create Character"),
        "dynamicCategoriesItems":
            MessageLookupByLibrary.simpleMessage("Equipped Items"),
        "dynamicCategoriesMoves":
            MessageLookupByLibrary.simpleMessage("Favorite Moves"),
        "dynamicCategoriesNotes":
            MessageLookupByLibrary.simpleMessage("Favorite Notes"),
        "dynamicCategoriesSpells":
            MessageLookupByLibrary.simpleMessage("Prepared Spells"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "entity": m10,
        "entityPlural": m11,
        "items": MessageLookupByLibrary.simpleMessage("Items"),
        "itemsWithCount": m12,
        "moveCategory": m13,
        "moveCategoryWithLevel": m14,
        "moves": MessageLookupByLibrary.simpleMessage("Moves"),
        "movesWithCount": m15,
        "navActions": MessageLookupByLibrary.simpleMessage("Use"),
        "navCharacter": MessageLookupByLibrary.simpleMessage("Character"),
        "navJournal": MessageLookupByLibrary.simpleMessage("Journal"),
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "pluralize": m16,
        "quickIconsItems": MessageLookupByLibrary.simpleMessage("Items"),
        "quickIconsMoves": MessageLookupByLibrary.simpleMessage("Moves"),
        "quickIconsNote": MessageLookupByLibrary.simpleMessage("+ Note"),
        "quickIconsSpells": MessageLookupByLibrary.simpleMessage("Spells"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "rollAttackDamageButton":
            MessageLookupByLibrary.simpleMessage("Attack + Damage"),
        "rollBasicActionButton":
            MessageLookupByLibrary.simpleMessage("Basic Action"),
        "rollStatButtonTooltip": m17,
        "searchPlaceholder":
            MessageLookupByLibrary.simpleMessage("Type to search"),
        "searchPlaceholderEntity": m18,
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "selectToAdd": m19,
        "spells": MessageLookupByLibrary.simpleMessage("Spells"),
        "spellsWithCount": m20,
        "userMenuMoreChars": MessageLookupByLibrary.simpleMessage("More")
      };
}
