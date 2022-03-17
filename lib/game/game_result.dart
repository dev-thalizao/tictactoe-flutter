import 'package:equatable/equatable.dart';

class GameResult<Player> extends Equatable {
  final bool inProgress;
  final bool isDraw;
  final Player? winner;

  bool get isFinished => isDraw || winner != null;

  @override
  List<Object?> get props => [inProgress, isDraw, winner];

  const GameResult._({
    required this.inProgress,
    required this.isDraw,
    this.winner,
  });

  factory GameResult.inProgress() {
    return const GameResult._(
      inProgress: true,
      isDraw: false,
      winner: null,
    );
  }

  factory GameResult.over(Player winner) {
    return GameResult._(
      inProgress: false,
      isDraw: false,
      winner: winner,
    );
  }

  factory GameResult.draw() {
    return const GameResult._(
      inProgress: false,
      isDraw: true,
      winner: null,
    );
  }

  T when<T>({
    required T Function() inProgress,
    required T Function() draw,
    required T Function(Player winner) over,
  }) {
    if (winner != null) {
      return over(winner!);
    } else if (isDraw) {
      return draw();
    } else {
      return inProgress();
    }
  }
}
