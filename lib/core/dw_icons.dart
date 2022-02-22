// ignore_for_file: non_constant_identifier_names

class DwIcons {
  static final armor = DwIconData.svgIcon(name: 'armor', fileName: 'armor');
  static final book_cover = DwIconData.svgIcon(name: 'book_cover', fileName: 'book_cover');
  static final dice_d6 = DwIconData.svgIcon(name: 'dice_d6', fileName: 'dice_d6');
  static final hand_rock = DwIconData.svgIcon(name: 'hand_rock', fileName: 'hand_rock');
  static final knapsack = DwIconData.svgIcon(name: 'knapsack', fileName: 'knapsack');
  static final riposte = DwIconData.svgIcon(name: 'riposte', fileName: 'riposte');
  static final scroll_quill = DwIconData.svgIcon(name: 'scroll_quill', fileName: 'scroll_quill');

  // Stats
  static final stat_cha = DwIconData.svgIcon(name: 'stat_cha', fileName: 'stats/cha');
  static final stat_con = DwIconData.svgIcon(name: 'stat_con', fileName: 'stats/con');
  static final stat_dex = DwIconData.svgIcon(name: 'stat_dex', fileName: 'stats/dex');
  static final stat_int = DwIconData.svgIcon(name: 'stat_int', fileName: 'stats/int');
  static final stat_str = DwIconData.svgIcon(name: 'stat_str', fileName: 'stats/str');
  static final stat_wis = DwIconData.svgIcon(name: 'stat_wis', fileName: 'stats/wis');
}

class DwIconData {
  final String name;
  final String assetPath;

  DwIconData({required this.name, required this.assetPath});

  DwIconData.svgIcon({required this.name, required String fileName})
      : assetPath = 'assets/icons/$fileName.svg';
}
