import 'dart:ui';

import 'package:flutter/foundation.dart';

import 'package:app/models/models.dart';
import 'package:app/state/settings_state.dart';
import 'package:app/styles/styles.dart' as styles;

abstract class _ExecutionTitles {
  static const String preparation = 'preparation';
  static const String hang = 'hang';
  static const String recoveryRest = 'recovery rest';
}

abstract class _ExecutionHoldLabels {
  static const String nextUp = 'next up';
  // It needs to be empty, otherwise there's a shift in height across screens
  static const String hang = '';
}

enum SequenceTypes { hang, preparationRest, countdownRest, stopwatchRest }

class SequenceEvent {
  final SequenceTypes type;
  final int duration;

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
  final int currentHang;
  final WeightUnit weightUnit;
  final double addedWeight;

  const SequenceEvent({
    @required this.type,
    @required this.duration,
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
    @required this.currentHang,
    @required this.weightUnit,
    @required this.addedWeight,
  });

  SequenceEvent copyWith({
    SequenceTypes type,
    int duration,
    Sound endSound,
    Sound beepSound,
    int beepsBeforeEnd,
    Color primaryColor,
    String title,
    String holdLabel,
    Board board,
    Grip leftGrip,
    Grip rightGrip,
    BoardHold leftGripBoardHold,
    BoardHold rightGripBoardHold,
    int totalSets,
    int currentSet,
    int totalHangsPerSet,
    int currentHang,
    WeightUnit weightUnit,
    double addedWeight,
  }) {
    return new SequenceEvent(
      type: type ?? this.type,
      duration: duration ?? this.duration,
      endSound: endSound ?? this.endSound,
      beepSound: beepSound ?? this.beepSound,
      beepsBeforeEnd: beepsBeforeEnd ?? this.beepsBeforeEnd,
      primaryColor: primaryColor ?? this.primaryColor,
      title: title ?? this.title,
      holdLabel: holdLabel ?? this.holdLabel,
      board: board ?? this.board,
      leftGrip: leftGrip ?? this.leftGrip,
      rightGrip: rightGrip ?? this.rightGrip,
      leftGripBoardHold: leftGripBoardHold ?? this.leftGripBoardHold,
      rightGripBoardHold: rightGripBoardHold ?? this.rightGripBoardHold,
      totalSets: totalSets ?? this.totalSets,
      currentSet: currentSet ?? this.currentSet,
      totalHangsPerSet: totalHangsPerSet ?? this.totalHangsPerSet,
      currentHang: currentHang ?? this.currentHang,
      weightUnit: weightUnit ?? this.weightUnit,
      addedWeight: addedWeight ?? this.addedWeight,
    );
  }

  @override
  String toString() {
    return 'SequenceEvent{type: $type, duration: $duration, endSound: $endSound, beepSound: $beepSound, beepsBeforeEnd: $beepsBeforeEnd, primaryColor: $primaryColor, title: $title, holdLabel: $holdLabel, board: $board, leftGrip: $leftGrip, rightGrip: $rightGrip, leftGripBoardHold: $leftGripBoardHold, rightGripBoardHold: $rightGripBoardHold, totalSets: $totalSets, currentSet: $currentSet, totalHangsPerSet: $totalHangsPerSet, currentHang: $currentHang, weightUnit: $weightUnit, addedWeight: $addedWeight}';
  }
}

