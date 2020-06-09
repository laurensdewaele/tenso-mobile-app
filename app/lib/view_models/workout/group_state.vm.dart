import 'package:app/helpers/nullable.dart';
import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/cupertino.dart';

@immutable
class GroupState {
  final bool inputsEnabled;
  final Color primaryColor;
  final TextStyle textPrimaryColor;
  final String weightUnit;
  final String title;

  final Board board;

  final HandHold handHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;

  final bool repeaters;

  final int repetitions;
  final String repetitionsInput;

  final int hangTimeS;
  final String hangTimeSInput;

  final bool restBetweenRepsFixed;
  final int restBetweenRepsS;
  final String restBetweenRepsSInput;

  final int sets;
  final String setsInput;

  final bool restBetweenSetsFixed;
  final int restBetweenSetsS;
  final String restBetweenSetsSInput;

  final double addedWeight;
  final String addedWeightInput;

  GroupState.addGroup(Group group, WeightSystem currentWeightSystem)
      : inputsEnabled = true,
        primaryColor = styles.Colors.primary,
        textPrimaryColor = styles.Lato.xsPrimary,
        title = 'Add group',
        weightUnit = currentWeightSystem.unit,
        board = group.board,
        handHold = group.handHold,
        leftGrip = group.leftGrip,
        rightGrip = group.rightGrip,
        leftGripBoardHold = group.leftGripBoardHold,
        rightGripBoardHold = group.rightGripBoardHold,
        repeaters = group.repeaters,
        repetitions = group.repetitions,
        repetitionsInput = group.repetitions.toString(),
        hangTimeS = group.hangTimeS,
        hangTimeSInput = group.hangTimeS.toString(),
        restBetweenRepsFixed = group.restBetweenSetsFixed,
        restBetweenRepsS = group.restBetweenRepsS,
        restBetweenRepsSInput = group.restBetweenRepsS.toString(),
        sets = group.sets,
        setsInput = group.sets.toString(),
        restBetweenSetsFixed = group.restBetweenSetsFixed,
        restBetweenSetsS = group.restBetweenSetsS,
        restBetweenSetsSInput = group.restBetweenSetsS.toString(),
        addedWeight = group.addedWeight,
        addedWeightInput = group.addedWeight.toString();

  GroupState.editGroup(Group group, WeightSystem currentWeightSystem)
      : inputsEnabled = true,
        primaryColor = styles.Colors.blue,
        textPrimaryColor = styles.Lato.xsBlue,
        title = 'Edit group',
        weightUnit = currentWeightSystem.unit,
        board = group.board,
        handHold = group.handHold,
        leftGrip = group.leftGrip,
        rightGrip = group.rightGrip,
        leftGripBoardHold = group.leftGripBoardHold,
        rightGripBoardHold = group.rightGripBoardHold,
        repeaters = group.repeaters,
        repetitions = group.repetitions,
        repetitionsInput = group.repetitions.toString(),
        hangTimeS = group.hangTimeS,
        hangTimeSInput = group.hangTimeS.toString(),
        restBetweenRepsFixed = group.restBetweenSetsFixed,
        restBetweenRepsS = group.restBetweenRepsS,
        restBetweenRepsSInput = group.restBetweenRepsS.toString(),
        sets = group.sets,
        setsInput = group.sets.toString(),
        restBetweenSetsFixed = group.restBetweenSetsFixed,
        restBetweenSetsS = group.restBetweenSetsS,
        restBetweenSetsSInput = group.restBetweenSetsS.toString(),
        addedWeight = group.addedWeight,
        addedWeightInput = group.addedWeight.toString();

  GroupState.viewGroup(Group group, WeightSystem workoutWeightSystem)
      : inputsEnabled = false,
        primaryColor = styles.Colors.gray,
        textPrimaryColor = styles.Lato.xsGray,
        title = 'View group',
        weightUnit = workoutWeightSystem.unit,
        board = group.board,
        handHold = group.handHold,
        leftGrip = group.leftGrip,
        rightGrip = group.rightGrip,
        leftGripBoardHold = group.leftGripBoardHold,
        rightGripBoardHold = group.rightGripBoardHold,
        repeaters = group.repeaters,
        repetitions = group.repetitions,
        repetitionsInput = group.repetitions.toString(),
        hangTimeS = group.hangTimeS,
        hangTimeSInput = group.hangTimeS.toString(),
        restBetweenRepsFixed = group.restBetweenSetsFixed,
        restBetweenRepsS = group.restBetweenRepsS,
        restBetweenRepsSInput = group.restBetweenRepsS.toString(),
        sets = group.sets,
        setsInput = group.sets.toString(),
        restBetweenSetsFixed = group.restBetweenSetsFixed,
        restBetweenSetsS = group.restBetweenSetsS,
        restBetweenSetsSInput = group.restBetweenSetsS.toString(),
        addedWeight = group.addedWeight,
        addedWeightInput = group.addedWeight.toString();

