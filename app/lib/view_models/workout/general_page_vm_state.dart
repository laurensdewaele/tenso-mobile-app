import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:app/models/models.dart';

@immutable
class GeneralPageState {
  final int holdCount;
  final int sets;
  final int restBetweenHolds;
  final int restBetweenSets;
  final Board board;
  final String holdCountInput;
  final String setsInput;
  final String restBetweenHoldsInput;
  final String restBetweenSetsInput;

  final bool inputsEnabled;
  final Color primaryColor;

  const GeneralPageState({
    @required this.holdCount,
    @required this.sets,
    @required this.restBetweenHolds,
    @required this.restBetweenSets,
    @required this.board,
    @required this.holdCountInput,
    @required this.setsInput,
    @required this.restBetweenHoldsInput,
    @required this.restBetweenSetsInput,
    @required this.inputsEnabled,
    @required this.primaryColor,
  });

  GeneralPageState copyWith({
    int holdCount,
    int sets,
    int restBetweenHolds,
    int restBetweenSets,
    Board board,
    String holdCountInput,
    String setsInput,
    String restBetweenHoldsInput,
    String restBetweenSetsInput,
    bool inputsEnabled,
    Color primaryColor,
  }) {
    return new GeneralPageState(
      holdCount: holdCount ?? this.holdCount,
      sets: sets ?? this.sets,
      restBetweenHolds: restBetweenHolds ?? this.restBetweenHolds,
      restBetweenSets: restBetweenSets ?? this.restBetweenSets,
      board: board ?? this.board,
      holdCountInput: holdCountInput ?? this.holdCountInput,
      setsInput: setsInput ?? this.setsInput,
      restBetweenHoldsInput:
          restBetweenHoldsInput ?? this.restBetweenHoldsInput,
      restBetweenSetsInput: restBetweenSetsInput ?? this.restBetweenSetsInput,
      inputsEnabled: inputsEnabled ?? this.inputsEnabled,
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}
