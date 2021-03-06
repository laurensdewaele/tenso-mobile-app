import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:tenso_app/helpers/nullable.dart';
import 'package:tenso_app/models/models.dart';
import 'package:tenso_app/styles/styles.dart' as styles;

abstract class _ExecutionTitles {
  static const String preparation = 'preparation';
  static const String hang = 'hang';
  static const String recoveryRest = 'recovery rest';
}

class SequenceTimer {
  final int index;
  final SequenceTimerType type;
  final int originalDurationS;
  final double effectiveDurationMs;
  final double originalAddedWeight;
  final double effectiveAddedWeight;
  final bool skipped;
  final bool stopped;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final Sound endSound;
  final Sound beepSound;
  final int beepsBeforeEnd;
  final Color primaryColor;
  final String title;
  final String holdLabel;
  final Board board;
  final int totalGroups;
  final int currentGroup;
  final int totalSets;
  final int currentSet;
  final int totalReps;
  final int currentRep;
  final WeightSystem weightSystem;

  const SequenceTimer({
    this.index,
    @required this.type,
    @required this.originalDurationS,
    @required this.effectiveDurationMs,
    @required this.originalAddedWeight,
    @required this.effectiveAddedWeight,
    @required this.skipped,
    @required this.stopped,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.endSound,
    @required this.beepSound,
    @required this.beepsBeforeEnd,
    @required this.primaryColor,
    @required this.title,
    @required this.holdLabel,
    @required this.board,
    @required this.totalGroups,
    @required this.currentGroup,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalReps,
    @required this.currentRep,
    @required this.weightSystem,
  });

  SequenceTimer copyWith({
    int index,
    SequenceTimerType type,
    int originalDurationS,
    double effectiveDurationMs,
    double originalAddedWeight,
    double effectiveAddedWeight,
    bool skipped,
    bool stopped,
    Nullable<BoardHold> leftGripBoardHold,
    Nullable<BoardHold> rightGripBoardHold,
    Nullable<Grip> leftGrip,
    Nullable<Grip> rightGrip,
    Sound endSound,
    Sound beepSound,
    int beepsBeforeEnd,
    Color primaryColor,
    String title,
    String holdLabel,
    Board board,
    int totalGroups,
    int currentGroup,
    int totalSets,
    int currentSet,
    int totalReps,
    int currentRep,
    WeightSystem weightSystem,
  }) {
    return new SequenceTimer(
      index: index ?? this.index,
      type: type ?? this.type,
      originalDurationS: originalDurationS ?? this.originalDurationS,
      effectiveDurationMs: effectiveDurationMs ?? this.effectiveDurationMs,
      originalAddedWeight: originalAddedWeight ?? this.originalAddedWeight,
      effectiveAddedWeight: effectiveAddedWeight ?? this.effectiveAddedWeight,
      skipped: skipped ?? this.skipped,
      stopped: stopped ?? this.stopped,
      leftGripBoardHold: leftGripBoardHold == null
          ? this.leftGripBoardHold
          : leftGripBoardHold.value,
      rightGripBoardHold: rightGripBoardHold == null
          ? this.rightGripBoardHold
          : rightGripBoardHold.value,
      leftGrip: leftGrip == null ? this.leftGrip : leftGrip.value,
      rightGrip: rightGrip == null ? this.rightGrip : rightGrip.value,
      endSound: endSound ?? this.endSound,
      beepSound: beepSound ?? this.beepSound,
      beepsBeforeEnd: beepsBeforeEnd ?? this.beepsBeforeEnd,
      primaryColor: primaryColor ?? this.primaryColor,
      title: title ?? this.title,
      holdLabel: holdLabel ?? this.holdLabel,
      board: board ?? this.board,
      totalGroups: totalGroups ?? this.totalGroups,
      currentGroup: currentGroup ?? this.currentGroup,
      totalSets: totalSets ?? this.totalSets,
      currentSet: currentSet ?? this.currentSet,
      totalReps: totalReps ?? this.totalReps,
      currentRep: currentRep ?? this.currentRep,
      weightSystem: weightSystem ?? this.weightSystem,
    );
  }
}

