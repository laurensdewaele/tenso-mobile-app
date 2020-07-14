import 'package:flutter/cupertino.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;
import 'package:tenso_app/view_models/workout/group.vm.dart';

@immutable
class GroupState {
  final GroupActions groupAction;
  final bool inputsEnabled;
  final Color primaryColor;
  final TextStyle textPrimaryColor;
  final String weightUnit;
  final String title;
  final String saveButtonText;

  final Board board;
  final List<Board> boards;

  final HandHold handHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;

  final bool repeaters;

  final int reps;
  final String repsInput;

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

  GroupState.addGroup(
      Group group, WeightSystem currentWeightSystem, List<Board> boards)
      : inputsEnabled = true,
        boards = boards,
        groupAction = GroupActions.addGroup,
        primaryColor = styles.Colors.primary,
        textPrimaryColor = styles.Lato.xsPrimary,
        title = 'Add group',
        saveButtonText = 'Add group',
        weightUnit = currentWeightSystem.unit,
        board = group.board,
        handHold = group.handHold,
        leftGrip = group.leftGrip,
        rightGrip = group.rightGrip,
        leftGripBoardHold = group.leftGripBoardHold,
        rightGripBoardHold = group.rightGripBoardHold,
        repeaters = group.repeaters,
        reps = group.reps,
        repsInput = group.reps.toString(),
        hangTimeS = group.hangTimeS,
        hangTimeSInput = group.hangTimeS.toString(),
        restBetweenRepsFixed = group.restBetweenRepsFixed,
        restBetweenRepsS = group.restBetweenRepsS,
        restBetweenRepsSInput = group.restBetweenRepsS.toString(),
        sets = group.sets,
        setsInput = group.sets.toString(),
        restBetweenSetsFixed = group.restBetweenSetsFixed,
        restBetweenSetsS = group.restBetweenSetsS,
        restBetweenSetsSInput = group.restBetweenSetsS.toString(),
        addedWeight = group.addedWeight,
        addedWeightInput = group.addedWeight.toString();

  GroupState.editGroup(
      Group group, WeightSystem currentWeightSystem, List<Board> boards)
      : inputsEnabled = true,
        boards = boards,
        groupAction = GroupActions.editGroup,
        saveButtonText = 'Save',
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
        reps = group.reps,
        repsInput = group.reps.toString(),
        hangTimeS = group.hangTimeS,
        hangTimeSInput = group.hangTimeS.toString(),
        restBetweenRepsFixed = group.restBetweenRepsFixed,
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
    @required this.boards,
    @required this.saveButtonText,
    @required this.groupAction,
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
    @required this.reps,
    @required this.repsInput,
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
    List<Board> boards,
    String saveButtonText,
    GroupActions groupAction,
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
    int reps,
    String repsInput,
    int hangTimeS,
    String hangTimeSInput,
    bool restBetweenRepsFixed,
    Nullable<int> restBetweenRepsS,
    Nullable<String> restBetweenRepsSInput,
    Nullable<int> sets,
    Nullable<String> setsInput,
    Nullable<bool> restBetweenSetsFixed,
    Nullable<int> restBetweenSetsS,
    Nullable<String> restBetweenSetsSInput,
    double addedWeight,
    String addedWeightInput,
  }) {
    return new GroupState(
      boards: boards ?? this.boards,
      saveButtonText: saveButtonText ?? this.saveButtonText,
      groupAction: groupAction ?? this.groupAction,
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
      reps: reps ?? this.reps,
      repsInput: repsInput ?? this.repsInput,
      hangTimeS: hangTimeS ?? this.hangTimeS,
      hangTimeSInput: hangTimeSInput ?? this.hangTimeSInput,
      restBetweenRepsFixed: restBetweenRepsFixed ?? this.restBetweenRepsFixed,
      restBetweenRepsS: restBetweenRepsS == null
          ? this.restBetweenRepsS
          : restBetweenRepsS.value,
      restBetweenRepsSInput: restBetweenRepsSInput == null
          ? this.restBetweenRepsSInput
          : restBetweenRepsSInput.value,
      sets: sets == null ? this.sets : sets.value,
      setsInput: setsInput == null ? this.setsInput : setsInput.value,
      restBetweenSetsFixed: restBetweenSetsFixed == null
          ? this.restBetweenSetsFixed
          : restBetweenSetsFixed.value,
      restBetweenSetsS: restBetweenSetsS == null
          ? this.restBetweenSetsS
          : restBetweenSetsS.value,
      restBetweenSetsSInput: restBetweenSetsSInput == null
          ? this.restBetweenSetsSInput
          : restBetweenSetsSInput.value,
      addedWeight: addedWeight ?? this.addedWeight,
      addedWeightInput: addedWeightInput ?? this.addedWeightInput,
    );
  }
}
