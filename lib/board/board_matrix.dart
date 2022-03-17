import 'board.dart';

class BoardMatrix<T> {
  final List<List<BoardCell<T>>> _matrix;

  List<List<BoardCell<T>>> get matrix => _matrix;

  BoardMatrix._(this._matrix);

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
    return matrix.expand((cells) => cells).every((cell) => cell.isNotEmpty);
  }

  void fill({required BoardIndex index, required T value}) {
    final currentValue = _matrix[index.row][index.collumn];
    if (currentValue.isEmpty) {
      _matrix[index.row][index.collumn] = BoardCell.filled(value);
    }
  }
}
