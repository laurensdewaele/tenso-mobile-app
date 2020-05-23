import 'dart:ui';

import 'package:app/models/models.dart';
import 'package:app/state/settings.state.dart';
import 'package:app/styles/styles.dart' as styles;
import 'package:flutter/foundation.dart';

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

class SequenceEvent {
  final ExecutionEventType type;
  final int duration;

  final Hold hold;
  final Sound endSound;
  final Sound beepSound;
  final int beepsBeforeEnd;
  final Color primaryColor;
  final String title;
  final String holdLabel;
  final Board board;
  final int totalSets;
  final int currentSet;
  final int totalHangsPerSet;
  final int currentHangPerSet;
  final int currentHang;
  final WeightSystem weightUnit;

  const SequenceEvent({
    @required this.type,
    @required this.duration,
    @required this.hold,
    @required this.endSound,
    @required this.beepSound,
    @required this.beepsBeforeEnd,
    @required this.primaryColor,
    @required this.title,
    @required this.holdLabel,
    @required this.board,
    @required this.totalSets,
    @required this.currentSet,
    @required this.totalHangsPerSet,
    @required this.currentHangPerSet,
    @required this.currentHang,
    @required this.weightUnit,
  });

  SequenceEvent copyWith({
    ExecutionEventType type,
    int duration,
    Hold hold,
    Sound endSound,
    Sound beepSound,
    int beepsBeforeEnd,
    Color primaryColor,
    String title,
    String holdLabel,
    Board board,
    int totalSets,
    int currentSet,
    int totalHangsPerSet,
    int currentHangPerSet,
    int currentHang,
    WeightSystem weightUnit,
  }) {
    return new SequenceEvent(
      type: type ?? this.type,
      duration: duration ?? this.duration,
      hold: hold ?? this.hold,
      endSound: endSound ?? this.endSound,
      beepSound: beepSound ?? this.beepSound,
      beepsBeforeEnd: beepsBeforeEnd ?? this.beepsBeforeEnd,
      primaryColor: primaryColor ?? this.primaryColor,
      title: title ?? this.title,
      holdLabel: holdLabel ?? this.holdLabel,
      board: board ?? this.board,
      totalSets: totalSets ?? this.totalSets,
      currentSet: currentSet ?? this.currentSet,
      totalHangsPerSet: totalHangsPerSet ?? this.totalHangsPerSet,
      currentHangPerSet: currentHangPerSet ?? this.currentHangPerSet,
      currentHang: currentHang ?? this.currentHang,
      weightUnit: weightUnit ?? this.weightUnit,
    );
  }
}

