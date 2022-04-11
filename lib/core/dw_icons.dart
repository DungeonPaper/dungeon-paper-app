// ignore_for_file: non_constant_identifier_names, constant_identifier_names

abstract class DwIcons {
  DwIcons._();

  // General
  static const armor = DwIconData.svgIcon(name: 'armor', fileName: 'armor');
  static const book_cover = DwIconData.svgIcon(name: 'book_cover', fileName: 'book_cover');
  static const dice_d6_numbered = DwIconData.svgIcon(name: 'dice_d6', fileName: 'dice_d6');
  static const exclamation = DwIconData.svgIcon(name: 'exclamation', fileName: 'exclamation');
  static const hand_rock = DwIconData.svgIcon(name: 'hand_rock', fileName: 'hand_rock');
  static const knapsack = DwIconData.svgIcon(name: 'knapsack', fileName: 'knapsack');
  static const riposte = DwIconData.svgIcon(name: 'riposte', fileName: 'riposte');
  static const scroll_quill = DwIconData.svgIcon(name: 'scroll_quill', fileName: 'scroll_quill');
  static const swap_bag = DwIconData.svgIcon(name: 'swap_bag', fileName: 'swap_bag');
  static const coin_stack = DwIconData.svgIcon(name: 'coin_stack', fileName: 'coin_stack');
  static const dumbbell = DwIconData.svgIcon(name: 'dumbbell', fileName: 'dumbbell');
  static const quill = DwIconData.svgIcon(name: 'quill', fileName: 'quill');
  static const swords = DwIconData.svgIcon(name: 'swords', fileName: 'swords');

  // Stats
  static DwIconData statIcon(String stat) =>
      DwIconData.svgIcon(name: 'stat_$stat', fileName: 'stats/$stat');
  static const stat_cha = DwIconData.svgIcon(name: 'stat_cha', fileName: 'stats/cha');
  static const stat_con = DwIconData.svgIcon(name: 'stat_con', fileName: 'stats/con');
  static const stat_dex = DwIconData.svgIcon(name: 'stat_dex', fileName: 'stats/dex');
  static const stat_int = DwIconData.svgIcon(name: 'stat_int', fileName: 'stats/int');
  static const stat_str = DwIconData.svgIcon(name: 'stat_str', fileName: 'stats/str');
  static const stat_wis = DwIconData.svgIcon(name: 'stat_wis', fileName: 'stats/wis');

  // Dice
  static DwIconData diceIcon(int sides) =>
      DwIconData.svgIcon(name: 'dice_d$sides', fileName: 'dice/d$sides');
  static const dice_d4 = DwIconData.svgIcon(name: 'dice_d4', fileName: 'dice/d4');
  static const dice_d6 = DwIconData.svgIcon(name: 'dice_d6', fileName: 'dice/d6');
  static const dice_d8 = DwIconData.svgIcon(name: 'dice_d8', fileName: 'dice/d8');
  static const dice_d10 = DwIconData.svgIcon(name: 'dice_d10', fileName: 'dice/d10');
  static const dice_d12 = DwIconData.svgIcon(name: 'dice_d12', fileName: 'dice/d12');
  static const dice_d20 = DwIconData.svgIcon(name: 'dice_d20', fileName: 'dice/d20');
}

class DwIconData {
  final String name;
  final String assetPath;

  const DwIconData({required this.name, required this.assetPath});

  const DwIconData.svgIcon({required this.name, required String fileName})
      : assetPath = 'assets/icons/$fileName.svg';
}