List<SequenceEvent> sequenceBuilder({@required Workout workout}) {
  Settings _settings = SettingsState().settings;
  Workout _workout = workout;
  List<SequenceEvent> _sequence = [];

  void _addPreparationRestSequence(
      int _currentSet, int _currentHoldIndex, int _currentHangPerSet) {
    _sequence.add(SequenceEvent(
        type: SequenceTypes.preparationRest,
        duration: _settings.preparationTimer,
        endSound: _settings.hangSound,
        beepSound: _settings.beepSound,
        beepsBeforeEnd: _settings.beepsBeforeHang,
        weightUnit: _workout.weightUnit,
        addedWeight: _workout.holds[_currentHoldIndex].addedWeight,
        primaryColor: styles.Colors.blue,
        title: _ExecutionTitles.preparation,
        holdLabel: _ExecutionHoldLabels.nextUp,
        board: _workout.board,
        leftGrip: _workout.holds[_currentHoldIndex].leftGrip,
        rightGrip: _workout.holds[_currentHoldIndex].rightGrip,
        leftGripBoardHold: _workout.holds[_currentHoldIndex].leftGripBoardHold,
        rightGripBoardHold:
            _workout.holds[_currentHoldIndex].rightGripBoardHold,
        totalSets: _workout.sets,
        currentSet: _currentSet,
        currentHang: _currentHangPerSet,
        totalHangsPerSet: workout.totalHangsPerSet));
  }

  void _addHangSequence(
      int _currentSet, int _currentHoldIndex, int _currentHangPerSet) {
    _sequence.add(
      SequenceEvent(
          type: SequenceTypes.hang,
          duration: _workout.holds[_currentHoldIndex].hangTime,
          endSound: _settings.restSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeRest,
          weightUnit: _workout.weightUnit,
          addedWeight: _workout.holds[_currentHoldIndex].addedWeight,
          primaryColor: styles.Colors.primary,
          title: _ExecutionTitles.hang,
          holdLabel: _ExecutionHoldLabels.hang,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHoldIndex].leftGrip,
          rightGrip: _workout.holds[_currentHoldIndex].rightGrip,
          leftGripBoardHold:
              _workout.holds[_currentHoldIndex].leftGripBoardHold,
          rightGripBoardHold:
              _workout.holds[_currentHoldIndex].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHangPerSet,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _addCountdownRestSequence(
      int _currentSet, int _currentHoldIndex, int _currentHangPerSet) {
    _sequence.add(
      SequenceEvent(
          type: SequenceTypes.countdownRest,
          duration: _workout.holds[_currentHoldIndex].countdownRestDuration,
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          weightUnit: _workout.weightUnit,
          addedWeight: _workout.holds[_currentHoldIndex].addedWeight,
          primaryColor: styles.Colors.blue,
          title: _ExecutionTitles.recoveryRest,
          holdLabel: _ExecutionHoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHoldIndex].leftGrip,
          rightGrip: _workout.holds[_currentHoldIndex].rightGrip,
          leftGripBoardHold:
              _workout.holds[_currentHoldIndex].leftGripBoardHold,
          rightGripBoardHold:
              _workout.holds[_currentHoldIndex].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHangPerSet,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _addStopwatchRestSequence(
      int _currentSet, int _currentHoldIndex, int _currentHangPerSet) {
    _sequence.add(
      SequenceEvent(
          type: SequenceTypes.stopwatchRest,
          duration: 0,
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          weightUnit: _workout.weightUnit,
          addedWeight: _workout.holds[_currentHoldIndex].addedWeight,
          primaryColor: styles.Colors.blue,
          title: _ExecutionTitles.recoveryRest,
          holdLabel: _ExecutionHoldLabels.nextUp,
          board: _workout.board,
          leftGrip: _workout.holds[_currentHoldIndex].leftGrip,
          rightGrip: _workout.holds[_currentHoldIndex].rightGrip,
          leftGripBoardHold:
              _workout.holds[_currentHoldIndex].leftGripBoardHold,
          rightGripBoardHold:
              _workout.holds[_currentHoldIndex].rightGripBoardHold,
          totalSets: _workout.sets,
          currentSet: _currentSet,
          currentHang: _currentHangPerSet,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _generate() {
    void Function(
            int _currentSet, int _currentHoldIndex, int _currentHangPerSet)
        _addRestSequence;

    if (_workout.stopwatchRestTimer) {
      _addRestSequence = _addStopwatchRestSequence;
    } else {
      _addRestSequence = _addCountdownRestSequence;
    }

    int _currentHang = 1;
    int _currentHangPerSet = 1;
    int _currentSet = 1;

    void _incrementSet() {
      _currentSet++;
      _currentHangPerSet = 1;
    }

    _addPreparationRestSequence(_currentSet, 0, _currentHangPerSet);

    while (_currentSet <= _workout.sets) {
      for (var _currentHold = 1;
          _currentHold <= _workout.holdCount;
          _currentHold++) {
        for (var _currentRepetitionPerHold = 1;
            _currentRepetitionPerHold <=
                _workout.holds[_currentHold - 1].repetitions;
            _currentRepetitionPerHold++) {
          if (_currentHang == 1) {
            _addHangSequence(_currentSet, _currentHold - 1, _currentHangPerSet);
          } else {
            _addRestSequence(_currentSet, _currentHold - 1, _currentHangPerSet);
            if (workout.stopwatchRestTimer) {
              _addPreparationRestSequence(
                  _currentSet, _currentHold - 1, _currentHangPerSet);
            }
            _addHangSequence(_currentSet, _currentHold - 1, _currentHangPerSet);
          }
          _currentHang++;
          _currentHangPerSet++;
        }
      }
      _incrementSet();
    }
  }

  _generate();

  return _sequence;
}