List<SequenceEvent> sequenceBuilder({@required Workout workout}) {
  Settings _settings = SettingsState().settings;
  Workout _workout = workout;
  List<SequenceEvent> _sequence = [];

  void _addPreparationRestSequence(
      {int currentSet,
      int currentHoldIndex,
      int currentHangPerSet,
      int currentHang}) {
    _sequence.add(SequenceEvent(
        hold: _workout.holds[currentHoldIndex],
        type: ExecutionEventType.preparationTimer,
        duration: _settings.preparationTimer,
        endSound: _settings.hangSound,
        beepSound: _settings.beepSound,
        beepsBeforeEnd: _settings.beepsBeforeHang,
        weightUnit: _workout.weightUnit,
        primaryColor: styles.Colors.blue,
        title: _ExecutionTitles.preparation,
        holdLabel: _ExecutionHoldLabels.nextUp,
        board: _workout.board,
        totalSets: _workout.sets,
        currentSet: currentSet,
        currentHangPerSet: currentHangPerSet,
        currentHang: currentHang,
        totalHangsPerSet: workout.totalHangsPerSet));
  }

  void _addHangSequence(
      {int currentSet,
      int currentHoldIndex,
      int currentHangPerSet,
      int currentHang}) {
    _sequence.add(
      SequenceEvent(
          hold: _workout.holds[currentHoldIndex],
          type: ExecutionEventType.hangTimer,
          duration: _workout.holds[currentHoldIndex].hangTime,
          endSound: _settings.restSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeRest,
          weightUnit: _workout.weightUnit,
          primaryColor: styles.Colors.primary,
          title: _ExecutionTitles.hang,
          holdLabel: _ExecutionHoldLabels.hang,
          board: _workout.board,
          totalSets: _workout.sets,
          currentSet: currentSet,
          currentHangPerSet: currentHangPerSet,
          currentHang: currentHang,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _addCountdownRestSequence(
      {int currentSet,
      int currentHoldIndex,
      int currentHangPerSet,
      int currentHang}) {
    _sequence.add(
      SequenceEvent(
          hold: _workout.holds[currentHoldIndex],
          type: ExecutionEventType.countdownRestTimer,
          duration: _workout.holds[currentHoldIndex].countdownRestDuration,
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          weightUnit: _workout.weightUnit,
          primaryColor: styles.Colors.blue,
          title: _ExecutionTitles.recoveryRest,
          holdLabel: _ExecutionHoldLabels.nextUp,
          board: _workout.board,
          totalSets: _workout.sets,
          currentSet: currentSet,
          currentHangPerSet: currentHangPerSet,
          currentHang: currentHang,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _addStopwatchRestSequence(
      {int currentSet,
      int currentHoldIndex,
      int currentHangPerSet,
      int currentHang}) {
    _sequence.add(
      SequenceEvent(
          hold: _workout.holds[currentHoldIndex],
          type: ExecutionEventType.stopwatchRestTimer,
          duration: 0,
          endSound: _settings.hangSound,
          beepSound: _settings.beepSound,
          beepsBeforeEnd: _settings.beepsBeforeHang,
          weightUnit: _workout.weightUnit,
          primaryColor: styles.Colors.blue,
          title: _ExecutionTitles.recoveryRest,
          holdLabel: _ExecutionHoldLabels.nextUp,
          board: _workout.board,
          totalSets: _workout.sets,
          currentSet: currentSet,
          currentHangPerSet: currentHangPerSet,
          currentHang: currentHang,
          totalHangsPerSet: workout.totalHangsPerSet),
    );
  }

  void _generate() {
    void Function(
        {int currentSet,
        int currentHoldIndex,
        int currentHangPerSet,
        int currentHang}) _addRestSequence;

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

    _addPreparationRestSequence(
        currentSet: _currentSet,
        currentHoldIndex: 0,
        currentHangPerSet: _currentHangPerSet,
        currentHang: _currentHang);

    while (_currentSet <= _workout.sets) {
      for (var _currentHold = 1;
          _currentHold <= _workout.holdCount;
          _currentHold++) {
        for (var _currentRepetitionPerHold = 1;
            _currentRepetitionPerHold <=
                _workout.holds[_currentHold - 1].repetitions;
            _currentRepetitionPerHold++) {
          if (_currentHang == 1) {
            _addHangSequence(
                currentSet: _currentSet,
                currentHoldIndex: _currentHold - 1,
                currentHangPerSet: _currentHangPerSet,
                currentHang: _currentHang);
          } else {
            _addRestSequence(
                currentSet: _currentSet,
                currentHoldIndex: _currentHold - 1,
                currentHangPerSet: _currentHangPerSet,
                currentHang: _currentHang);
            if (workout.stopwatchRestTimer) {
              _addPreparationRestSequence(
                  currentSet: _currentSet,
                  currentHoldIndex: _currentHold - 1,
                  currentHangPerSet: _currentHangPerSet,
                  currentHang: _currentHang);
            }
            _addHangSequence(
                currentSet: _currentSet,
                currentHoldIndex: _currentHold - 1,
                currentHangPerSet: _currentHangPerSet,
                currentHang: _currentHang);
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
