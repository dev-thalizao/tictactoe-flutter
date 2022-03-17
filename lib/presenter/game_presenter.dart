import 'package:flutter/material.dart';

import '../tic_tac_toe/tic_tac_toe.dart';
import 'presenter.dart';

class GamePresenter {
  GamePresenter._();

  static GameViewModel map(TicTacToeGame game) {
    Color playerColor(String playerName) {
      return playerName == game.p1.name ? Colors.blue : Colors.pink;
    }

    final indexedCells =
        game.board.matrix.expand((cells) => cells).toList().asMap();

    return GameViewModel(
      currentTurnStatus: game.result.isFinished
          ? "Game finished"
          : "It's ${game.turn.player.name} turn",
      currentTurnColor: game.result.isFinished
          ? Colors.grey
          : playerColor(game.turn.player.name),
      gameStatus: game.result.when(
        inProgress: () => "🎮 Game in progres 🎮",
        draw: () => "🤺 It's a draw 🤺",
        over: (winner) => "🏆 Player $winner win🏆",
      ),
      cells: indexedCells.entries
          .map(
            (entry) => CellViewModel(
              value: entry.value.value,
              color: entry.value.value != null
                  ? playerColor(entry.value.value!)
                  : null,
            ),
          )
          .toList(),
    );
  }
}
