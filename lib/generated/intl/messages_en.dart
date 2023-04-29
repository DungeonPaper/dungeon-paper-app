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

  static String m2(year) => "Copyright © 2018-${year}";

  static String m3(version) => "Version ${version}";

  static String m4(coins) => "${coins} G";

  static String m5(load, maxLoad) => "Load: ${load}/${maxLoad}";

  static String m6(entity) => "Add New ${entity}";

  static String m7(entity) => "Add Existing ${entity}";

  static String m8(entity) => "Add ${entity}";

  static String m9(alignment) => "${Intl.select(alignment, {
            'chaotic': 'Chaotic',
            'evil': 'Evil',
            'good': 'Good',
            'lawful': 'Lawful',
            'neutral': 'Neutral',
            'other': '${alignment}',
          })}";

  static String m10(entity) => "All ${entity}";

  static String m11(entity) => "Change ${entity}";

  static String m12(level, charClass, race) => "Level ${level} ∙ ${charClass} ∙ ${race} ∙";

  static String m13(alignment) => "${alignment}";

  static String m14(charClass) => "${charClass}";

  static String m15(level) => "Level ${level}";

  static String m16(race) => "${race}";

  static String m17(count, fmtCount) =>
      "${Intl.plural(count, zero: 'No coins', one: 'One coin', other: '${fmtCount} coins')}";

  static String m18(entity, name) => "Are you sure you want to remove the ${entity} \"${name}\" from the list?";

  static String m19(entity) => "Delete ${entity}?";

  static String m20(provider) =>
      "Are you sure you want to unlink your account from ${provider}?\nBy clicking \"Unlink\", you will no longer be able to sign in with ${provider}.\n\nYou will be able to re-link your account at any time by going to your account settings.";

  static String m21(entity) => "Unlink from ${entity}?";

  static String m22(hp, load, damageDice) => "Base HP: ${hp}, Load: ${load}, Damage Dice: ${damageDice}";

  static String m23(moves, spells) => "${moves} Moves, ${spells} Spells selected";

  static String m24(hp) => "Max HP: ${hp}";

  static String m25(count) => "${count} selected";

  static String m26(count, max) => "${count} selected (class allowance: ${max})";

  static String m27(amount) => "${amount} coins";

  static String m28(amount, name) => "${amount} × ${name}";

  static String m29(step) => "${step} - Changes Required";

  static String m30(cls) => "Level 1 ${cls}";

  static String m31(entity) => "Create ${entity}";

  static String m32(name, key) => "${name} (${key})";

  static String m33(dice) => "Suggested: ${dice}";

  static String m34(name, key) => "${name} (${key})";

  static String m35(entity) => "Edit ${entity}";

  static String m36(runtimeType) => "${Intl.select(runtimeType, {
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

  static String m37(runtimeType) => "${Intl.select(runtimeType, {
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

  static String m38(entity) => "This ${entity} is not linked to any library item";

  static String m39(entity) => "This ${entity} is In Sync with its linked library item";

  static String m40(entity) => "This ${entity} is Out of Sync with its linked library item";

  static String m41(count, entPlural, ent) =>
      "${Intl.plural(count, zero: 'No ${entPlural}', one: 'One ${ent}', other: '${count} ${entPlural}')}";

  static String m42(length) =>
      "Must be exactly ${length} ${Intl.plural(length, one: 'character', other: 'characters')}";

  static String m43(length) =>
      "Must be no more than ${length} ${Intl.plural(length, one: 'character', other: 'characters')}";

  static String m44(length) =>
      "Must be at least ${length} ${Intl.plural(length, one: 'character', other: 'characters')}";

  static String m45(pattern) => "Must contain ${pattern}";

  static String m46(pattern) => "Must not contain ${pattern}";

  static String m47(entity) => "No ${entity} selected";

  static String m48(entity) => "No ${entity} selected (required)";

  static String m49(entity) => "${entity} category";

  static String m50(entity) => "${entity} description";

  static String m51(entity) => "${entity} explanation";

  static String m52(entity) => "${entity} name";

  static String m53(entity) => "${entity} title";

  static String m54(n) => "Cell ${n}";

  static String m55(n) => "Header ${n}";

  static String m56(n) => "Header ${n}";

  static String m57(n) => "Heading ${n}";

  static String m58(entity) => "${entity} description";

  static String m59(entity) => "${entity} name";

  static String m60(entity) => "${entity} value";

  static String m61(amount) => "Heal\n+${amount}";

  static String m62(amount) => "Damage\n-${amount}";

  static String m63(entity) => "Processing ${entity}...";

  static String m64(amount) => "× ${amount}";

  static String m65(count) => "${Intl.plural(count, zero: 'No items', one: 'One item', other: '${count} items')}";

  static String m66(count, type) => "${count} in ${type}";

  static String m67(type) => "${Intl.select(type, {
            'builtIn': 'Playbook',
            'my': 'My Library',
            'other': '${type}',
          })}";

  static String m68(entities) => "Try changing the search or filters to find more ${entities}.";

  static String m69(entities) => "No ${entities} found in this list.";

  static String m70(entities) => "No ${entities} found";

  static String m71(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced',
            'advanced2': 'Advanced',
            'other': 'Other',
          })}";

  static String m72(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced (level 1-5)',
            'advanced2': 'Advanced (level 6-10)',
            'other': 'Other',
          })}";

  static String m73(category) => "${Intl.select(category, {
            'starting': 'Starting',
            'basic': 'Basic',
            'special': 'Special',
            'advanced1': 'Advanced (1-5)',
            'advanced2': 'Advanced (6-10)',
            'other': 'Other',
          })}";

  static String m74(entity) => "Move ${entity} to bottom";

  static String m75(entity) => "Move ${entity} to top";

  static String m76(count) => "${Intl.plural(count, zero: 'No moves', one: 'One move', other: '${count} moves')}";

  static String m77(entity) => "My ${entity}";

  static String m78(entity) => "No ${entity}";

  static String m79(count) => "${Intl.plural(count, zero: 'No notes', one: 'One note', other: '${count} notes')}";

  static String m80(count, singular, plural) =>
      "${Intl.plural(count, one: 'One ${singular}', other: '${count} ${plural}')}";

  static String m81(dice) => "Roll ${dice}";

  static String m82(dice) => "Roll ${dice}\n* Rolling with debility";

  static String m83(dice, mod) => "Dice: ${dice} | Modifier: ${mod}";

  static String m84(total) => "Total: ${total}";

  static String m85(total) => "Total: ${total}";

  static String m86(count) => "Rolling ${count} dice";

  static String m87(entity) => "Save ${entity}";

  static String m88(entity) => "Type to search ${entity}";

  static String m89(entity) => "Select ${entity}";

  static String m90(string) => "Select ${string} to add";

  static String m91(provider) => "This device only supports unlinking ${provider} accounts.";

  static String m92(provider) =>
      "You may only unlink ${provider} from this device.\nTo link accounts using the ${provider} provider is only available from supported devices.";

  static String m93(provider) => "${Intl.select(provider, {
            'facebook': 'Facebook',
            'google': 'Google',
            'apple': 'Apple',
            'password': 'Dungeon Paper',
            'other': 'Other',
          })}";

  static String m94(provider) => "Sign in with ${provider}";

  static String m95(length) => "Password must be at least ${length} characters";

  static String m96(pattern) => "Password must contain ${pattern}";

  static String m97(length) => "Username must be at least ${length} characters";

  static String m98(provider) => "Sign up with ${provider}";

  static String m99(button) => "${Intl.select(button, {
            'damage': 'Damage',
            'other': '${button}',
          })}";

  static String m100(level) => "${Intl.select(level, {
            'cantrip': 'Cantrip',
            'rote': 'Rote',
            'other': 'Level ${level}',
          })}";

  static String m101(count) => "${Intl.plural(count, zero: 'No spells', one: 'One spell', other: '${count} spells')}";

  static String m102(tag) => "Copy from: ${tag}";

  static String m103(entity) => "View ${entity}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "abilityScoreBondDebilityDescription": MessageLookupByLibrary.simpleMessage(""),
        "abilityScoreBondDebilityName": MessageLookupByLibrary.simpleMessage("Lonely"),
        "abilityScoreBondDescription": MessageLookupByLibrary.simpleMessage(
            "When a move has you roll+BOND you\'ll count the number of bonds you have with the character in question and add that to the roll."),
        "abilityScoreBondName": MessageLookupByLibrary.simpleMessage("Charisma"),
        "abilityScoreButtonTooltip": m0,
        "abilityScoreChaDebilityDescription":
            MessageLookupByLibrary.simpleMessage("It may not be permanent, but for now you don\'t look so good."),
        "abilityScoreChaDebilityName": MessageLookupByLibrary.simpleMessage("Scarred"),
        "abilityScoreChaDescription": MessageLookupByLibrary.simpleMessage(
            "Measures a character\'s personality, personal magnetism, ability to lead, and appearance."),
        "abilityScoreChaName": MessageLookupByLibrary.simpleMessage("Charisma"),
        "abilityScoreConDebilityDescription": MessageLookupByLibrary.simpleMessage(
            "Something just isn\'t right inside. Maybe you\'ve got a disease or a wasting illness. Maybe you just drank too much ale last night and it\'s coming back to haunt you."),
        "abilityScoreConDebilityName": MessageLookupByLibrary.simpleMessage("Sick"),
        "abilityScoreConDescription":
            MessageLookupByLibrary.simpleMessage("Represents your character\'s health and stamina."),
        "abilityScoreConName": MessageLookupByLibrary.simpleMessage("Constitution"),
        "abilityScoreDexDebilityDescription": MessageLookupByLibrary.simpleMessage(
            "You\'re unsteady on your feet and you\'ve got a shake in your hands."),
        "abilityScoreDexDebilityName": MessageLookupByLibrary.simpleMessage("Shaky"),
        "abilityScoreDexDescription": MessageLookupByLibrary.simpleMessage("Measures agility, reflexes and balance."),
        "abilityScoreDexName": MessageLookupByLibrary.simpleMessage("Dexterity"),
        "abilityScoreFormDebilityDescriptionDescription": MessageLookupByLibrary.simpleMessage(
            "A description of the effect causing the debility and/or how it affects your character"),
        "abilityScoreFormDebilityDescriptionLabel": MessageLookupByLibrary.simpleMessage("Debility Description"),
        "abilityScoreFormDebilityNameDescription": MessageLookupByLibrary.simpleMessage(
            "The name for the debility that occurs when this stat is debilitated (takes -1 until recovered)."),
        "abilityScoreFormDebilityNameLabel": MessageLookupByLibrary.simpleMessage("Debility Name"),
        "abilityScoreFormDescriptionDescription":
            MessageLookupByLibrary.simpleMessage("A description of what this ability score represents"),
        "abilityScoreFormDescriptionLabel": MessageLookupByLibrary.simpleMessage("Ability Score Description"),
        "abilityScoreFormIconLabel": MessageLookupByLibrary.simpleMessage("Icon"),
        "abilityScoreFormKeyDescription": MessageLookupByLibrary.simpleMessage(
            "A 3-letter unique key that identifies this ability score in dice and is used as the short label for the modifier value (and not the actual score)"),
        "abilityScoreFormKeyLabel": MessageLookupByLibrary.simpleMessage("Ability Score Key"),
        "abilityScoreFormNameDescription": MessageLookupByLibrary.simpleMessage("The name of this ability score"),
        "abilityScoreFormNameLabel": MessageLookupByLibrary.simpleMessage("Ability Score Name"),
        "abilityScoreFormPickIconLabel": MessageLookupByLibrary.simpleMessage("Change Icon"),
        "abilityScoreInfo": MessageLookupByLibrary.simpleMessage(
            "You can drag & drop the stat cards to change the order in which they appear throughout this character\'s screens."),
        "abilityScoreIntDebilityDescription": MessageLookupByLibrary.simpleMessage(
            "That last knock to the head shook something loose. Brain not work so good."),
        "abilityScoreIntDebilityName": MessageLookupByLibrary.simpleMessage("Stunned"),
        "abilityScoreIntDescription":
            MessageLookupByLibrary.simpleMessage("Determines how well your character learns and reasons."),
        "abilityScoreIntName": MessageLookupByLibrary.simpleMessage("Intelligence"),
        "abilityScoreModifierValueLabel": m1,
        "abilityScoreRollButtonTooltip": MessageLookupByLibrary.simpleMessage("Roll random stat"),
        "abilityScoreStrDebilityDescription": MessageLookupByLibrary.simpleMessage(
            "You can\'t exert much force. Maybe it\'s just fatigue and injury, or maybe your strength was drained by magic."),
        "abilityScoreStrDebilityName": MessageLookupByLibrary.simpleMessage("Weak"),
        "abilityScoreStrDescription": MessageLookupByLibrary.simpleMessage("Measures muscle and physical power."),
        "abilityScoreStrName": MessageLookupByLibrary.simpleMessage("Strength"),
        "abilityScoreWisDebilityDescription":
            MessageLookupByLibrary.simpleMessage("Ears ringing. Vision blurred. You\'re more than a little out of it."),
        "abilityScoreWisDebilityName": MessageLookupByLibrary.simpleMessage("Confused"),
        "abilityScoreWisDescription": MessageLookupByLibrary.simpleMessage(
            "Describes a character\'s willpower, common sense, awareness, and intuition."),
        "abilityScoreWisName": MessageLookupByLibrary.simpleMessage("Wisdom"),
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "aboutAuthor": MessageLookupByLibrary.simpleMessage("Chen Asraf"),
        "aboutCopyright": m2,
        "aboutIconCredits": MessageLookupByLibrary.simpleMessage("Icon Credits"),
        "aboutJoinDiscord": MessageLookupByLibrary.simpleMessage("Join Our Discord"),
        "aboutJoinDiscordSubtitle": MessageLookupByLibrary.simpleMessage(
            "Join the Discord community to ask questions, get help, send feedback, or just chat with other players."),
        "aboutSendFeedback": MessageLookupByLibrary.simpleMessage("Send Feedback"),
        "aboutSendFeedbackSubtitle": MessageLookupByLibrary.simpleMessage(
            "We reply more promptly through Discord, but you can send us feedback, bug reports or suggestions about the app directly here as an alternative."),
        "aboutSocialLinks": MessageLookupByLibrary.simpleMessage("Links"),
        "aboutSpecialThanks": MessageLookupByLibrary.simpleMessage("Special Thanks"),
        "aboutTitle": MessageLookupByLibrary.simpleMessage("About"),
        "aboutVersion": m3,
        "account": MessageLookupByLibrary.simpleMessage("Account"),
        "accountCategoryDetails": MessageLookupByLibrary.simpleMessage("Account Details"),
        "accountCategorySocials": MessageLookupByLibrary.simpleMessage("Connected Logins"),
        "accountChangeDisplayNameHint": MessageLookupByLibrary.simpleMessage("Enter your public display name"),
        "accountChangeDisplayNameLabel": MessageLookupByLibrary.simpleMessage("Display Name"),
        "accountChangeDisplayNameSuccess": MessageLookupByLibrary.simpleMessage("Display name changed successfully"),
        "accountChangeDisplayNameTitle": MessageLookupByLibrary.simpleMessage("Change Display Name"),
        "accountChangeEmailHint": MessageLookupByLibrary.simpleMessage("Enter your new email address"),
        "accountChangeEmailLabel": MessageLookupByLibrary.simpleMessage("Email Address"),
        "accountChangeEmailSuccess": MessageLookupByLibrary.simpleMessage("Email address changed successfully"),
        "accountChangeEmailTitle": MessageLookupByLibrary.simpleMessage("Change Email Address"),
        "accountChangeImageSubtitle": MessageLookupByLibrary.simpleMessage("Change your profile picture"),
        "accountChangeImageTitle": MessageLookupByLibrary.simpleMessage("Change Profile Picture"),
        "accountChangePasswordConfirmHint": MessageLookupByLibrary.simpleMessage("Enter the same password again"),
        "accountChangePasswordConfirmLabel": MessageLookupByLibrary.simpleMessage("Confirm New Password"),
        "accountChangePasswordHint": MessageLookupByLibrary.simpleMessage("Enter your new password"),
        "accountChangePasswordLabel": MessageLookupByLibrary.simpleMessage("New Password"),
        "accountChangePasswordSubtitle": MessageLookupByLibrary.simpleMessage("Change your password"),
        "accountChangePasswordSuccess": MessageLookupByLibrary.simpleMessage("Password changed successfully"),
        "accountChangePasswordTitle": MessageLookupByLibrary.simpleMessage("Change Password"),
        "accountDelete": MessageLookupByLibrary.simpleMessage("Delete Your Account"),
        "actionSummaryChipCoins": m4,
        "actionSummaryChipLoad": m5,
        "actionsBasicMoves": MessageLookupByLibrary.simpleMessage("Basic Moves"),
        "actionsSpecialMoves": MessageLookupByLibrary.simpleMessage("Special Moves"),
        "actionsViewVisibleLabel": MessageLookupByLibrary.simpleMessage("Show"),
        "addCustomGeneric": m6,
        "addExistingGeneric": m7,
        "addGeneric": m8,
        "addRepoItemTabOnline": MessageLookupByLibrary.simpleMessage("Online"),
        "addRepoItemTabPlaybook": MessageLookupByLibrary.simpleMessage("Playbook"),
        "alignment": m9,
        "alignmentLabel": MessageLookupByLibrary.simpleMessage("Alignment"),
        "all": MessageLookupByLibrary.simpleMessage("All"),
        "allGeneric": m10,
        "alreadyAdded": MessageLookupByLibrary.simpleMessage("Already added"),
        "amount": MessageLookupByLibrary.simpleMessage("Amount"),
        "appName": MessageLookupByLibrary.simpleMessage("Dungeon Paper"),
        "armor": MessageLookupByLibrary.simpleMessage("Armor"),
        "basicInfoImageChoose": MessageLookupByLibrary.simpleMessage("Choose Photo..."),
        "basicInfoImageChooseNew": MessageLookupByLibrary.simpleMessage("Change Photo..."),
        "basicInfoImageNeedAccountLinkLabel": MessageLookupByLibrary.simpleMessage("Sign in or create an account"),
        "basicInfoImageNeedAccountPrefix":
            MessageLookupByLibrary.simpleMessage("You need to be signed in to upload images."),
        "basicInfoImageNeedAccountSuffix":
            MessageLookupByLibrary.simpleMessage(", or upload using your own URL below."),
        "basicInfoImageRemove": MessageLookupByLibrary.simpleMessage("Remove Photo"),
        "basicInfoImageUploading": MessageLookupByLibrary.simpleMessage("UPLOADING..."),
        "basicInformationTitle": MessageLookupByLibrary.simpleMessage("Basic Information"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "changeGeneric": m11,
        "characterAutoArmor": MessageLookupByLibrary.simpleMessage("Use armor from class & equipped items"),
        "characterAutoDamage": MessageLookupByLibrary.simpleMessage("Use damage dice from class & equipped items"),
        "characterAutoMaxLoad": MessageLookupByLibrary.simpleMessage("Use class base load + STR mod"),
        "characterBarHp": MessageLookupByLibrary.simpleMessage("HP"),
        "characterBarXp": MessageLookupByLibrary.simpleMessage("XP"),
        "characterBioDialogAlignmentDescriptionLabel": MessageLookupByLibrary.simpleMessage("Alignment Description"),
        "characterBioDialogAlignmentDescriptionPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Alignment is your character\'s way of thinking and moral compass. This can center on an ethical ideal, religious strictures or early life events. It reflects what your character values and aspires to protect or create."),
        "characterBioDialogAlignmentNameDisplayLabel": MessageLookupByLibrary.simpleMessage("Alignment:"),
        "characterBioDialogAlignmentNameLabel": MessageLookupByLibrary.simpleMessage("Alignment"),
        "characterBioDialogAlignmentNamePlaceholder": MessageLookupByLibrary.simpleMessage("Select alignment"),
        "characterBioDialogDescLabel": MessageLookupByLibrary.simpleMessage("Character & background description"),
        "characterBioDialogDescPlaceholder":
            MessageLookupByLibrary.simpleMessage("Describe your character\'s background, personality, goals, etc."),
        "characterBioDialogLooksLabel": MessageLookupByLibrary.simpleMessage("Looks"),
        "characterBioDialogLooksPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Describe your character\'s appearance. You may use the presets from the buttons above."),
        "characterBioDialogTitle": MessageLookupByLibrary.simpleMessage("Character Biography"),
        "characterBondsFlagsDialogBond": MessageLookupByLibrary.simpleMessage("Bond"),
        "characterBondsFlagsDialogBonds": MessageLookupByLibrary.simpleMessage("Bonds"),
        "characterBondsFlagsDialogFlag": MessageLookupByLibrary.simpleMessage("Flag"),
        "characterBondsFlagsDialogFlags": MessageLookupByLibrary.simpleMessage("Flags"),
        "characterBondsFlagsDialogInfoText": MessageLookupByLibrary.simpleMessage(
            "You can add, update or remove bonds & flags using the edit icon above."),
        "characterBondsFlagsDialogNoData": MessageLookupByLibrary.simpleMessage(
            "You have no bonds or flags. You can add some using the edit button above, then mark them off as completed as you go along your adventure."),
        "characterBondsFlagsDialogTitle": MessageLookupByLibrary.simpleMessage("Bonds & Flags"),
        "characterDebilitiesDialogInfoText": MessageLookupByLibrary.simpleMessage(
            "Debilities are temporary, negative conditions or states in which your character is in. When a stat is debilitated, it causes its modifier to be reduced by 1 until recovered."),
        "characterDebilitiesDialogTitle": MessageLookupByLibrary.simpleMessage("Debilities"),
        "characterHeaderSubtitle": m12,
        "characterHeaderSubtitleAlignment": m13,
        "characterHeaderSubtitleClass": m14,
        "characterHeaderSubtitleLevel": m15,
        "characterHeaderSubtitleRace": m16,
        "characterHeaderSubtitleSeparator": MessageLookupByLibrary.simpleMessage(" ∙ "),
        "characterListTitle": MessageLookupByLibrary.simpleMessage("All Characters"),
        "characterMenu": MessageLookupByLibrary.simpleMessage("Character Menu"),
        "characterNoCategory": MessageLookupByLibrary.simpleMessage("No Category"),
        "characterRollsTitle": MessageLookupByLibrary.simpleMessage("Ability Scores"),
        "characterSelectTheme": MessageLookupByLibrary.simpleMessage("Character Theme"),
        "coins": MessageLookupByLibrary.simpleMessage("Coins"),
        "coinsWithCount": m17,
        "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
        "confirmDeleteAccount1Body": MessageLookupByLibrary.simpleMessage(
            "Are you sure you want to delete your account?\n\nThis action cannot be undone."),
        "confirmDeleteAccount1Title": MessageLookupByLibrary.simpleMessage("Delete Your Account?"),
        "confirmDeleteAccount2Body": MessageLookupByLibrary.simpleMessage(
            "We do not save any data for deleted accounts. All your data will be permanently deleted.\n\nAre you sure you want to delete your account?\n\nPlease confirm this one last time."),
        "confirmDeleteAccount2Title": MessageLookupByLibrary.simpleMessage("Are you really sure?"),
        "confirmDeleteBody": m18,
        "confirmDeleteTitle": m19,
        "confirmExitDefaultCancelLabel": MessageLookupByLibrary.simpleMessage("Continue editing"),
        "confirmExitDefaultOkLabel": MessageLookupByLibrary.simpleMessage("Exit & Discard"),
        "confirmExitDefaultText": MessageLookupByLibrary.simpleMessage(
            "Going back will lose any unsaved changes.\nAre you sure you want to go back?"),
        "confirmExitDefaultTitle": MessageLookupByLibrary.simpleMessage("Are you sure?"),
        "confirmUnlinkProviderBody": m20,
        "confirmUnlinkProviderTitle": m21,
        "continueLabel": MessageLookupByLibrary.simpleMessage("Continue"),
        "createCharRandomizeNameTooltipClick": MessageLookupByLibrary.simpleMessage("Click to generate a random name"),
        "createCharRandomizeNameTooltipTouch": MessageLookupByLibrary.simpleMessage("Tap to generate a random name"),
        "createCharacterAddButton": MessageLookupByLibrary.simpleMessage("Create Character"),
        "createCharacterAvatarFieldLabel": MessageLookupByLibrary.simpleMessage("Photo URL"),
        "createCharacterAvatarFieldPlaceholder": MessageLookupByLibrary.simpleMessage("Paste an image URL"),
        "createCharacterBioFieldLabel": MessageLookupByLibrary.simpleMessage("Biography"),
        "createCharacterBioFieldPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Describe your character as shortly or thoroughly as you want here.\nPut your backstory, a visual description, some personality traits, etc. to help you keep in character."),
        "createCharacterClassDescription": m22,
        "createCharacterClassHelpText": MessageLookupByLibrary.simpleMessage("No class selected (required)"),
        "createCharacterDescFieldLabel": MessageLookupByLibrary.simpleMessage("Biography/description"),
        "createCharacterDescFieldPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Enter general information about your character - backstory, goals & ambitions, behavior descriptions, etc"),
        "createCharacterFinishButton": MessageLookupByLibrary.simpleMessage("Review"),
        "createCharacterMovesSpells": MessageLookupByLibrary.simpleMessage("Moves & Spells"),
        "createCharacterMovesSpellsDescription": m23,
        "createCharacterNameFieldLabel": MessageLookupByLibrary.simpleMessage("Character Name"),
        "createCharacterNameFieldPlaceholder": MessageLookupByLibrary.simpleMessage("Enter your character\'s name"),
        "createCharacterPreviewPageMaxHp": m24,
        "createCharacterPreviewPageTitle": MessageLookupByLibrary.simpleMessage("Preview Character"),
        "createCharacterProceedTooltip": MessageLookupByLibrary.simpleMessage("Continue"),
        "createCharacterRaceDescFieldLabel": MessageLookupByLibrary.simpleMessage("Race description"),
        "createCharacterRaceDescFieldPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Describe a special move usable by your race. It will appear alongside the rest of the moves."),
        "createCharacterRaceNameFieldLabel": MessageLookupByLibrary.simpleMessage("Race"),
        "createCharacterRaceNameFieldPlaceholder": MessageLookupByLibrary.simpleMessage("Race name"),
        "createCharacterSaveButton": MessageLookupByLibrary.simpleMessage("Create Character"),
        "createCharacterStartingGearChoiceCountNoMax": m25,
        "createCharacterStartingGearChoiceCountWithMax": m26,
        "createCharacterStartingGearDescriptionCoins": m27,
        "createCharacterStartingGearDescriptionItem": m28,
        "createCharacterStartingGearHelpText":
            MessageLookupByLibrary.simpleMessage("Select your starting gear determined by class (optional)"),
        "createCharacterStepInvalidTooltip": m29,
        "createCharacterTitle": MessageLookupByLibrary.simpleMessage("Create Character"),
        "createCharacterTravelerBlankName": MessageLookupByLibrary.simpleMessage("Unnamed Traveler"),
        "createCharacterTravelerDescription": m30,
        "createCharacterTravelerHelpText": MessageLookupByLibrary.simpleMessage("Select name & picture (required)"),
        "createGeneric": m31,
        "customButtonLeft": MessageLookupByLibrary.simpleMessage("Left Button"),
        "customButtonRight": MessageLookupByLibrary.simpleMessage("Right Button"),
        "customRollButtons": MessageLookupByLibrary.simpleMessage("Quick Roll Buttons"),
        "customRollButtonsUseDefault": MessageLookupByLibrary.simpleMessage("Use Default"),
        "customRollButtonsUsePreset": MessageLookupByLibrary.simpleMessage("Presets"),
        "damage": MessageLookupByLibrary.simpleMessage("Damage"),
        "damageDice": MessageLookupByLibrary.simpleMessage("Damage Dice"),
        "debilityLabel": m32,
        "diceAmount": MessageLookupByLibrary.simpleMessage("Amount"),
        "diceRollAgain": MessageLookupByLibrary.simpleMessage("Roll"),
        "diceSeparator": MessageLookupByLibrary.simpleMessage("d"),
        "diceSides": MessageLookupByLibrary.simpleMessage("Sides"),
        "diceSuggestion": m33,
        "diceUseStat": MessageLookupByLibrary.simpleMessage("Roll Stat"),
        "diceUseStatLabel": MessageLookupByLibrary.simpleMessage("Stat"),
        "diceUseStatPlaceholder": MessageLookupByLibrary.simpleMessage("Select Stat"),
        "diceUseStatValue": m34,
        "diceUseValue": MessageLookupByLibrary.simpleMessage("Fixed Value"),
        "diceUseValueLabel": MessageLookupByLibrary.simpleMessage("Modifier value"),
        "diceUseValuePlaceholder": MessageLookupByLibrary.simpleMessage("Number, e.g. 2 or -1"),
        "done": MessageLookupByLibrary.simpleMessage("Done"),
        "dynamicCategoriesItems": MessageLookupByLibrary.simpleMessage("Equipped Items"),
        "dynamicCategoriesMoves": MessageLookupByLibrary.simpleMessage("Favorite Moves"),
        "dynamicCategoriesNotes": MessageLookupByLibrary.simpleMessage("Bookmarked Notes"),
        "dynamicCategoriesSpells": MessageLookupByLibrary.simpleMessage("Prepared Spells"),
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editGeneric": m35,
        "endOfSessionQ1":
            MessageLookupByLibrary.simpleMessage("Did we learn something new and important about the world?"),
        "endOfSessionQ2": MessageLookupByLibrary.simpleMessage("Did we overcome a notable monster or enemy?"),
        "endOfSessionQ3": MessageLookupByLibrary.simpleMessage("Did we loot a memorable treasure?"),
        "endOfSessionQuestions": MessageLookupByLibrary.simpleMessage("End of Session Questions"),
        "endOfSessionQuestionsSubtitle": MessageLookupByLibrary.simpleMessage(
            "Answer these questions as a group. For each \"yes\" answer, XP is marked."),
        "entity": m36,
        "entityPlural": m37,
        "entityShareStatusDetached": m38,
        "entityShareStatusInSync": m39,
        "entityShareStatusOutOfSync": m40,
        "entityWithCount": m41,
        "errorExactLength": m42,
        "errorInvalidEmail": MessageLookupByLibrary.simpleMessage("Invalid email address"),
        "errorMaxLength": m43,
        "errorMinLength": m44,
        "errorMustContain": m45,
        "errorMustNotContain": m46,
        "errorNoSelection": MessageLookupByLibrary.simpleMessage("None selected"),
        "errorNoSelectionGeneric": m47,
        "errorNoSelectionGenericRequired": m48,
        "errorOnlyLetters": MessageLookupByLibrary.simpleMessage("Must contain letters only"),
        "errorUpload": MessageLookupByLibrary.simpleMessage(
            "Error while uploading photo. Try again later, or contact support using the \"About\" page."),
        "errorUserOperationCanceled": MessageLookupByLibrary.simpleMessage("Operation canceled"),
        "explanation": MessageLookupByLibrary.simpleMessage("Further details"),
        "export": MessageLookupByLibrary.simpleMessage("Export"),
        "exportFailedMessage": MessageLookupByLibrary.simpleMessage(
            "Something went wrong.\nTry again or contact support if this persists"),
        "exportFailedTitle": MessageLookupByLibrary.simpleMessage("Export Failed"),
        "exportSuccessfulMessage": MessageLookupByLibrary.simpleMessage("Your data was exported to file successfully"),
        "exportSuccessfulTitle": MessageLookupByLibrary.simpleMessage("Export Successful"),
        "formCharacterClassBaseHp": MessageLookupByLibrary.simpleMessage("Base HP"),
        "formCharacterClassBaseLoad": MessageLookupByLibrary.simpleMessage("Base Load"),
        "formCharacterClassDamage": MessageLookupByLibrary.simpleMessage("Damage Dice"),
        "formCharacterClassDescriptionPlaceholder": MessageLookupByLibrary.simpleMessage(
            "Give a general description of your class. Describe a calling for the type of person or creature that would choose or be raised in to this adventuring profession."),
        "formCharacterClassNamePlaceholder": MessageLookupByLibrary.simpleMessage("Enter the class name"),
        "formGeneralCategory": MessageLookupByLibrary.simpleMessage("Category"),
        "formGeneralCategoryGeneric": m49,
        "formGeneralDescription": MessageLookupByLibrary.simpleMessage("Description"),
        "formGeneralDescriptionGeneric": m50,
        "formGeneralExplanation": MessageLookupByLibrary.simpleMessage("Explanation"),
        "formGeneralExplanationGeneric": m51,
        "formGeneralName": MessageLookupByLibrary.simpleMessage("Name"),
        "formGeneralNameGeneric": m52,
        "formGeneralTitle": MessageLookupByLibrary.simpleMessage("Title"),
        "formGeneralTitleGeneric": m53,
        "formatBold": MessageLookupByLibrary.simpleMessage("Bold"),
        "formatBulletList": MessageLookupByLibrary.simpleMessage("Bullet List"),
        "formatCell": m54,
        "formatCheckboxList": MessageLookupByLibrary.simpleMessage("Check List (Checked)"),
        "formatCheckboxListUnchecked": MessageLookupByLibrary.simpleMessage("Check List (Unchecked)"),
        "formatHeader": m55,
        "formatHeaderNoNum": m56,
        "formatHeading": m57,
        "formatHeadings": MessageLookupByLibrary.simpleMessage("Headings"),
        "formatHelp": MessageLookupByLibrary.simpleMessage("Formatting Help"),
        "formatImageURL": MessageLookupByLibrary.simpleMessage("Image URL"),
        "formatItalic": MessageLookupByLibrary.simpleMessage("Italic"),
        "formatNumberedList": MessageLookupByLibrary.simpleMessage("Numbered List"),
        "formatPreview": MessageLookupByLibrary.simpleMessage("Preview"),
        "formatTable": MessageLookupByLibrary.simpleMessage("Table"),
        "formatURL": MessageLookupByLibrary.simpleMessage("URL"),
        "genericDescriptionField": m58,
        "genericNameField": m59,
        "genericValueField": m60,
        "homeEmptyStateLoginSubtitle":
            MessageLookupByLibrary.simpleMessage("Online data sync, library sharing, campaigns and more!"),
        "homeEmptyStateLoginTitle": MessageLookupByLibrary.simpleMessage("Sign in to get more features"),
        "homeEmptyStateSubtitle": MessageLookupByLibrary.simpleMessage("Create a Character to get started"),
        "homeEmptyStateTitle": MessageLookupByLibrary.simpleMessage("No Characters"),
        "hp": MessageLookupByLibrary.simpleMessage("HP"),
        "hpDialogChangeAdd": m61,
        "hpDialogChangeNeutral": MessageLookupByLibrary.simpleMessage("No Change"),
        "hpDialogChangeOverrideMax": MessageLookupByLibrary.simpleMessage("Override Max HP"),
        "hpDialogChangeRemove": m62,
        "hpDialogCurrentHP": MessageLookupByLibrary.simpleMessage("Current HP"),
        "hpDialogTitle": MessageLookupByLibrary.simpleMessage("Modify HP"),
        "import": MessageLookupByLibrary.simpleMessage("Import"),
        "importBrowseFile": MessageLookupByLibrary.simpleMessage("Browse..."),
        "importBrowseHelp": MessageLookupByLibrary.simpleMessage(
            "To start importing, pick the file you want to import from.\nYou will then be able to select what to save and what to leave out."),
        "importClearFile": MessageLookupByLibrary.simpleMessage("Clear selected file"),
        "importExportTitle": MessageLookupByLibrary.simpleMessage("Export/Import"),
        "importFailedMessage": MessageLookupByLibrary.simpleMessage(
            "Something went wrong.\nTry again or contact support if this persists"),
        "importFailedTitle": MessageLookupByLibrary.simpleMessage("Import Failed"),
        "importProgressProcessing": m63,
        "importProgressTitle": MessageLookupByLibrary.simpleMessage("Importing..."),
        "importSuccessMessage": MessageLookupByLibrary.simpleMessage("Your data was imported from file successfully"),
        "importSuccessTitle": MessageLookupByLibrary.simpleMessage("Successful"),
        "itemAmountX": m64,
        "itemSettingsCountArmor": MessageLookupByLibrary.simpleMessage("Count Armor"),
        "itemSettingsCountDamage": MessageLookupByLibrary.simpleMessage("Count Damage"),
        "itemSettingsCountWeight": MessageLookupByLibrary.simpleMessage("Count Weight"),
        "items": MessageLookupByLibrary.simpleMessage("Items"),
        "itemsWithCount": m65,
        "level": MessageLookupByLibrary.simpleMessage("Level"),
        "libraryCollectionListItemSubtitle": m66,
        "libraryCollectionListItemSubtitleType": m67,
        "libraryCollectionTitle": MessageLookupByLibrary.simpleMessage("My Library"),
        "libraryListNoItemsFoundClearFiltersButton": MessageLookupByLibrary.simpleMessage("Clear Filters"),
        "libraryListNoItemsFoundSubtitleFilters": m68,
        "libraryListNoItemsFoundSubtitleNoFilters": m69,
        "libraryListNoItemsFoundTitle": m70,
        "loadingCharacters": MessageLookupByLibrary.simpleMessage("Getting characters..."),
        "loadingGeneral": MessageLookupByLibrary.simpleMessage("Loading..."),
        "loadingUser": MessageLookupByLibrary.simpleMessage("Signing in..."),
        "markdownPreview": MessageLookupByLibrary.simpleMessage("Content Preview"),
        "maxLoad": MessageLookupByLibrary.simpleMessage("Max Load"),
        "migrationSubtitle": MessageLookupByLibrary.simpleMessage(
            "To get started, pick a username and the language for the rulebook & app. If you already have an existing Dungeon Paper account your data might take a few seconds to migrate."),
        "migrationTitle": MessageLookupByLibrary.simpleMessage("Welcome to\nDungeon Paper 2!"),
        "migrationUsernameInfo": MessageLookupByLibrary.simpleMessage(
            "Your username is unique and can not be changed later, so think carefully! It will be used to identify all your library items when publishing."),
        "moveCategory": m71,
        "moveCategoryWithLevel": m72,
        "moveCategoryWithLevelShort": m73,
        "moveToEnd": MessageLookupByLibrary.simpleMessage("Move to bottom"),
        "moveToEndGeneric": m74,
        "moveToStart": MessageLookupByLibrary.simpleMessage("Move to top"),
        "moveToStartGeneric": m75,
        "moves": MessageLookupByLibrary.simpleMessage("Moves"),
        "movesWithCount": m76,
        "myGeneric": m77,
        "navActions": MessageLookupByLibrary.simpleMessage("Use"),
        "navCharacter": MessageLookupByLibrary.simpleMessage("Character"),
        "navJournal": MessageLookupByLibrary.simpleMessage("Journal"),
        "noDescription": MessageLookupByLibrary.simpleMessage("‹No description provided›"),
        "noGeneric": m78,
        "noteNoCategory": MessageLookupByLibrary.simpleMessage("General"),
        "notes": MessageLookupByLibrary.simpleMessage("Notes"),
        "notesWithCount": m79,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "passwordHideTooltip": MessageLookupByLibrary.simpleMessage("Hide password"),
        "passwordShowTooltip": MessageLookupByLibrary.simpleMessage("Show password"),
        "pluralize": m80,
        "privacyPolicy": MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "quickIconsItems": MessageLookupByLibrary.simpleMessage("Items"),
        "quickIconsMoves": MessageLookupByLibrary.simpleMessage("Moves"),
        "quickIconsNote": MessageLookupByLibrary.simpleMessage("+ Note"),
        "quickIconsSpells": MessageLookupByLibrary.simpleMessage("Spells"),
        "reloadLibrary": MessageLookupByLibrary.simpleMessage("Reload Library"),
        "remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "resetToDefault": MessageLookupByLibrary.simpleMessage("Reset to default"),
        "rollAttackDamageButton": MessageLookupByLibrary.simpleMessage("Hack & Slash"),
        "rollBasicActionButton": MessageLookupByLibrary.simpleMessage("Basic Action"),
        "rollButtonLabel": MessageLookupByLibrary.simpleMessage("Button Text"),
        "rollButtonTooltip": m81,
        "rollButtonTooltipWithDebility": m82,
        "rollDialogResultBreakdown": m83,
        "rollDialogResultTotal": m84,
        "rollDialogTitleRolled": m85,
        "rollDialogTitleRolling": m86,
        "rollDiscernRealitiesButton": MessageLookupByLibrary.simpleMessage("Discern Realities"),
        "rollVolleyButton": MessageLookupByLibrary.simpleMessage("Volley"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "saveGeneric": m87,
        "searchIn": MessageLookupByLibrary.simpleMessage("Search in: "),
        "searchPlaceholder": MessageLookupByLibrary.simpleMessage("Type to search"),
        "searchPlaceholderGeneric": m88,
        "seeAll": MessageLookupByLibrary.simpleMessage("See all"),
        "select": MessageLookupByLibrary.simpleMessage("Select"),
        "selectAll": MessageLookupByLibrary.simpleMessage("Select All"),
        "selectGeneric": m89,
        "selectNone": MessageLookupByLibrary.simpleMessage("Select None"),
        "selectToAdd": m90,
        "selected": MessageLookupByLibrary.simpleMessage("Selected"),
        "sendFeedbackBodyLabel": MessageLookupByLibrary.simpleMessage("Problem description"),
        "sendFeedbackSendButton": MessageLookupByLibrary.simpleMessage("Feedback title"),
        "sendFeedbackSuccessMessage": MessageLookupByLibrary.simpleMessage(
            "Thank you for your feedback! We will review your feedback as soon as we can."),
        "sendFeedbackSuccessTitle": MessageLookupByLibrary.simpleMessage("Feedback sent!"),
        "sendFeedbackTitle": MessageLookupByLibrary.simpleMessage("Send App Feedback"),
        "sendFeedbackTitleLabel": MessageLookupByLibrary.simpleMessage("Feedback title"),
        "separatorOr": MessageLookupByLibrary.simpleMessage("OR"),
        "settingsDefaultDarkTheme": MessageLookupByLibrary.simpleMessage("Default dark theme"),
        "settingsDefaultLightTheme": MessageLookupByLibrary.simpleMessage("Default light theme"),
        "settingsGeneral": MessageLookupByLibrary.simpleMessage("General"),
        "settingsKeepScreenAwake": MessageLookupByLibrary.simpleMessage("Keep screen awake while using the app"),
        "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
        "signinButton": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signinCantUseProvider": m91,
        "signinCantUseProviderTooltip": m92,
        "signinGoToSigninButton": MessageLookupByLibrary.simpleMessage("Sign in"),
        "signinGoToSigninLabel": MessageLookupByLibrary.simpleMessage("Already have an account?"),
        "signinGoToSignupButton": MessageLookupByLibrary.simpleMessage("Sign up"),
        "signinGoToSignupLabel": MessageLookupByLibrary.simpleMessage("Don\'t have an account?"),
        "signinProvider": m93,
        "signinProviderApple": MessageLookupByLibrary.simpleMessage("Apple"),
        "signinProviderFacebook": MessageLookupByLibrary.simpleMessage("Facebook"),
        "signinProviderGoogle": MessageLookupByLibrary.simpleMessage("Google"),
        "signinProviderLink": MessageLookupByLibrary.simpleMessage("Link"),
        "signinProviderUnlink": MessageLookupByLibrary.simpleMessage("Unlink"),
        "signinSubtitle": MessageLookupByLibrary.simpleMessage(
            "Sign in to your account to sync your data online, and get access to many more features."),
        "signinTitle": MessageLookupByLibrary.simpleMessage("Sign In"),
        "signinWithButton": m94,
        "signoutButton": MessageLookupByLibrary.simpleMessage("Sign out"),
        "signupButton": MessageLookupByLibrary.simpleMessage("Sign up"),
        "signupDefaultDataLanguage": MessageLookupByLibrary.simpleMessage("Default data language"),
        "signupEmail": MessageLookupByLibrary.simpleMessage("Email"),
        "signupEmailPlaceholder": MessageLookupByLibrary.simpleMessage("Enter your email"),
        "signupEmailValidation": MessageLookupByLibrary.simpleMessage("Please enter a valid email"),
        "signupPassword": MessageLookupByLibrary.simpleMessage("Password"),
        "signupPasswordConfirm": MessageLookupByLibrary.simpleMessage("Confirm Password"),
        "signupPasswordConfirmPlaceholder": MessageLookupByLibrary.simpleMessage("Enter the same password again"),
        "signupPasswordPlaceholder": MessageLookupByLibrary.simpleMessage("Enter your password"),
        "signupPasswordValidationLength": m95,
        "signupPasswordValidationMatch": MessageLookupByLibrary.simpleMessage("Passwords do not match"),
        "signupPasswordValidationPatternGeneric": m96,
        "signupPasswordValidationPatternLetter":
            MessageLookupByLibrary.simpleMessage("Password must contain at least one capital letter"),
        "signupPasswordValidationPatternNumber":
            MessageLookupByLibrary.simpleMessage("Password must contain at least one number"),
        "signupSubtitle": MessageLookupByLibrary.simpleMessage(
            "Enter the required details below to create your Dungeon Paper account."),
        "signupTitle": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "signupUsername": MessageLookupByLibrary.simpleMessage("Username"),
        "signupUsernamePlaceholder": MessageLookupByLibrary.simpleMessage("Pick a unique username"),
        "signupUsernameValidation": m97,
        "signupUsernameValidationPattern":
            MessageLookupByLibrary.simpleMessage("Username must only contain letters, numbers, dashes and underscores"),
        "signupWithButton": m98,
        "socialApple": MessageLookupByLibrary.simpleMessage("App Store"),
        "socialDiscord": MessageLookupByLibrary.simpleMessage("Discord"),
        "socialFacebook": MessageLookupByLibrary.simpleMessage("Facebook"),
        "socialGitHub": MessageLookupByLibrary.simpleMessage("GitHub"),
        "socialGoogle": MessageLookupByLibrary.simpleMessage("Play Store"),
        "socialTwitter": MessageLookupByLibrary.simpleMessage("Twitter"),
        "sortMoveDown": MessageLookupByLibrary.simpleMessage("Move down"),
        "sortMoveUp": MessageLookupByLibrary.simpleMessage("Move up"),
        "specialDice": MessageLookupByLibrary.simpleMessage("Special Dice"),
        "specialRollButton": m99,
        "spellLevel": m100,
        "spells": MessageLookupByLibrary.simpleMessage("Spells"),
        "spellsWithCount": m101,
        "tagCopyFrom": m102,
        "tagDetails": MessageLookupByLibrary.simpleMessage("Tag Information"),
        "themeTurnDark": MessageLookupByLibrary.simpleMessage("Switch to Dark Mode"),
        "themeTurnLight": MessageLookupByLibrary.simpleMessage("Switch to Light Mode"),
        "unselect": MessageLookupByLibrary.simpleMessage("Unselect"),
        "useDefault": MessageLookupByLibrary.simpleMessage("Use default"),
        "userLoginButton": MessageLookupByLibrary.simpleMessage("Sign in"),
        "userLogoutButton": MessageLookupByLibrary.simpleMessage("Sign out"),
        "userMenuMoreChars": MessageLookupByLibrary.simpleMessage("More"),
        "userMenuRecentCharacters": MessageLookupByLibrary.simpleMessage("Recent Characters"),
        "userUnregistered": MessageLookupByLibrary.simpleMessage("Not registered"),
        "view": MessageLookupByLibrary.simpleMessage("View"),
        "viewGeneric": m103,
        "whatsNew": MessageLookupByLibrary.simpleMessage("What\'s new?"),
        "xpDialogChangeOverride": MessageLookupByLibrary.simpleMessage("Update manually"),
        "xpDialogEndSession": MessageLookupByLibrary.simpleMessage("End Session"),
        "xpDialogOverrideInfoText": MessageLookupByLibrary.simpleMessage(
            "Changing the current XP or level manually will cause the pending XP to be discarded unless this is unchecked."),
        "xpDialogOverrideLevel": MessageLookupByLibrary.simpleMessage("Override Level"),
        "xpDialogOverrideXp": MessageLookupByLibrary.simpleMessage("Override XP"),
        "xpDialogResetSessionMarks":
            MessageLookupByLibrary.simpleMessage("Reset bonds, flags & end of session questions after saving"),
        "xpDialogTitle": MessageLookupByLibrary.simpleMessage("Mark Session XP"),
        "xpDialogTitleOverriding": MessageLookupByLibrary.simpleMessage("Update XP & Level")
      };
}
