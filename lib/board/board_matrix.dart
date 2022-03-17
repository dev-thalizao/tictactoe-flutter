import 'board.dart';

class BoardMatrix<T> {
  final List<List<BoardCell<T>>> _cells;

  List<List<BoardCell<T>>> get cells => _cells;

  BoardMatrix._(this._cells);

  factory BoardMatrix.nineBox() {
    return BoardMatrix._(
      List.generate(
        3,
        (_) => List.generate(
          3,
          (_) => BoardCell.empty(),
        ),
      ),
    );
  }

  bool hasFullyFilled() {
    return cells.expand((cells) => cells).every((cell) => cell.isNotEmpty);
  }

  BoardCell<T> cellFor({required BoardIndex index}) {
    return _cells[index.row][index.collumn];
  }

  void fill({required BoardIndex index, required T value}) {
    final currentValue = _cells[index.row][index.collumn];
    if (currentValue.isEmpty) {
      _cells[index.row][index.collumn] = BoardCell.filled(value);
    }
  }
}
