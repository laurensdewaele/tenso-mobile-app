import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';

class ExecutionState {
  final bool displayEndScreen;
  final SequenceTimerType type;
  final bool isVariableRestTimer;
  final int duration;
  final int displaySeconds;
  final double animatedBackgroundHeightFactor;
  final Sound endSound;
  final Sound beepSound;
  final int beepsBeforeEnd;
  final Color primaryColor;
  final String title;
  final String holdLabel;
  final Board board;
  final Grip leftGrip;
  final Grip rightGrip;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final WeightSystem weightSystem;
  final double addedWeight;
  final int totalGroups;
  final int currentGroup;
  final int totalSets;
  final int currentSet;
  final int totalReps;
  final int currentRep;

  const ExecutionState({
    @required this.displayEndScreen,
    @required this.type,
    @required this.isVariableRestTimer,
    @required this.duration,
    @required this.displaySeconds,
    @required this.animatedBackgroundHeightFactor,
    @required this.endSound,
    @required this.beepSound,
    @required this.beepsBeforeEnd,
    @required this.primaryColor,
    @required this.title,
    @required this.holdLabel,
    @required this.board,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.weightSystem,
    @required this.addedWeight,
    @required this.totalGroups,
    @required this.currentGroup,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalReps,
    @required this.currentRep,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExecutionState &&
          displayEndScreen == other.displayEndScreen &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          isVariableRestTimer == other.isVariableRestTimer &&
          duration == other.duration &&
          displaySeconds == other.displaySeconds &&
          animatedBackgroundHeightFactor ==
              other.animatedBackgroundHeightFactor &&
          endSound == other.endSound &&
          beepSound == other.beepSound &&
          beepsBeforeEnd == other.beepsBeforeEnd &&
          primaryColor == other.primaryColor &&
          title == other.title &&
          holdLabel == other.holdLabel &&
          board == other.board &&
          leftGrip == other.leftGrip &&
          rightGrip == other.rightGrip &&
          leftGripBoardHold == other.leftGripBoardHold &&
          rightGripBoardHold == other.rightGripBoardHold &&
          weightSystem == other.weightSystem &&
          addedWeight == other.addedWeight &&
          totalGroups == other.totalGroups &&
          currentGroup == other.currentGroup &&
          totalSets == other.totalSets &&
          currentSet == other.currentSet &&
          totalReps == other.totalReps &&
          currentRep == other.currentRep;

  @override
  int get hashCode =>
      displayEndScreen.hashCode ^
      type.hashCode ^
      isVariableRestTimer.hashCode ^
      duration.hashCode ^
      displaySeconds.hashCode ^
      animatedBackgroundHeightFactor.hashCode ^
      endSound.hashCode ^
      beepSound.hashCode ^
      beepsBeforeEnd.hashCode ^
      primaryColor.hashCode ^
      title.hashCode ^
      holdLabel.hashCode ^
      board.hashCode ^
      leftGrip.hashCode ^
      rightGrip.hashCode ^
      leftGripBoardHold.hashCode ^
      rightGripBoardHold.hashCode ^
      weightSystem.hashCode ^
      addedWeight.hashCode ^
      totalGroups.hashCode ^
      currentGroup.hashCode ^
      totalSets.hashCode ^
      currentSet.hashCode ^
      totalReps.hashCode ^
      currentRep.hashCode;

  ExecutionState copyWith({
    bool displayEndScreen,
    SequenceTimerType type,
    bool isVariableRestTimer,
    int duration,
    int displaySeconds,
    double animatedBackgroundHeightFactor,
    Sound endSound,
    Sound beepSound,
    int beepsBeforeEnd,
    Color primaryColor,
    String title,
    String holdLabel,
    Board board,
    Nullable<Grip> leftGrip,
    Nullable<Grip> rightGrip,
    Nullable<BoardHold> leftGripBoardHold,
    Nullable<BoardHold> rightGripBoardHold,
    WeightSystem weightSystem,
    double addedWeight,
    int totalGroups,
    int currentGroup,
    Nullable<int> totalSets,
    Nullable<int> currentSet,
    int totalReps,
    int currentRep,
  }) {
    return new ExecutionState(
      displayEndScreen: displayEndScreen ?? this.displayEndScreen,
      type: type ?? this.type,
      isVariableRestTimer: isVariableRestTimer ?? this.isVariableRestTimer,
      duration: duration ?? this.duration,
      displaySeconds: displaySeconds ?? this.displaySeconds,
      animatedBackgroundHeightFactor:
          animatedBackgroundHeightFactor ?? this.animatedBackgroundHeightFactor,
      endSound: endSound ?? this.endSound,
      beepSound: beepSound ?? this.beepSound,
      beepsBeforeEnd: beepsBeforeEnd ?? this.beepsBeforeEnd,
      primaryColor: primaryColor ?? this.primaryColor,
      title: title ?? this.title,
      holdLabel: holdLabel ?? this.holdLabel,
      board: board ?? this.board,
      leftGrip: leftGrip == null ? this.leftGrip : leftGrip,
      rightGrip: rightGrip == null ? this.rightGrip : rightGrip,
      leftGripBoardHold: leftGripBoardHold == null
          ? this.leftGripBoardHold
          : leftGripBoardHold,
      rightGripBoardHold: rightGripBoardHold == null
          ? this.rightGripBoardHold
          : rightGripBoardHold,
      weightSystem: weightSystem ?? this.weightSystem,
      addedWeight: addedWeight ?? this.addedWeight,
      totalGroups: totalGroups ?? this.totalGroups,
      currentGroup: currentGroup ?? this.currentGroup,
      totalSets: totalSets == null ? this.totalSets : totalSets,
      currentSet: currentSet == null ? this.currentSet : currentSet,
      totalReps: totalReps ?? this.totalReps,
      currentRep: currentRep ?? this.currentRep,
    );
  }
}
