import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:app/models/models.dart';

@immutable
class GeneralPageInitialState {
  final bool inputsEnabled;
  final Color primaryColor;
  final int holdCount;
  final int sets;
  final int restBetweenHolds;
  final int restBetweenSets;
  final Board board;

  const GeneralPageInitialState({
    @required this.inputsEnabled,
    @required this.primaryColor,
    @required this.holdCount,
    @required this.sets,
    @required this.restBetweenHolds,
    @required this.restBetweenSets,
    @required this.board,
  });
}

class GeneralPageInternalState {
  final int holdCount;
  final int sets;
  final int restBetweenHolds;
  final int restBetweenSets;
  final Board board;
  final String holdCountInput;
  final String setsInput;
  final String restBetweenHoldsInput;
  final String restBetweenSetsInput;

  const GeneralPageInternalState({
    @required this.holdCount,
    @required this.sets,
    @required this.restBetweenHolds,
    @required this.restBetweenSets,
    @required this.board,
    @required this.holdCountInput,
    @required this.setsInput,
    @required this.restBetweenHoldsInput,
    @required this.restBetweenSetsInput,
  });

  GeneralPageInternalState copyWith({
    int holdCount,
    int sets,
    int restBetweenHolds,
    int restBetweenSets,
    Board board,
    String holdCountInput,
    String setsInput,
    String restBetweenHoldsInput,
    String restBetweenSetsInput,
  }) {
    return new GeneralPageInternalState(
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
    );
  }
}
