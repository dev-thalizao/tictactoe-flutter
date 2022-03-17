import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:tic_tac_toe_app/board/board.dart';
import 'package:tic_tac_toe_app/presenter/presenter.dart';
import 'package:tic_tac_toe_app/tic_tac_toe/tic_tac_toe.dart';

void main() {
  group(
    "GamePresenter",
    () {
      test(
        'Initial state',
        () {
          final viewModel = GamePresenter.map(_anyGame());

          expect(viewModel.currentTurnStatus, "It's 1 turn");
          expect(viewModel.currentTurnColor, Colors.blue);
          expect(viewModel.gameStatus, "🎮 Game in progres 🎮");
          expect(viewModel.crossAxisCount, 3);

          expect(
            viewModel.cells.every((cell) => cell.isUnselected),
            isTrue,
          );
        },
      );

      test(
        "Should translate in progress game",
        () {
          final viewModel = GamePresenter.map(_anyInProgressGame());

          expect(viewModel.currentTurnStatus, "It's 2 turn");
          expect(viewModel.currentTurnColor, Colors.pink);
          expect(viewModel.gameStatus, "🎮 Game in progres 🎮");
        },
      );

      test(
        "Should translate drawed game",
        () {
          final viewModel = GamePresenter.map(_anyDrawedGame());

          expect(viewModel.currentTurnStatus, "Game finished");
          expect(viewModel.currentTurnColor, Colors.grey);
          expect(viewModel.gameStatus, "🤺 It's a draw 🤺");

          expect(
            viewModel.cells.every((cell) => cell.isSelected),
            isTrue,
          );
        },
      );

      test(
        "Should translate a completed game",
        () {
          final game = _anyCompletedGame();
          final viewModel = GamePresenter.map(game);

          expect(viewModel.currentTurnStatus, "Game finished");
          expect(viewModel.currentTurnColor, Colors.grey);
          expect(viewModel.gameStatus, "🏆 Player 1 win🏆");

          expect(viewModel.cells, [
            _anyPlayer2Cell(),
            _anyPlayer2Cell(),
            _anyPlayer1Cell(),
            _anyUnselectedCell(),
            _anyPlayer1Cell(),
            _anyUnselectedCell(),
            _anyPlayer1Cell(),
            _anyUnselectedCell(),
            _anyUnselectedCell(),
          ]);
        },
      );
    },
  );
}

CellViewModel _anyUnselectedCell() {
  return const CellViewModel();
}

CellViewModel _anyPlayer1Cell() {
  return CellViewModel(value: "1", color: _anyPlayer1Color());
}

CellViewModel _anyPlayer2Cell() {
  return CellViewModel(value: "2", color: _anyPlayer2Color());
}

Color _anyPlayer1Color() => Colors.blue;
Color _anyPlayer2Color() => Colors.pink;

TicTacToeGame _anyInProgressGame() {
  return _anyGame()
    ..mark(BoardIndex(row: 0, collumn: 0))
    ..mark(BoardIndex(row: 1, collumn: 1))
    ..mark(BoardIndex(row: 2, collumn: 2));
}

TicTacToeGame _anyDrawedGame() {
  return _anyGame()
    ..mark(BoardIndex(row: 0, collumn: 0))
    ..mark(BoardIndex(row: 1, collumn: 1))
    ..mark(BoardIndex(row: 2, collumn: 0))
    ..mark(BoardIndex(row: 1, collumn: 0))
    ..mark(BoardIndex(row: 1, collumn: 2))
    ..mark(BoardIndex(row: 2, collumn: 1))
    ..mark(BoardIndex(row: 0, collumn: 1))
    ..mark(BoardIndex(row: 0, collumn: 2))
    ..mark(BoardIndex(row: 2, collumn: 2));
}

TicTacToeGame _anyCompletedGame() {
  return _anyGame()
    ..mark(BoardIndex(row: 2, collumn: 0))
    ..mark(BoardIndex(row: 0, collumn: 0))
    ..mark(BoardIndex(row: 1, collumn: 1))
    ..mark(BoardIndex(row: 0, collumn: 1))
    ..mark(BoardIndex(row: 0, collumn: 2));
}

TicTacToeGame _anyGame() {
  return TicTacToeGame.start(player1: "1", player2: "2");
}
