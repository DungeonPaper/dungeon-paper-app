// ignore_for_file: non_constant_identifier_names, constant_identifier_names

class DwIcons {
  static const armor = DwIconData.svgIcon(name: 'armor', fileName: 'armor');
  static const book_cover = DwIconData.svgIcon(name: 'book_cover', fileName: 'book_cover');
  static const dice_d6 = DwIconData.svgIcon(name: 'dice_d6', fileName: 'dice_d6');
  static const hand_rock = DwIconData.svgIcon(name: 'hand_rock', fileName: 'hand_rock');
  static const knapsack = DwIconData.svgIcon(name: 'knapsack', fileName: 'knapsack');
  static const riposte = DwIconData.svgIcon(name: 'riposte', fileName: 'riposte');
  static const scroll_quill = DwIconData.svgIcon(name: 'scroll_quill', fileName: 'scroll_quill');
  static const exclamation = DwIconData.svgIcon(name: 'exclamation', fileName: 'exclamation');

  // Stats
  static const stat_cha = DwIconData.svgIcon(name: 'stat_cha', fileName: 'stats/cha');
  static const stat_con = DwIconData.svgIcon(name: 'stat_con', fileName: 'stats/con');
  static const stat_dex = DwIconData.svgIcon(name: 'stat_dex', fileName: 'stats/dex');
  static const stat_int = DwIconData.svgIcon(name: 'stat_int', fileName: 'stats/int');
  static const stat_str = DwIconData.svgIcon(name: 'stat_str', fileName: 'stats/str');
  static const stat_wis = DwIconData.svgIcon(name: 'stat_wis', fileName: 'stats/wis');
}

class DwIconData {
  final String name;
  final String assetPath;

  DwIconData({required this.name, required this.assetPath});

  const DwIconData.svgIcon({required this.name, required String fileName})
      : assetPath = 'assets/icons/$fileName.svg';
}
