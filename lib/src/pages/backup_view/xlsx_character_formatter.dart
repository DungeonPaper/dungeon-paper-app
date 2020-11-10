import 'package:dungeon_paper/db/models/character.dart';
import 'package:excel/excel.dart';

class _Stat {
  int rowIndex;
  int columnIndex;
  String name;
  int value;

  _Stat(this.columnIndex, this.rowIndex, this.name, this.value);
}

Future<Sheet> formatCharacter(Character character) async {
  final xl = Excel.createExcel();
  final sheet = xl.sheets[await xl.getDefaultSheet()];
  final headerStyle = CellStyle(
    backgroundColorHex: '#000000',
    fontColorHex: '#FFFFFF',
  );

  final nameCellIndex = CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0);

  sheet.updateCell(
    nameCellIndex,
    character.displayName,
    cellStyle: headerStyle,
  );

  final stats = [
    _Stat(0, 0, 'STR', character.str),
    _Stat(0, 1, 'DEX', character.dex),
    _Stat(0, 2, 'CON', character.con),
    _Stat(2, 0, 'WIS', character.wis),
    _Stat(0, 1, 'INT', character.int),
    _Stat(0, 2, 'CHA', character.cha),
  ];

  for (final stat in stats) {
    sheet.updateCell(
      CellIndex.indexByColumnRow(
          columnIndex: stat.columnIndex, rowIndex: stat.rowIndex),
      '${stat.name}\n${stat.value}',
    );
  }

  return sheet;
}
