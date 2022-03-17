import 'package:equatable/equatable.dart';

class GameTurn<Player> extends Equatable {
  final int number;
  final Player player;

  @override
  List<Object?> get props => [number, player];

  const GameTurn({
    required this.number,
    required this.player,
  });

  factory GameTurn.start(Player player) => GameTurn(number: 1, player: player);
}
