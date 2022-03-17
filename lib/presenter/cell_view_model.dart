import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CellViewModel extends Equatable {
  final String? value;
  final Color? color;
  
  String get text => value ?? "";
  bool get isUnselected => value == null && color == null;
  bool get isSelected => !isUnselected;

  const CellViewModel({
    this.value,
    this.color,
  });

  @override
  List<Object?> get props => [value, color];
}