  const GroupState({
    @required this.title,
    @required this.inputsEnabled,
    @required this.primaryColor,
    @required this.textPrimaryColor,
    @required this.weightUnit,
    @required this.board,
    @required this.handHold,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.repeaters,
    @required this.repetitions,
    @required this.repetitionsInput,
    @required this.hangTimeS,
    @required this.hangTimeSInput,
    @required this.restBetweenRepsFixed,
    @required this.restBetweenRepsS,
    @required this.restBetweenRepsSInput,
    @required this.sets,
    @required this.setsInput,
    @required this.restBetweenSetsFixed,
    @required this.restBetweenSetsS,
    @required this.restBetweenSetsSInput,
    @required this.addedWeight,
    @required this.addedWeightInput,
  });

  GroupState copyWith({
    String title,
    bool inputsEnabled,
    Color primaryColor,
    TextStyle textPrimaryColor,
    String weightUnit,
    Board board,
    HandHold handHold,
    Nullable<Grip> leftGrip,
    Nullable<Grip> rightGrip,
    Nullable<BoardHold> leftGripBoardHold,
    Nullable<BoardHold> rightGripBoardHold,
    bool repeaters,
    int repetitions,
    String repetitionsInput,
    int hangTimeS,
    String hangTimeSInput,
    bool restBetweenRepsFixed,
    int restBetweenRepsS,
    String restBetweenRepsSInput,
    int sets,
    String setsInput,
    bool restBetweenSetsFixed,
    int restBetweenSetsS,
    String restBetweenSetsSInput,
    double addedWeight,
    String addedWeightInput,
  }) {
    return new GroupState(
      title: title ?? this.title,
      inputsEnabled: inputsEnabled ?? this.inputsEnabled,
      primaryColor: primaryColor ?? this.primaryColor,
      textPrimaryColor: textPrimaryColor ?? this.textPrimaryColor,
      weightUnit: weightUnit ?? this.weightUnit,
      board: board ?? this.board,
      handHold: handHold ?? this.handHold,
      leftGrip: leftGrip == null ? this.leftGrip : leftGrip.value,
      rightGrip: rightGrip == null ? this.rightGrip : rightGrip.value,
      leftGripBoardHold: leftGripBoardHold == null
          ? this.leftGripBoardHold
          : leftGripBoardHold.value,
      rightGripBoardHold: rightGripBoardHold == null
          ? this.rightGripBoardHold
          : rightGripBoardHold.value,
      repeaters: repeaters ?? this.repeaters,
      repetitions: repetitions ?? this.repetitions,
      repetitionsInput: repetitionsInput ?? this.repetitionsInput,
      hangTimeS: hangTimeS ?? this.hangTimeS,
      hangTimeSInput: hangTimeSInput ?? this.hangTimeSInput,
      restBetweenRepsFixed: restBetweenRepsFixed ?? this.restBetweenRepsFixed,
      restBetweenRepsS: restBetweenRepsS ?? this.restBetweenRepsS,
      restBetweenRepsSInput:
          restBetweenRepsSInput ?? this.restBetweenRepsSInput,
      sets: sets ?? this.sets,
      setsInput: setsInput ?? this.setsInput,
      restBetweenSetsFixed: restBetweenSetsFixed ?? this.restBetweenSetsFixed,
      restBetweenSetsS: restBetweenSetsS ?? this.restBetweenSetsS,
      restBetweenSetsSInput:
          restBetweenSetsSInput ?? this.restBetweenSetsSInput,
      addedWeight: addedWeight ?? this.addedWeight,
      addedWeightInput: addedWeightInput ?? this.addedWeightInput,
    );
  }
}
