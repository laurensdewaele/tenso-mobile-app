import 'package:flutter/cupertino.dart';

import 'package:app/helpers/nullable.dart';
import 'package:app/models/models.dart';

@immutable
class HoldPageState {
  final bool inputsEnabled;
  final Color primaryColor;
  final TextStyle textPrimaryColor;
  final String weightUnitDescription;

  final int totalHolds;
  final int currentHold;
  final int currentHoldIndex;
  final Board board;
  final bool countdownRestTimer;

  final HandHold handHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final int repetitions;
  final int countdownRestDuration;
  final int hangTime;
  final double addedWeight;

  final String repetitionsInput;
  final String countdownRestDurationInput;
  final String hangTimeInput;
  final String addedWeightInput;

  const HoldPageState({
    @required this.countdownRestTimer,
    @required this.currentHoldIndex,
    @required this.board,
    @required this.inputsEnabled,
    @required this.primaryColor,
    @required this.textPrimaryColor,
    @required this.weightUnitDescription,
    @required this.currentHold,
    @required this.totalHolds,
    @required this.handHold,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.repetitions,
    @required this.countdownRestDuration,
    @required this.hangTime,
    @required this.addedWeight,
    @required this.repetitionsInput,
    @required this.countdownRestDurationInput,
    @required this.hangTimeInput,
    @required this.addedWeightInput,
  });

  HoldPageState copyWith({
    bool countdownRestTimer,
    int currentHoldIndex,
    Board board,
    bool inputsEnabled,
    Color primaryColor,
    TextStyle textPrimaryColor,
    String weightUnitDescription,
    int currentHold,
    int totalHolds,
    HandHold handHold,
    Nullable<Grip> leftGrip,
    Nullable<Grip> rightGrip,
    Nullable<BoardHold> leftGripBoardHold,
    Nullable<BoardHold> rightGripBoardHold,
    int repetitions,
    Nullable<int> countdownRestDuration,
    int hangTime,
    double addedWeight,
    String repetitionsInput,
    String countdownRestDurationInput,
    String hangTimeInput,
    String addedWeightInput,
  }) {
    return new HoldPageState(
      countdownRestTimer: countdownRestTimer ?? this.countdownRestTimer,
      currentHoldIndex: currentHoldIndex ?? this.currentHoldIndex,
      board: board ?? this.board,
      inputsEnabled: inputsEnabled ?? this.inputsEnabled,
      primaryColor: primaryColor ?? this.primaryColor,
      textPrimaryColor: textPrimaryColor ?? this.textPrimaryColor,
      weightUnitDescription:
          weightUnitDescription ?? this.weightUnitDescription,
      currentHold: currentHold ?? this.currentHold,
      totalHolds: totalHolds ?? this.totalHolds,
      handHold: handHold ?? this.handHold,
      leftGrip: leftGrip == null ? this.leftGrip : leftGrip.value,
      rightGrip: rightGrip == null ? this.rightGrip : rightGrip.value,
      leftGripBoardHold: leftGripBoardHold == null
          ? this.leftGripBoardHold
          : leftGripBoardHold.value,
      rightGripBoardHold: rightGripBoardHold == null
          ? this.rightGripBoardHold
          : rightGripBoardHold.value,
      repetitions: repetitions ?? this.repetitions,
      countdownRestDuration: countdownRestDuration == null
          ? this.countdownRestDuration
          : countdownRestDuration.value,
      hangTime: hangTime ?? this.hangTime,
      addedWeight: addedWeight ?? this.addedWeight,
      repetitionsInput: repetitionsInput ?? this.repetitionsInput,
      countdownRestDurationInput:
          countdownRestDurationInput ?? this.countdownRestDurationInput,
      hangTimeInput: hangTimeInput ?? this.hangTimeInput,
      addedWeightInput: addedWeightInput ?? this.addedWeightInput,
    );
  }
}
