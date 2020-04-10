import 'package:flutter/cupertino.dart';

import 'package:app/models/models.dart';

@immutable
class HoldPageInitialState {
  final bool inputsEnabled;
  final Color primaryColor;

  final HandHold handHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final int repetitions;
  final int restBetweenRepetitions;
  final int hangTime;
  final double addedWeight;
  final Board board;
  final int currentHold;
  final int totalHolds;
  final TextStyle textPrimaryColor;
  final String weightUnitDescription;

  const HoldPageInitialState({
    @required this.inputsEnabled,
    @required this.primaryColor,
    @required this.handHold,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.repetitions,
    @required this.restBetweenRepetitions,
    @required this.hangTime,
    @required this.addedWeight,
    @required this.board,
    @required this.textPrimaryColor,
    @required this.totalHolds,
    @required this.currentHold,
    @required this.weightUnitDescription
  });
}

@immutable
class HoldPageInternalState {
  final int currentHoldIndex;

  final HandHold handHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final int repetitions;
  final int restBetweenRepetitions;
  final int hangTime;
  final double addedWeight;

  final String repetitionsInput;
  final String restBetweenRepetitionsInput;
  final String hangTimeInput;
  final String addedWeightInput;

  final Board board;

  const HoldPageInternalState(
      {@required this.currentHoldIndex,
      @required this.handHold,
      @required this.leftGrip,
      @required this.rightGrip,
      @required this.leftGripBoardHold,
      @required this.rightGripBoardHold,
      @required this.repetitions,
      @required this.restBetweenRepetitions,
      @required this.hangTime,
      @required this.addedWeight,
      @required this.repetitionsInput,
      @required this.restBetweenRepetitionsInput,
      @required this.hangTimeInput,
      @required this.addedWeightInput,
      @required this.board});

  HoldPageInternalState copyWith({
    int currentHoldIndex,
    HandHold handHold,
    Grip leftGrip,
    Grip rightGrip,
    BoardHold leftGripBoardHold,
    BoardHold rightGripBoardHold,
    int repetitions,
    int restBetweenRepetitions,
    int hangTime,
    double addedWeight,
    String repetitionsInput,
    String restBetweenRepetitionsInput,
    String hangTimeInput,
    String addedWeightInput,
    Board board,
  }) {
    return new HoldPageInternalState(
      currentHoldIndex: currentHoldIndex ?? this.currentHoldIndex,
      handHold: handHold ?? this.handHold,
      leftGrip: leftGrip ?? this.leftGrip,
      rightGrip: rightGrip ?? this.rightGrip,
      leftGripBoardHold: leftGripBoardHold ?? this.leftGripBoardHold,
      rightGripBoardHold: rightGripBoardHold ?? this.rightGripBoardHold,
      repetitions: repetitions ?? this.repetitions,
      restBetweenRepetitions:
          restBetweenRepetitions ?? this.restBetweenRepetitions,
      hangTime: hangTime ?? this.hangTime,
      addedWeight: addedWeight ?? this.addedWeight,
      repetitionsInput: repetitionsInput ?? this.repetitionsInput,
      restBetweenRepetitionsInput:
          restBetweenRepetitionsInput ?? this.restBetweenRepetitionsInput,
      hangTimeInput: hangTimeInput ?? this.hangTimeInput,
      addedWeightInput: addedWeightInput ?? this.addedWeightInput,
      board: board ?? this.board,
    );
  }
}
