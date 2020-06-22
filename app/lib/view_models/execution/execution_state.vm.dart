import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:flutter/widgets.dart';

class ExecutionState {
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
}
