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

  static String m0(entity) => "Add New ${entity}";

  static String m1(entity) => "Add Existing ${entity}";

  static String m2(entity) => "Add ${entity}";

  static String m3(string) => "Add ${string}";

  static String m4(alignment) => "${Intl.select(alignment, {
            'chaotic': 'Chaotic',
            'evil': 'Evil',
            'good': 'Good',
            'lawful': 'Lawful',
            'neutral': 'Neutral',
          })}";

  static String m5(entity) => "All ${entity}";

  static String m6(level, charClass, alignment) =>
      "Level ${level} ∙ ${charClass} ∙ ${alignment}";

  static String m7(count, fmtCount) =>
      "${Intl.plural(count, zero: 'No coins', one: 'One coin', other: '${fmtCount} coins')}";

  static String m8(entity, name) =>
      "Are you sure you want to remove the ${entity} \"${name}\" from the list?";

  static String m9(entity) => "Delete ${entity}?";

  static String m10(hp) => "Max HP: ${hp}";

  static String m11(step) => "${Intl.select(step, {
            'information': 'Basic Information',
            'charClass': 'Class',
            'stats': 'Roll Stats',
            'movesSpells': 'Moves & Spells',
            'background': 'Background & Bonds',
            'gear': 'Starting Gear',
          })}";

  static String m12(step) => "${step} - Changes Required";

  static String m13(entity) => "Create ${entity}";

  static String m14(entity) => "Edit ${entity}";

  static String m15(runtimeType) => "${Intl.select(runtimeType, {
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

  static String m16(runtimeType) => "${Intl.select(runtimeType, {
            'CharacterClass': 'Classes',
            'Item': 'Items',
            'Monster': 'Monsters',
            'Move': 'Moves',
            'Race': 'Races',
            'Spell': 'Spells',
            'Tag': 'Tags',
            'MoveCategory': 'Categories',
            'Dice': 'Dice',
            'other': '${runtimeType}s',
          })}";

  static String m17(count, entPlural, ent) =>
      "${Intl.plural(count, zero: 'No ${entPlural}', one: 'One ${ent}', other: '${count} ${entPlural}')}";

  static String m18(n) => "Cell ${n}";

  static String m19(n) => "Header ${n}";

  static String m20(n) => "Header ${n}";

  static String m21(n) => "Heading ${n}";

  static String m22(entity) => "${entity} description";

  static String m23(entity) => "${entity} name";

  static String m24(entity) => "${entity} value";

  static String m25(count) =>
      "${Intl.plural(count, zero: 'No items', one: 'One item', other: '${count} items')}";

  static String m26(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced',
            'advanced2': 'Advanced',
            'other': 'Other',
          })}";

  static String m27(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced (level 1-5)',
            'advanced2': 'Advanced (level 6-10)',
            'other': 'Other',
          })}";

  static String m28(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced (1-5)',
            'advanced2': 'Advanced (6-10)',
            'other': 'Other',
          })}";

  static String m29(count) =>
      "${Intl.plural(count, zero: 'No moves', one: 'One move', other: '${count} moves')}";

  static String m30(entity) => "My ${entity}";

  static String m31(count) =>
      "${Intl.plural(count, zero: 'No notes', one: 'One note', other: '${count} notes')}";

  static String m32(count, singular, plural) =>
      "${Intl.plural(count, one: 'One ${singular}', other: '${count} ${plural}')}";

  static String m33(stat) => "Roll +${stat}";

  static String m34(entity) => "Save ${entity}";

  static String m35(entity) => "Type to search ${entity}";

  static String m36(string) => "Select ${string} to add";

  static String m37(count) =>
      "${Intl.plural(count, zero: 'No spells', one: 'One spell', other: '${count} spells')}";

  static String m38(tag) => "Copy from: ${tag}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "addCustomGeneric": m0,
        "addExistingGeneric": m1,
        "addGeneric": m2,
        "addRepoItemTabOnline": MessageLookupByLibrary.simpleMessage("Online"),
        "addRepoItemTabPlaybook":
            MessageLookupByLibrary.simpleMessage("Playbook"),
        "addWithCount": m3,
        "alignment": m4,
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "allGeneric": m5,
        "alreadyAdded": MessageLookupByLibrary.simpleMessage("Already added"),
        "appName": MessageLookupByLibrary.simpleMessage("Dungeon Paper"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "characterBarHp": MessageLookupByLibrary.simpleMessage("HP"),
        "characterBarXp": MessageLookupByLibrary.simpleMessage("XP"),
        "characterHeaderSubtitle": m6,
        "characterListTitle":
            MessageLookupByLibrary.simpleMessage("All Characters"),
        "coins": MessageLookupByLibrary.simpleMessage("Coins"),
        "coinsWithCount": m7,
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmDeleteBody": m8,
        "confirmDeleteTitle": m9,
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
        "createCharacterPreviewPageMaxHp": m10,
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
        "createCharacterStep": m11,
        "createCharacterStepInvalidTooltip": m12,
        "createCharacterTitle":
            MessageLookupByLibrary.simpleMessage("Create Character"),
        "createGeneric": m13,
        "diceAmount": MessageLookupByLibrary.simpleMessage("Amount"),
        "diceSides": MessageLookupByLibrary.simpleMessage("Sides"),
        "dynamicCategoriesItems":
            MessageLookupByLibrary.simpleMessage("Equipped Items"),
        "dynamicCategoriesMoves":
            MessageLookupByLibrary.simpleMessage("Favorite Moves"),
        "dynamicCategoriesNotes":
            MessageLookupByLibrary.simpleMessage("Favorite Notes"),
        "dynamicCategoriesSpells":
            MessageLookupByLibrary.simpleMessage("Prepared Spells"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editGeneric": m14,
        "entity": m15,
        "entityPlural": m16,
        "entityWithCount": m17,
        "explanation": MessageLookupByLibrary.simpleMessage("Further details"),
        "formatBold": MessageLookupByLibrary.simpleMessage("Bold"),
        "formatBulletList": MessageLookupByLibrary.simpleMessage("Bullet List"),
        "formatCell": m18,
        "formatCheckboxList":
            MessageLookupByLibrary.simpleMessage("Check List (Checked)"),
        "formatCheckboxListUnchecked":
            MessageLookupByLibrary.simpleMessage("Check List (Unchecked)"),
        "formatHeader": m19,
        "formatHeaderNoNum": m20,
        "formatHeading": m21,
        "formatHeadings": MessageLookupByLibrary.simpleMessage("Headings"),
        "formatHelp": MessageLookupByLibrary.simpleMessage("Formatting Help"),
        "formatImageURL": MessageLookupByLibrary.simpleMessage("Image URL"),
        "formatItalic": MessageLookupByLibrary.simpleMessage("Italic"),
        "formatNumberedList":
            MessageLookupByLibrary.simpleMessage("Numbered List"),
        "formatPreview": MessageLookupByLibrary.simpleMessage("Preview"),
        "formatTable": MessageLookupByLibrary.simpleMessage("Table"),
        "formatURL": MessageLookupByLibrary.simpleMessage("URL"),
        "genericDescriptionField": m22,
        "genericNameField": m23,
        "genericValueField": m24,
        "items": MessageLookupByLibrary.simpleMessage("Items"),
        "itemsWithCount": m25,
        "moveCategory": m26,
        "moveCategoryWithLevel": m27,
        "moveCategoryWithLevelShort": m28,
        "moves": MessageLookupByLibrary.simpleMessage("Moves"),
        "movesWithCount": m29,
        "myGeneric": m30,
        "navActions": MessageLookupByLibrary.simpleMessage("Use"),
        "navCharacter": MessageLookupByLibrary.simpleMessage("Character"),
        "navJournal": MessageLookupByLibrary.simpleMessage("Journal"),
        "noDescription":
            MessageLookupByLibrary.simpleMessage("‹No description provided›"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notesWithCount": m31,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "pluralize": m32,
        "quickIconsItems": MessageLookupByLibrary.simpleMessage("Items"),
        "quickIconsMoves": MessageLookupByLibrary.simpleMessage("Moves"),
        "quickIconsNote": MessageLookupByLibrary.simpleMessage("+ Note"),
        "quickIconsSpells": MessageLookupByLibrary.simpleMessage("Spells"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "rollAttackDamageButton":
            MessageLookupByLibrary.simpleMessage("Attack + Damage"),
        "rollBasicActionButton":
            MessageLookupByLibrary.simpleMessage("Basic Action"),
        "rollStatButtonTooltip": m33,
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveGeneric": m34,
        "searchPlaceholder":
            MessageLookupByLibrary.simpleMessage("Type to search"),
        "searchPlaceholderGeneric": m35,
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "selectToAdd": m36,
        "spells": MessageLookupByLibrary.simpleMessage("Spells"),
        "spellsWithCount": m37,
        "tagCopyFrom": m38,
        "userMenuMoreChars": MessageLookupByLibrary.simpleMessage("More")
      };
}
