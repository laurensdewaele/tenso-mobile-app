import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/foundation.dart';

abstract class _ExecutionTitles {
  static const String preparation = 'preparation';
  static const String hang = 'hang';
  static const String recoveryRest = 'recovery rest';
}

class SequenceTimer {
  final int index;
  final SequenceTimerType type;
  final int duration;
  final double effectiveDurationMs;
  final bool skipped;
  final bool stopped;
  final BoardHold leftGripBoardHold;
  final BoardHold rightGripBoardHold;
  final Grip leftGrip;
  final Grip rightGrip;
  final double addedWeight;
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
    @required this.duration,
    @required this.effectiveDurationMs,
    @required this.skipped,
    @required this.stopped,
    @required this.leftGripBoardHold,
    @required this.rightGripBoardHold,
    @required this.leftGrip,
    @required this.rightGrip,
    @required this.addedWeight,
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
    int duration,
    double effectiveDurationMs,
    bool skipped,
    bool stopped,
    BoardHold leftGripBoardHold,
    BoardHold rightGripBoardHold,
    Grip leftGrip,
    Grip rightGrip,
    double addedWeight,
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
      duration: duration ?? this.duration,
      effectiveDurationMs: effectiveDurationMs ?? this.effectiveDurationMs,
      skipped: skipped ?? this.skipped,
      stopped: stopped ?? this.stopped,
      leftGripBoardHold: leftGripBoardHold ?? this.leftGripBoardHold,
      rightGripBoardHold: rightGripBoardHold ?? this.rightGripBoardHold,
      leftGrip: leftGrip ?? this.leftGrip,
      rightGrip: rightGrip ?? this.rightGrip,
      addedWeight: addedWeight ?? this.addedWeight,
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
  String _holdLabelText(
      {int currentRep, int totalReps, int currentSet, int totalSets}) {
    return 'next up: rep $currentRep/$totalReps ${totalSets != null && totalSets > 1 ? '$currentSet/$totalSets' : ''}';
  }

  SequenceTimer _createPreparationTimer(
      {@required Group group,
      @required int currentGroup,
      @required int currentSet,
      @required int currentRep}) {
    return SequenceTimer(
        stopped: false,
        skipped: false,
        addedWeight: group.addedWeight,
        leftGripBoardHold: group.leftGripBoardHold,
        rightGripBoardHold: group.rightGripBoardHold,
        leftGrip: group.leftGrip,
        rightGrip: group.rightGrip,
        type: SequenceTimerType.preparationTimer,
        duration: settings.preparationTimer,
        effectiveDurationMs: (settings.preparationTimer * 1000).toDouble(),
        endSound: settings.hangSound,
        beepSound: settings.beepSound,
        beepsBeforeEnd: settings.beepsBeforeHang,
        weightSystem: workout.weightSystem,
        primaryColor: styles.Colors.blue,
        title: _ExecutionTitles.preparation,
        holdLabel: _holdLabelText(
            currentRep: currentRep,
            totalReps: group.reps,
            currentSet: currentSet,
            totalSets: group.sets),
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
        addedWeight: group.addedWeight,
        leftGripBoardHold: group.leftGripBoardHold,
        rightGripBoardHold: group.rightGripBoardHold,
        leftGrip: group.leftGrip,
        rightGrip: group.rightGrip,
        type: SequenceTimerType.hangTimer,
        duration: group.hangTimeS,
        effectiveDurationMs: (group.hangTimeS * 1000).toDouble(),
        endSound: settings.restSound,
        beepSound: settings.beepSound,
        beepsBeforeEnd: settings.beepsBeforeRest,
        weightSystem: workout.weightSystem,
        primaryColor: styles.Colors.primary,
        title: _ExecutionTitles.hang,
        holdLabel: _holdLabelText(
            currentRep: currentRep,
            totalReps: group.reps,
            totalSets: group.sets,
            currentSet: currentSet),
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
        addedWeight: group.addedWeight,
        leftGripBoardHold: group.leftGripBoardHold,
        rightGripBoardHold: group.rightGripBoardHold,
        leftGrip: group.leftGrip,
        rightGrip: group.rightGrip,
        type: SequenceTimerType.fixedRestTimer,
        duration: duration,
        effectiveDurationMs: (duration * 1000).toDouble(),
        endSound: settings.hangSound,
        beepSound: settings.beepSound,
        beepsBeforeEnd: settings.beepsBeforeHang,
        weightSystem: workout.weightSystem,
        primaryColor: styles.Colors.blue,
        title: _ExecutionTitles.recoveryRest,
        holdLabel: _holdLabelText(
            currentRep: currentRep,
            totalReps: group.reps,
            totalSets: group.sets,
            currentSet: currentSet),
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
        addedWeight: group.addedWeight,
        leftGripBoardHold: group.leftGripBoardHold,
        rightGripBoardHold: group.rightGripBoardHold,
        leftGrip: group.leftGrip,
        rightGrip: group.rightGrip,
        type: SequenceTimerType.variableRestTimer,
        duration: 0,
        effectiveDurationMs: 0,
        endSound: settings.hangSound,
        beepSound: settings.beepSound,
        beepsBeforeEnd: settings.beepsBeforeHang,
        weightSystem: workout.weightSystem,
        primaryColor: styles.Colors.blue,
        title: _ExecutionTitles.recoveryRest,
        holdLabel: _holdLabelText(
            currentRep: currentRep,
            totalReps: group.reps,
            totalSets: group.sets,
            currentSet: currentSet),
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
              currentRep: i + 1,
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
              currentSet: i + 1,
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
          _workoutSequence.add(_createRestTimer(
              currentRep: 1,
              currentSet: group.sets != null && group.sets > 1 ? 1 : 0,
              fixed: workout.restBetweenGroupsFixed,
              currentGroup: index + 1,
              group: group,
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
