class GridPoint {
  final int row;
  final int col;

  const GridPoint({required this.row, required this.col});

  factory GridPoint.fromIndex(int index, int columnCount) {
    final row = index ~/ columnCount;
    final col = index % columnCount;
    return GridPoint(row: row, col: col);
  }
}
