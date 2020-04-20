import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';

import 'package:app/models/models.dart';

@immutable
class GeneralPageState {
  final int holdCount;
  final String holdCountInput;
  final int sets;
  final String setsInput;
  final bool countdownRestTimer;
  final Board board;

  final bool inputsEnabled;
  final Color primaryColor;
  final TextStyle textPrimaryColor;

  GeneralPageState(
      {@required this.holdCount,
      @required this.holdCountInput,
      @required this.sets,
      @required this.setsInput,
      @required this.countdownRestTimer,
      @required this.board,
      @required this.inputsEnabled,
      @required this.primaryColor,
      @required this.textPrimaryColor});

  GeneralPageState copyWith({
    int holdCount,
    String holdCountInput,
    int sets,
    String setsInput,
    bool countdownRestTimer,
    Board board,
    bool inputsEnabled,
    Color primaryColor,
    TextStyle textPrimaryColor,
  }) {
    return new GeneralPageState(
      holdCount: holdCount ?? this.holdCount,
      holdCountInput: holdCountInput ?? this.holdCountInput,
      sets: sets ?? this.sets,
      setsInput: setsInput ?? this.setsInput,
      countdownRestTimer: countdownRestTimer ?? this.countdownRestTimer,
      board: board ?? this.board,
      inputsEnabled: inputsEnabled ?? this.inputsEnabled,
      primaryColor: primaryColor ?? this.primaryColor,
      textPrimaryColor: textPrimaryColor ?? this.textPrimaryColor,
    );
  }
}
