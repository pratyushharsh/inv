import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class ThemeState extends Equatable {
  final ThemeData theme;
  final MaterialColor color;

  ThemeState({@required this.theme, @required this.color})
    : assert(theme != null),
      assert(color != null);

  @override
  // TODO: implement props
  List<Object> get props => [theme, color];
}

class InitialThemeState extends ThemeState {}
