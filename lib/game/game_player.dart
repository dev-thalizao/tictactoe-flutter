import 'package:equatable/equatable.dart';

class GamePlayer<Action> extends Equatable {
  final String name;
  final void Function(Action) select;

  @override
  List<Object?> get props => [name];

  const GamePlayer({
    required this.name,
    required this.select,
  });
}
