import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'presenter.dart';

class GameViewModel extends Equatable {
  final String currentTurnStatus;
  final Color currentTurnColor;
  final String gameStatus;
  final List<CellViewModel> cells;

  int get crossAxisCount => cells.length ~/ 3;

  const GameViewModel({
    required this.currentTurnStatus,
    required this.currentTurnColor,
    required this.gameStatus,
    required this.cells,
  });

  @override
  List<Object?> get props => [
        currentTurnColor,
        currentTurnStatus,
        gameStatus,
        cells,
      ];
}
