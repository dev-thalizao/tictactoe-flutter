import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe_app/board/board.dart';
import 'package:tic_tac_toe_app/game/game.dart';
import 'package:tic_tac_toe_app/game/game_turn.dart';
import 'package:tic_tac_toe_app/tic_tac_toe/tic_tac_toe.dart';

void main() {
  group(
    "TicTacToeGame",
    () {
      test(
        'Test initial state',
        () {
          final game = TicTacToeGame.start(player1: "X", player2: "O");
          expect(game.result, GameResult.inProgress());
          expect(game.turn, GameTurn.start(game.p1));
        },
      );

      test(
        "The third turn should belongs to player 1",
        () {
          final game = TicTacToeGame.start(player1: "X", player2: "O");
          game.mark(BoardIndex(row: 0, collumn: 0));
          expect(game.turn, GameTurn(number: 2, player: game.p2));

          game.mark(BoardIndex(row: 1, collumn: 1));
          expect(game.turn, GameTurn(number: 3, player: game.p1));

          expect(game.result, GameResult.inProgress());
        },
      );

      test(
        "This game should end in a draw",
        () {
          final game = TicTacToeGame.start(player1: "X", player2: "O");

          /**
           * X1 | X7 | O8
           * O4 | O2 | X5
           * X3 | O6 | X9
           */

          game
            ..mark(BoardIndex(row: 0, collumn: 0))
            ..mark(BoardIndex(row: 1, collumn: 1))
            ..mark(BoardIndex(row: 2, collumn: 0))
            ..mark(BoardIndex(row: 1, collumn: 0))
            ..mark(BoardIndex(row: 1, collumn: 2))
            ..mark(BoardIndex(row: 2, collumn: 1))
            ..mark(BoardIndex(row: 0, collumn: 1))
            ..mark(BoardIndex(row: 0, collumn: 2))
            ..mark(BoardIndex(row: 2, collumn: 2));

          expect(game.result, GameResult.draw());
          expect(game.turn.number, 9);
          expect(game.gameView, [
            ["X", "X", "O"],
            ["O", "O", "X"],
            ["X", "O", "X"],
          ]);
        },
      );

      test(
        "Player1 should win this game with a vertically combination",
        () {
          final game = TicTacToeGame.start(player1: "X", player2: "O");

          /**
           * 00 | X5 | 00
           * 00 | X1 | O2
           * 00 | X3 | O4
           */

          game
            ..mark(BoardIndex(row: 1, collumn: 1))
            ..mark(BoardIndex(row: 1, collumn: 2))
            ..mark(BoardIndex(row: 2, collumn: 1))
            ..mark(BoardIndex(row: 2, collumn: 2))
            ..mark(BoardIndex(row: 0, collumn: 1));

          expect(game.result, GameResult.over(game.p1.name));
          expect(game.turn.number, 5);
          expect(game.gameView, [
            ["", "X", ""],
            ["", "X", "O"],
            ["", "X", "O"],
          ]);
        },
      );

      test(
        "Player2 should win this game with a horizontally combination",
        () {
          final game = TicTacToeGame.start(player1: "X", player2: "O");

          /**
           * X1 | 00 | X5
           * 00 | X3 | 00
           * O2 | O6 | O4
           */

          game
            ..mark(BoardIndex(row: 0, collumn: 0))
            ..mark(BoardIndex(row: 2, collumn: 0))
            ..mark(BoardIndex(row: 1, collumn: 1))
            ..mark(BoardIndex(row: 2, collumn: 2))
            ..mark(BoardIndex(row: 0, collumn: 2))
            ..mark(BoardIndex(row: 2, collumn: 1));

          expect(game.result, GameResult.over(game.p2.name));
          expect(game.turn.number, 6);
          expect(game.gameView, [
            ["X", "", "X"],
            ["", "X", ""],
            ["O", "O", "O"],
          ]);
        },
      );

      test(
        "Player1 should win this game with a diagonally combination",
        () {
          final game = TicTacToeGame.start(player1: "X", player2: "O");

          /**
           * O2 | O4 | X5
           * 00 | X3 | 00
           * X1 | 00 | 00
           */

          game
            ..mark(BoardIndex(row: 2, collumn: 0))
            ..mark(BoardIndex(row: 0, collumn: 0))
            ..mark(BoardIndex(row: 1, collumn: 1))
            ..mark(BoardIndex(row: 0, collumn: 1))
            ..mark(BoardIndex(row: 0, collumn: 2));

          expect(game.result, GameResult.over(game.p1.name));
          expect(game.turn.number, 5);
          expect(game.gameView, [
            ["O", "O", "X"],
            ["", "X", ""],
            ["X", "", ""],
          ]);
        },
      );

      test(
        "Should not allow any change after the game has finished",
        () {
          final game = TicTacToeGame.start(player1: "X", player2: "O");

          /**
           * O2 | O4 | X5
           * 00 | X3 | 00
           * X1 | 00 | 00
           */

          game
            ..mark(BoardIndex(row: 2, collumn: 0))
            ..mark(BoardIndex(row: 0, collumn: 0))
            ..mark(BoardIndex(row: 1, collumn: 1))
            ..mark(BoardIndex(row: 0, collumn: 1))
            ..mark(BoardIndex(row: 0, collumn: 2));

          expect(game.result, GameResult.over(game.p1.name));
          expect(game.gameView, [
            ["O", "O", "X"],
            ["", "X", ""],
            ["X", "", ""],
          ]);

          game.mark(BoardIndex(row: 2, collumn: 2));
          expect(game.gameView, [
            ["O", "O", "X"],
            ["", "X", ""],
            ["X", "", ""],
          ]);
        },
      );
    },
  );
}

extension GameView on TicTacToeGame {
  List<List<String>> get gameView => board.matrix.map(
        (cells) {
          return cells
              .map((cell) => cell.isNotEmpty ? cell.value! : "")
              .toList();
        },
      ).toList();
}
