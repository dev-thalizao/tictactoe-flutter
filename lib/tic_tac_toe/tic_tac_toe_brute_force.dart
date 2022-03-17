import 'tic_tac_toe.dart';

class TicTacToeBruteForce {
  TicTacToeBruteForce._();

  static TicTacToeMatcher<String> matcher() {
    return (player, board) {
      final cells = board.matrix.map(
        (cells) {
          return cells
              .map((cell) => cell.isNotEmpty ? cell.value! : "")
              .toList();
        },
      ).toList();

      final expected = List.generate(3, (_) => player);

      return _hasVerticallyMatch(expected, cells) ||
          _hasHorizontallyMatch(expected, cells) ||
          _hasDiagonallyMatch(expected, cells);
    };
  }

  static bool _hasHorizontallyMatch(
    List<String> expected,
    List<List<String>> cells,
  ) {
    for (var i = 0; i < cells.length; i++) {
      final match = [cells[i][0], cells[i][1], cells[i][2]];

      if (match.every(expected.contains)) {
        return true;
      }
    }

    return false;
  }

  static bool _hasVerticallyMatch(
    List<String> expected,
    List<List<String>> cells,
  ) {
    for (var i = 0; i < cells.length; i++) {
      final match = [cells[0][i], cells[1][i], cells[2][i]];

      if (match.every(expected.contains)) {
        return true;
      }
    }

    return false;
  }

  static bool _hasDiagonallyMatch(
    List<String> expected,
    List<List<String>> cells,
  ) {
    final matchLhs = [cells[0][0], cells[1][1], cells[2][2]];
    if (matchLhs.every(expected.contains)) {
      return true;
    }

    final matchRhs = [cells[2][0], cells[1][1], cells[0][2]];
    if (matchRhs.every(expected.contains)) {
      return true;
    }

    return false;
  }
}