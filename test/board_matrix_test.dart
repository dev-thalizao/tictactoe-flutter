import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_app/board/board.dart';

void main() {
  group("BoardMatrix", () {
    test(
      'Should select the center of the matrix',
      () {
        final board = BoardMatrix<bool>.nineBox();

        board.fill(
          index: BoardIndex(row: 1, collumn: 1),
          value: true,
        );

        expect(board.matrix, [
          [BoardCell.empty(), BoardCell.empty(), BoardCell.empty()],
          [BoardCell.empty(), BoardCell.filled(true), BoardCell.empty()],
          [BoardCell.empty(), BoardCell.empty(), BoardCell.empty()],
        ]);
      },
    );

    test(
      'Should not allow cell updates',
      () {
        final board = BoardMatrix<bool>.nineBox();

        board.fill(
          index: BoardIndex(row: 1, collumn: 1),
          value: false,
        );

        board.fill(
          index: BoardIndex(row: 0, collumn: 0),
          value: true,
        );

        board.fill(
          index: BoardIndex(row: 0, collumn: 0),
          value: false,
        );

        expect(board.matrix, [
          [BoardCell.filled(true), BoardCell.empty(), BoardCell.empty()],
          [BoardCell.empty(), BoardCell.filled(false), BoardCell.empty()],
          [BoardCell.empty(), BoardCell.empty(), BoardCell.empty()],
        ]);
      },
    );

    test(
      'Should not allow more updates if the board is full',
      () {
        final board = BoardMatrix<bool>.nineBox();

        expect(board.hasFullyFilled(), isFalse);

        board.fill(index: BoardIndex(row: 0, collumn: 0), value: true);

        expect(board.hasFullyFilled(), isFalse);

        for (var i = 0; i < 3; i++) {
          for (var j = 0; j < 3; j++) {
            board.fill(index: BoardIndex(row: i, collumn: j), value: true);
          }
        }

        expect(board.hasFullyFilled(), isTrue);
      },
    );
  });
}
