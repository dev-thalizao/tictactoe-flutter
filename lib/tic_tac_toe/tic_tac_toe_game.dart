import 'package:tic_tac_toe_app/game/game_turn.dart';

import '../board/board.dart';
import '../game/game.dart';
import 'tic_tac_toe.dart';

class TicTacToeGame {
  final BoardMatrix<String> board;
  final GamePlayer<BoardIndex> p1;
  final GamePlayer<BoardIndex> p2;
  final TicTacToeMatcher<String> victoryMatcher;

  late GameResult<String> result;
  late GameTurn<GamePlayer<BoardIndex>> turn;

  TicTacToeGame._({
    required this.board,
    required this.p1,
    required this.p2,
    required this.victoryMatcher,
  });

  factory TicTacToeGame.start({required String player1, required String player2}) {
    final board = BoardMatrix<String>.nineBox();

    final game = TicTacToeGame._(
      board: board,
      p1: GamePlayer(
        name: player1,
        select: (index) => board.fill(index: index, value: player1),
      ),
      p2: GamePlayer(
        name: player2,
        select: (index) => board.fill(index: index, value: player2),
      ),
      victoryMatcher: TicTacToeBruteForce.matcher(),
    );

    game.turn = GameTurn.start(game.p1);
    game.result = GameResult.inProgress();

    return game;
  }

  void mark(BoardIndex index) {
    turn.player.select(index);

    if (victoryMatcher(turn.player.name, board)) {
      result = GameResult.over(turn.player.name);
    } else {
      if (board.hasFullyFilled()) {
        result = GameResult.draw();
      } else {
        turn = GameTurn(
          number: turn.number + 1,
          player: p1 == turn.player ? p2 : p1,
        );
      }
    }
  }
}
