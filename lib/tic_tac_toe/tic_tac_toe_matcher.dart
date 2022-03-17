import '../board/board.dart';

typedef TicTacToeMatcher<T> = bool Function(T player, BoardMatrix<T> board);