List<SequenceTimer> sequenceBuilder(
    {@required Workout workout, @required Settings settings}) {
  final String _restHoldLabel = 'next up';

  SequenceTimer _createPreparationTimer(
      {@required Group group,
      @required int currentGroup,
      @required int currentSet,
      @required int currentRep}) {
    return SequenceTimer(
        stopped: false,
        skipped: false,
        originalAddedWeight: group.addedWeight,
        effectiveAddedWeight: group.addedWeight,
        leftGripBoardHold: group.leftGripBoardHold,
        rightGripBoardHold: group.rightGripBoardHold,
        leftGrip: group.leftGrip,
        rightGrip: group.rightGrip,
        type: SequenceTimerType.preparationTimer,
        originalDurationS: settings.preparationTimer,
        effectiveDurationMs: (settings.preparationTimer * 1000).toDouble(),
        endSound: settings.hangSound,
        beepSound: settings.beepSound,
        beepsBeforeEnd: settings.beepsBeforeHang,
        weightSystem: workout.weightSystem,
        primaryColor: styles.Colors.blue,
        title: _ExecutionTitles.preparation,
        holdLabel: _restHoldLabel,
        board: group.board,
        totalSets: group.sets,
        currentSet: currentSet,
        totalReps: group.reps,
        currentRep: currentRep,
        currentGroup: currentGroup,
        totalGroups: workout.groups.length);
  }

  SequenceTimer _createHangTimer(
      {@required Group group,
      @required int currentGroup,
      @required int currentSet,
      @required int currentRep}) {
    return SequenceTimer(
        stopped: false,
        skipped: false,
        originalAddedWeight: group.addedWeight,
        effectiveAddedWeight: group.addedWeight,
        leftGripBoardHold: group.leftGripBoardHold,
        rightGripBoardHold: group.rightGripBoardHold,
        leftGrip: group.leftGrip,
        rightGrip: group.rightGrip,
        type: SequenceTimerType.hangTimer,
        originalDurationS: group.hangTimeS,
        effectiveDurationMs: (group.hangTimeS * 1000).toDouble(),
        endSound: settings.restSound,
        beepSound: settings.beepSound,
        beepsBeforeEnd: settings.beepsBeforeRest,
        weightSystem: workout.weightSystem,
        primaryColor: styles.Colors.primary,
        title: _ExecutionTitles.hang,
        holdLabel: '',
        board: group.board,
        totalSets: group.sets,
        currentSet: currentSet,
        totalReps: group.reps,
        currentRep: currentRep,
        currentGroup: currentGroup,
        totalGroups: workout.groups.length);
  }

  SequenceTimer _createFixedRestTimer(
      {@required Group group,
      @required int currentGroup,
      @required int currentSet,
      @required int currentRep,
      @required int duration}) {
    return SequenceTimer(
        skipped: false,
        stopped: false,
        originalAddedWeight: group.addedWeight,
        effectiveAddedWeight: group.addedWeight,
        leftGripBoardHold: group.leftGripBoardHold,
        rightGripBoardHold: group.rightGripBoardHold,
        leftGrip: group.leftGrip,
        rightGrip: group.rightGrip,
        type: SequenceTimerType.fixedRestTimer,
        originalDurationS: duration,
        effectiveDurationMs: (duration * 1000).toDouble(),
        endSound: settings.hangSound,
        beepSound: settings.beepSound,
        beepsBeforeEnd: settings.beepsBeforeHang,
        weightSystem: workout.weightSystem,
        primaryColor: styles.Colors.blue,
        title: _ExecutionTitles.recoveryRest,
        holdLabel: _restHoldLabel,
        board: group.board,
        totalSets: group.sets,
        currentSet: currentSet,
        totalReps: group.reps,
        currentRep: currentRep,
        currentGroup: currentGroup,
        totalGroups: workout.groups.length);
  }

  SequenceTimer _createVariableRestTimer(
      {@required Group group,
      @required int currentGroup,
      @required int currentSet,
      @required int currentRep}) {
    return SequenceTimer(
        stopped: false,
        skipped: false,
        originalAddedWeight: group.addedWeight,
        effectiveAddedWeight: group.addedWeight,
        leftGripBoardHold: group.leftGripBoardHold,
        rightGripBoardHold: group.rightGripBoardHold,
        leftGrip: group.leftGrip,
        rightGrip: group.rightGrip,
        type: SequenceTimerType.variableRestTimer,
        originalDurationS: 0,
        effectiveDurationMs: 0,
        endSound: settings.hangSound,
        beepSound: settings.beepSound,
        beepsBeforeEnd: settings.beepsBeforeHang,
        weightSystem: workout.weightSystem,
        primaryColor: styles.Colors.blue,
        title: _ExecutionTitles.recoveryRest,
        holdLabel: _restHoldLabel,
        board: group.board,
        totalSets: group.sets,
        currentSet: currentSet,
        totalReps: group.reps,
        currentRep: currentRep,
        currentGroup: currentGroup,
        totalGroups: workout.groups.length);
  }

  List<SequenceTimer> _createSequenceWithoutIndexes() {
    List<SequenceTimer> _createRestTimer(
        {@required bool fixed,
        @required Group group,
        @required int duration,
        @required int currentSet,
        @required int currentRep,
        @required int currentGroup}) {
      if (fixed == true) {
        return [
          _createFixedRestTimer(
              group: group,
              duration: duration,
              currentSet: currentSet,
              currentRep: currentRep,
              currentGroup: currentGroup)
        ];
      }
      return [
        _createVariableRestTimer(
            group: group,
            currentGroup: currentGroup,
            currentSet: currentSet,
            currentRep: currentRep),
        _createPreparationTimer(
            group: group,
            currentGroup: currentGroup,
            currentSet: currentSet,
            currentRep: currentRep)
      ];
    }

    List<SequenceTimer> _createSetSequence({
      @required Group group,
      @required int currentSet,
      @required int currentGroup,
    }) {
      List<List<SequenceTimer>> _setSequence = [];

      List.generate(group.reps, (i) => i).forEach((i) {
        _setSequence.add([
          _createHangTimer(
              group: group,
              currentRep: i + 1,
              currentSet: currentSet,
              currentGroup: currentGroup)
        ]);
        if (i != group.reps - 1) {
          _setSequence.add(_createRestTimer(
              fixed: group.restBetweenRepsFixed,
              duration: group.restBetweenRepsS,
              currentSet: currentSet,
              currentRep: i + 2,
              group: group,
              currentGroup: currentGroup));
        }
      });

      return _setSequence.expand((e) => e).toList();
    }

    List<SequenceTimer> _createGroupSequence(
        {@required Group group, @required int currentGroup}) {
      List<List<SequenceTimer>> _groupSequence = [];

      List.generate(group.sets ?? 1, (i) => i).forEach((i) {
        _groupSequence.add(_createSetSequence(
            currentGroup: currentGroup, group: group, currentSet: i + 1));
        if (group.sets != null && i != group.sets - 1) {
          _groupSequence.add(_createRestTimer(
              group: group,
              currentGroup: currentGroup,
              currentSet: i + 2,
              currentRep: 1,
              fixed: group.restBetweenSetsFixed,
              duration: group.restBetweenSetsS));
        }
      });

      return _groupSequence.expand((e) => e).toList();
    }

    List<SequenceTimer> createWorkoutSequence(Workout workout) {
      List<List<SequenceTimer>> _workoutSequence = [];

      _workoutSequence.add([
        _createPreparationTimer(
            group: workout.groups[0],
            currentGroup: 1,
            currentSet:
                workout.groups[0].sets != null && workout.groups[0].sets > 1
                    ? 1
                    : 0,
            currentRep: 1)
      ]);

      workout.groups.asMap().forEach((index, group) {
        _workoutSequence
            .add(_createGroupSequence(group: group, currentGroup: index + 1));
        if (index != workout.groups.length - 1) {
          final Group _nextGroup = workout.groups[index + 1];
          _workoutSequence.add(_createRestTimer(
              currentRep: 1,
              currentSet:
                  _nextGroup.sets != null && _nextGroup.sets > 1 ? 1 : null,
              fixed: workout.restBetweenGroupsFixed,
              currentGroup: index + 2,
              group: _nextGroup,
              duration: workout.restBetweenGroupsS));
        }
      });

      return _workoutSequence.expand((e) => e).toList();
    }

    return createWorkoutSequence(workout);
  }

  return _createSequenceWithoutIndexes()
      .asMap()
      .map((int index, SequenceTimer t) {
        return MapEntry(index, t.copyWith(index: index));
      })
      .values
      .toList();
}
