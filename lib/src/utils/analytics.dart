import 'package:firebase_analytics/firebase_analytics.dart';
export 'package:firebase_analytics/firebase_analytics.dart'
    show FirebaseAnalytics;

final analytics = FirebaseAnalytics();

class Events {
  static const OpenSidebar = 'open_sidebar';
  static const ChangeCharacter = 'change_character';
  static const ReturnToScreen = 'return_to_screen';
  static const OpenDiceDialog = 'open_dice_screen';
  static const RollNewDice = 'roll_new_dice';
  static const RerollDice = 'reroll_dice';
  static const EditDice = 'edit_dice';
  static const RemoveDice = 'remove_dice';
  static const ExpandMoveCard = 'expand_move_card';
  static const ExpandSpellCard = 'expand_spell_card';
  static const ExpandNoteCard = 'expand_note_card';
  static const ExpandInventoryItemCard = 'expand_inventory_item_card';
  static const OpenCoinsChip = 'open_coins_chip';
  static const SaveCharacter = 'save_character';
  static const DeleteCharacter = 'delete_character';
  static const SaveCustomClass = 'save_custom_class';
  static const DeleteCustomClass = 'delete_custom_class';
  static const EditStat = 'edit_stat';
  static const SaveHP = 'save_hp';
  static const SaveXP = 'save_xp';
  static const LevelUp = 'lv_up';
  static const LevelDown = 'lv_down';
}

class ScreenNames {
  static const DiceRoll = 'edit_character';
  static const CharacterScreen = 'edit_character';
  static const ManageCharacters = 'manage_characters';
  static const Compendium = 'compendium';
  static const CustomClasses = 'custom_classes';
  static const About = 'about';
}
