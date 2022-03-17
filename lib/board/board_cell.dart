import 'package:equatable/equatable.dart';

class BoardCell<T> extends Equatable {
  final T? value;

  bool get isEmpty => value == null;
  bool get isNotEmpty => value != null;

  const BoardCell._(this.value);

  factory BoardCell.empty() => const BoardCell._(null);

  factory BoardCell.filled(T value) {
    return BoardCell._(value);
  }

  @override
  List<Object?> get props => [value];
}
