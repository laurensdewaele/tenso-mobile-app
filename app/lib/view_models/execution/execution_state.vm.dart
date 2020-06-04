import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:flutter/widgets.dart';

class ExecutionState {
  final SequenceTimerType type;
  final bool isStopwatch;
  final int duration;
  final int seconds;
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
  final int totalSets;
  final int currentSet;
  final int totalHangsPerSet;
  final int currentHangPerSet;
  final int currentHang;
  final WeightSystem weightSystem;
  final double addedWeight;

  const ExecutionState({
    @required this.isStopwatch,
    @required this.type,
    @required this.duration,
    @required this.seconds,
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
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalHangsPerSet,
    @required this.weightSystem,
    @required this.addedWeight,
    @required this.currentHangPerSet,
    @required this.currentHang,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExecutionState &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          isStopwatch == other.isStopwatch &&
          duration == other.duration &&
          seconds == other.seconds &&
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
          totalSets == other.totalSets &&
          currentSet == other.currentSet &&
          totalHangsPerSet == other.totalHangsPerSet &&
          currentHangPerSet == other.currentHangPerSet &&
          currentHang == other.currentHang &&
          weightSystem == other.weightSystem &&
          addedWeight == other.addedWeight;

  @override
  int get hashCode =>
      type.hashCode ^
      isStopwatch.hashCode ^
      duration.hashCode ^
      seconds.hashCode ^
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
      totalSets.hashCode ^
      currentSet.hashCode ^
      totalHangsPerSet.hashCode ^
      currentHangPerSet.hashCode ^
      currentHang.hashCode ^
      weightSystem.hashCode ^
      addedWeight.hashCode;
}
